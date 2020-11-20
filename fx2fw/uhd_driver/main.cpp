/**
 * Copyright (C) 2009 Ubixum, Inc. 
 * Copyright (C) 2020 William Woods
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 **/

#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <semaphore.h>
#include <pthread.h>
#include <libusb-1.0/libusb.h>

#include "tuner_msi001.h"
#include "mirisdr_reg.h"
#include "transpose.h"

const uint16_t VID = 0x04b4;
const uint16_t PID = 0x8613;

const unsigned char EP2_IN_ADDR = LIBUSB_ENDPOINT_IN | 0x02;

// for asynchronous bulk transfers
#define N_CONCURRENT 10 
sem_t transfer_slots;
sem_t rbuff_slots;
sem_t fwrite_mutex;
bool write_raw_transposed = true;
// this handles each incoming usb packet when using the asynchronous libusb functions
void async_recv_cb(struct libusb_transfer* transfer) {
  sem_post(&transfer_slots);
  sem_wait(&fwrite_mutex);

  if (write_raw_transposed && transfer->actual_length == 507) {
    // TODO: alignment here maybe? might want to figure out where the data is being lost first though
    for (int i = 0; i < transfer->actual_length/13; i++) {
      uint16_t channels[8];
      transpose_ADC_reading(transfer->buffer + i*13 + 1, channels, false);

      float CH1[2];
      CH1[0] = (((float) channels[6]) - 2048.f) / 4096.f;
      CH1[1] = (((float) channels[7]) - 2048.f) / 4096.f;
      fwrite(CH1, sizeof(float), 2, stdout); // just write channel 1 (hacky)

      //fwrite(channels, 1, 16, stdout);
    }
  } else {
    fwrite(transfer->buffer, 1, transfer->actual_length, stdout);
  }

  sem_post(&fwrite_mutex);
  sem_post(&rbuff_slots);

  libusb_free_transfer(transfer);
}
bool libusb_event_thread_run = false;
void* libusb_event_thread_fn(void* ctx) {
  while (libusb_event_thread_run) {
    libusb_handle_events((libusb_context*) ctx);
  }
  printf("exiting libusb event thread!\n");
  return NULL;
}

// for sending data to the MSi001 chips, via a vendor command to the FX2LP
bool send_over_spi_bridge(libusb_device_handle* hndl, uint8_t channel_sel, uint8_t* data, uint8_t len) {
  // host to device | vendor command | recipient is an endpoint
  uint8_t bmRequestType = (0 << 7) | (2 << 5) | (2 << 0); 
  uint8_t bRequest = 0xB0; // the FX2LP FW recognises this as a command to send the data out over SPI
  uint16_t wValue = (uint16_t) channel_sel;

  int rv = libusb_control_transfer(
    hndl,
    bmRequestType,
    bRequest,
    wValue,
    0x0000,
    data,
    len,
    100
  );

  if (rv != len) {
    printf("Couldn't send over spi bridge. Libusb: %s\n", libusb_error_name(rv));
    return false;
  }

  return true;
}
// tuner_msi001.c makes calls to this fn to write to the MSi001 tuners
int mirisdr_reg_write_fn(void *dev, uint8_t reg, uint32_t val) {
  // FX2LP will send out each byte MSB first
  // However, we need to swap byte order so MSByte goes first 
  uint8_t data[3];
  data[0] = (val >> 16) & 0xFF;
  data[1] = (val >>  8) & 0xFF;
  data[2] = (val >>  0) & 0xFF;
  send_over_spi_bridge((libusb_device_handle*) dev, 0x0F, data, 3);
}

// testing out this msi001 tuner library
void do_msi001_lib_test(libusb_device_handle* hndl) {
  void* dev = (void*) hndl;
  uint32_t freq = 100000000;
  msi001_init(dev, freq);
}

int main(int argc, char* argv[]) {

  int rv;

  libusb_context* ctx;
  libusb_init(&ctx);
  
  // TODO: this is a "convenience function" not intended for final use
  // because if multiple devices share PID/VID then it only opens the first.
  //
  // Should be using lib_usb_get_device_list at some point before, and opening
  // that way.
  libusb_device_handle* hndl = libusb_open_device_with_vid_pid(ctx, VID, PID);
  if (hndl == NULL) {
    printf("Could not find device %4x:%4x\n", VID, PID);
    return -1;
  }

  rv = libusb_set_auto_detach_kernel_driver(hndl, 1);
  if (rv != 0) {
    printf("Found device, but could not auto-detach kernel driver! Continuing anway...\n");
  }

  // "instruct the underlying operating system that your application wishes to take ownership of the interface."
  rv = libusb_claim_interface(hndl, 0);
  if (rv != 0) {
    printf("Found device, but could not claim interface!\n");
    return -1;
  }

  rv = libusb_set_interface_alt_setting(hndl, 0, 0);
  if (rv != 0) {
    printf("Found device and claimed interface but could not set alt interface!\n");
    return -1;
  }

  // send control transfer if we have been called with them as args
  if (argc == 4) {
    // host to device | vendor command | recipient is an endpoint
    uint8_t bmRequestType = (0 << 7) | (2 << 5) | (2 << 0); 
    uint16_t wValue;
    uint8_t bRequest;

    unsigned int tmp;
    sscanf(argv[1], "0x%02x", &tmp);
    bRequest = tmp & (0xFF);

    sscanf(argv[2], "0x%04x", &tmp);
    wValue = tmp & (0xFFFF);

    uint8_t data[64];
    int i = 0;
    int chars_read = 0;
    for (;i < strlen(argv[3]); i += 2) {
      int n;
      sscanf(&(argv[3][i]), "%2hhx%n", data + i/2, &n);
      chars_read += n;
    }
    if (chars_read % 2) {
      printf("Expected even number of hex chars for data. Zero pad if necessary!\n");
      return -1;
    }
    uint8_t data_len = chars_read / 2; // in bytes
    //printf("Data is %d bytes long\n%s\n", data_len, (char*) data);

    rv = libusb_control_transfer(
      hndl,
      bmRequestType,
      bRequest,
      wValue,
      0x0000,
      data,
      data_len,
      500
    );

    if (rv != data_len) {
      printf("Couldn't send. Libusb: %s\n", libusb_error_name(rv));
      return -1;
    }
    return 0;

  } else {
/*
    uint8_t bmRequestType = (0 << 7) | (2 << 5) | (2 << 0); 
    uint8_t data[6] = "hello";
    rv = libusb_control_transfer(
      hndl,
      bmRequestType,
      0xB0,
      0x000F,
      0x0000,
      data,
      4,
      100
    );
    if (rv != 0) {
      printf("Couldn't send over spi bridge. Libusb: %s\n", libusb_error_name(rv));
      return false;
    }
*/
    do_msi001_lib_test(hndl);
  }

  if (argc == 2) {
    // stream to stdout (can pipe this into a file for later analysis, for example)

    if (strcmp(argv[1], "-t") == 0)
      write_raw_transposed = true;
    else
      write_raw_transposed = false;
    
    const int RBUFF_LEN = 2 * N_CONCURRENT;
    struct libusb_transfer* transfers_rbuff[RBUFF_LEN];
    unsigned char data_rbuff[RBUFF_LEN][507];
    int rbuff_head = 0;

    sem_init(&transfer_slots, 0, N_CONCURRENT);
    sem_init(&rbuff_slots, 0, RBUFF_LEN);
    sem_init(&fwrite_mutex, 0, 1);

    pthread_t event_thread;
    libusb_event_thread_run = true;
    pthread_create(&event_thread, NULL, libusb_event_thread_fn, ctx);

    while (1) {
      sem_wait(&rbuff_slots);
      sem_wait(&transfer_slots);
      
      // assume these transfers we launch come back in the same order
      transfers_rbuff[rbuff_head] = libusb_alloc_transfer(0);
      struct libusb_transfer* transfer = transfers_rbuff[rbuff_head];
      if (transfer == NULL) {
        printf("Couldn't allocate transfer.");
        sem_post(&transfer_slots);
        sem_post(&rbuff_slots);
        continue;
      }
      libusb_fill_bulk_transfer(transfer, hndl, EP2_IN_ADDR, data_rbuff[rbuff_head], 507,
                                async_recv_cb, NULL, 100);
      rv = libusb_submit_transfer(transfer);
      if (rv != 0) {
        printf("Couldn't submit transfer: %s\n", libusb_error_name(rv));
        libusb_free_transfer(transfer);
        sem_post(&transfer_slots);
        sem_post(&rbuff_slots);
        continue;
      }

      rbuff_head = (rbuff_head + 1) % RBUFF_LEN;
    }

    // TODO: proper termination of the event_thread
    //libusb_event_thread_run = false;
    //pthread_join(event_thread, NULL);
    
  } else if (argc == 1) {
    // print some lines of user-readable data

    unsigned char buf2[6*507];
    int nTransferred = 0;

    for (int i = 0; i < sizeof(buf2) / 507; i++) {
      // TODO: this is blocking; need to look into the async version
      rv = libusb_bulk_transfer(hndl, EP2_IN_ADDR, buf2 + i*507, 507, &nTransferred, 500);
      if (rv) {
        printf ( "IN Transfer failed: %d, transferred: %d\n", rv, nTransferred );
        return rv;
      }
    }

    // See what we read in
    printf("Read in %d bytes\n", nTransferred);
  /*
    // the raw hex we got
    for (int i=0;i<nTransferred;++i) {
      if (i % 13 == 0) printf("\n");
      printf ( "%02x ", buf2[i] );
    }
  */
    printf("\n");
    // transposed so we can see what each channel saw
    printf("n\tCH0\tCH1\tCH2\tCH3\tCH4\tCH5\tCH6\tCH7\n");
    for (int i = 0; i < sizeof(buf2)/13; i++) {
      uint16_t channels[8];
      transpose_ADC_reading(buf2 + i*13, channels, false);
      printf("%d:\t", i);
      for (int j = 0; j < 8; j++)
        printf("%03x\t", channels[j]);
      printf("\n");
    }
  } else {
    printf("Expected ./main [<bRequest> <wValue> <data>] or -[s|t]");
  }

  return 0;
}
