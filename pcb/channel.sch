EESchema Schematic File Version 4
LIBS:SDR_board-cache
EELAYER 26 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 2 2
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L RF_Amplifier:BGA2818 U?
U 1 1 5F48513F
P 2375 2025
F 0 "U?" H 2525 1925 50  0000 L CNN
F 1 "BGA2818" H 2400 1800 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 2325 1375 50  0001 C CNN
F 3 "https://www.nxp.com/docs/en/data-sheet/BGA2818.pdf" H 2375 2025 50  0001 C CNN
	1    2375 2025
	1    0    0    -1  
$EndComp
$Comp
L SDR_board-rescue:MSi001-Q40-MSi001 U?
U 1 1 5F485146
P 8350 3150
AR Path="/5F485146" Ref="U?"  Part="1" 
AR Path="/5F484F85/5F485146" Ref="U?"  Part="1" 
F 0 "U?" H 8375 3050 50  0000 C CNN
F 1 "MSi001-Q40" H 8350 3200 50  0000 C CNN
F 2 "Package_DFN_QFN:Texas_S-PVQFN-N40_EP4.15x4.15mm" V 9250 4850 50  0001 C CNN
F 3 "" V 9250 4850 50  0001 C CNN
	1    8350 3150
	1    0    0    -1  
$EndComp
$Comp
L MAX19777:MAX19777AZA+ U?
U 1 1 5F4853B9
P 14800 6750
F 0 "U?" H 14800 7520 50  0000 C CNN
F 1 "MAX19777AZA+" H 14800 7429 50  0000 C CNN
F 2 "BGA8N35P2X4_85X143X37N" H 14800 6750 50  0001 L BNN
F 3 "Unavailable" H 14800 6750 50  0001 L BNN
F 4 "None" H 14800 6750 50  0001 L BNN "Field4"
F 5 "IC ADC 12BIT 3MSPS 8WLP" H 14800 6750 50  0001 L BNN "Field5"
F 6 "WLP-8 Maxim" H 14800 6750 50  0001 L BNN "Field6"
F 7 "Maxim Integrated" H 14800 6750 50  0001 L BNN "Field7"
F 8 "MAX19777AZA+" H 14800 6750 50  0001 L BNN "Field8"
	1    14800 6750
	1    0    0    -1  
$EndComp
$Comp
L MAX19777:MAX19777AZA+ U?
U 1 1 5F485474
P 14800 8950
F 0 "U?" H 14800 9720 50  0000 C CNN
F 1 "MAX19777AZA+" H 14800 9629 50  0000 C CNN
F 2 "BGA8N35P2X4_85X143X37N" H 14800 8950 50  0001 L BNN
F 3 "Unavailable" H 14800 8950 50  0001 L BNN
F 4 "None" H 14800 8950 50  0001 L BNN "Field4"
F 5 "IC ADC 12BIT 3MSPS 8WLP" H 14800 8950 50  0001 L BNN "Field5"
F 6 "WLP-8 Maxim" H 14800 8950 50  0001 L BNN "Field6"
F 7 "Maxim Integrated" H 14800 8950 50  0001 L BNN "Field7"
F 8 "MAX19777AZA+" H 14800 8950 50  0001 L BNN "Field8"
	1    14800 8950
	1    0    0    -1  
$EndComp
Text GLabel 14100 6850 0    50   Input ~ 0
ADC_CLK
Text GLabel 14100 9050 0    50   Input ~ 0
ADC_CLK
Text GLabel 14100 6350 0    50   Input ~ 0
ADC_nCS
Text GLabel 14100 8550 0    50   Input ~ 0
ADC_nCS
$Comp
L Connector_Generic_Shielded:Conn_01x01_Shielded J?
U 1 1 5F485AF9
P 950 2025
F 0 "J?" H 1075 2250 50  0000 C CNN
F 1 "Molex 73251-1150 SMA" V 1200 2025 50  0000 C CNN
F 2 "" H 950 2025 50  0001 C CNN
F 3 "~" H 950 2025 50  0001 C CNN
	1    950  2025
	-1   0    0    -1  
$EndComp
$Comp
L power:+3.3VA #PWR?
U 1 1 5F485CF1
P 2275 1300
F 0 "#PWR?" H 2275 1150 50  0001 C CNN
F 1 "+3.3VA" H 2290 1473 50  0000 C CNN
F 2 "" H 2275 1300 50  0001 C CNN
F 3 "" H 2275 1300 50  0001 C CNN
	1    2275 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2275 1300 2275 1400
$Comp
L power:GND #PWR?
U 1 1 5F485DD2
P 2275 2675
F 0 "#PWR?" H 2275 2425 50  0001 C CNN
F 1 "GND" H 2280 2502 50  0000 C CNN
F 2 "" H 2275 2675 50  0001 C CNN
F 3 "" H 2275 2675 50  0001 C CNN
	1    2275 2675
	1    0    0    -1  
$EndComp
Wire Wire Line
	2275 2325 2275 2675
$Comp
L Device:C_Small C?
U 1 1 5F485EEE
P 1950 1500
F 0 "C?" H 2042 1546 50  0000 L CNN
F 1 "22nF" H 2042 1455 50  0000 L CNN
F 2 "" H 1950 1500 50  0001 C CNN
F 3 "~" H 1950 1500 50  0001 C CNN
	1    1950 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 1400 2275 1400
Connection ~ 2275 1400
$Comp
L power:GND #PWR?
U 1 1 5F48628E
P 950 2225
F 0 "#PWR?" H 950 1975 50  0001 C CNN
F 1 "GND" H 955 2052 50  0000 C CNN
F 2 "" H 950 2225 50  0001 C CNN
F 3 "" H 950 2225 50  0001 C CNN
	1    950  2225
	1    0    0    -1  
$EndComp
Wire Wire Line
	2275 1400 2275 1725
$Comp
L power:GND #PWR?
U 1 1 5F486BFD
P 1950 1600
F 0 "#PWR?" H 1950 1350 50  0001 C CNN
F 1 "GND" H 1955 1427 50  0000 C CNN
F 2 "" H 1950 1600 50  0001 C CNN
F 3 "" H 1950 1600 50  0001 C CNN
	1    1950 1600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F487113
P 15500 7150
F 0 "#PWR?" H 15500 6900 50  0001 C CNN
F 1 "GND" H 15505 6977 50  0000 C CNN
F 2 "" H 15500 7150 50  0001 C CNN
F 3 "" H 15500 7150 50  0001 C CNN
	1    15500 7150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F487195
P 15500 9350
F 0 "#PWR?" H 15500 9100 50  0001 C CNN
F 1 "GND" H 15505 9177 50  0000 C CNN
F 2 "" H 15500 9350 50  0001 C CNN
F 3 "" H 15500 9350 50  0001 C CNN
	1    15500 9350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F4875D5
P 9650 4050
F 0 "#PWR?" H 9650 3800 50  0001 C CNN
F 1 "GND" H 9655 3877 50  0000 C CNN
F 2 "" H 9650 4050 50  0001 C CNN
F 3 "" H 9650 4050 50  0001 C CNN
	1    9650 4050
	1    0    0    -1  
$EndComp
NoConn ~ 9650 3950
NoConn ~ 9650 3850
Text GLabel 9650 3550 2    50   Input ~ 0
TUNER_SPI_MOSI
Text GLabel 9650 3400 2    50   Input ~ 0
TUNER_SPI_CLK
Text HLabel 9650 3250 2    50   Input ~ 0
TUNER_SPI_nCS
Text HLabel 15500 6750 2    50   Input ~ 0
I_DOUT
Text HLabel 15500 8950 2    50   Input ~ 0
Q_DOUT
$Comp
L opamps:LMV712-N U?
U 2 1 5F49B14F
P 12200 8750
F 0 "U?" H 12200 9117 50  0000 C CNN
F 1 "LMV712-N" H 12200 9026 50  0000 C CNN
F 2 "Package_SO:MSOP-10_3x3mm_P0.5mm" H 12000 9550 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/lmv712-n.pdf" H 12050 9700 50  0001 C CNN
	2    12200 8750
	1    0    0    -1  
$EndComp
$Comp
L opamps:LMV712-N U?
U 3 1 5F49B1F8
P 10700 10375
F 0 "U?" H 10550 10425 50  0000 L CNN
F 1 "LMV712-N" H 10525 10325 50  0000 L CNN
F 2 "Package_SO:MSOP-10_3x3mm_P0.5mm" H 10500 11175 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/lmv712-n.pdf" H 10550 11325 50  0001 C CNN
	3    10700 10375
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R?
U 1 1 5F49C81C
P 12750 8750
F 0 "R?" V 12554 8750 50  0000 C CNN
F 1 "0R" V 12645 8750 50  0000 C CNN
F 2 "" H 12750 8750 50  0001 C CNN
F 3 "~" H 12750 8750 50  0001 C CNN
	1    12750 8750
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5F49C9BC
P 13000 8925
F 0 "C?" H 13092 8971 50  0000 L CNN
F 1 "100pF" H 13092 8880 50  0000 L CNN
F 2 "" H 13000 8925 50  0001 C CNN
F 3 "~" H 13000 8925 50  0001 C CNN
	1    13000 8925
	1    0    0    -1  
$EndComp
Wire Wire Line
	13000 8825 13000 8750
$Comp
L power:GND #PWR?
U 1 1 5F49CE44
P 13000 9100
F 0 "#PWR?" H 13000 8850 50  0001 C CNN
F 1 "GND" H 13005 8927 50  0000 C CNN
F 2 "" H 13000 9100 50  0001 C CNN
F 3 "" H 13000 9100 50  0001 C CNN
	1    13000 9100
	1    0    0    -1  
$EndComp
Wire Wire Line
	13000 9025 13000 9100
Wire Wire Line
	12500 8750 12575 8750
$Comp
L Device:R_Small R?
U 1 1 5F49D067
P 12200 9325
F 0 "R?" V 12004 9325 50  0000 C CNN
F 1 "10k" V 12095 9325 50  0000 C CNN
F 2 "" H 12200 9325 50  0001 C CNN
F 3 "~" H 12200 9325 50  0001 C CNN
	1    12200 9325
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R?
U 1 1 5F49D16F
P 11575 9325
F 0 "R?" V 11379 9325 50  0000 C CNN
F 1 "40k" V 11470 9325 50  0000 C CNN
F 2 "" H 11575 9325 50  0001 C CNN
F 3 "~" H 11575 9325 50  0001 C CNN
	1    11575 9325
	0    1    1    0   
$EndComp
Wire Wire Line
	12300 9325 12575 9325
Wire Wire Line
	12575 9325 12575 8750
Connection ~ 12575 8750
Wire Wire Line
	12575 8750 12650 8750
Wire Wire Line
	12100 9325 11825 9325
Wire Wire Line
	11900 8850 11825 8850
Wire Wire Line
	11825 8850 11825 9325
Connection ~ 11825 9325
Wire Wire Line
	11825 9325 11675 9325
Text Label 11225 9325 0    50   ~ 0
Q_N
Wire Wire Line
	11475 9325 11225 9325
$Comp
L Device:R_Small R?
U 1 1 5F49DC49
P 11575 8725
F 0 "R?" H 11516 8679 50  0000 R CNN
F 1 "20k" H 11516 8770 50  0000 R CNN
F 2 "" H 11575 8725 50  0001 C CNN
F 3 "~" H 11575 8725 50  0001 C CNN
	1    11575 8725
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Small R?
U 1 1 5F49DC4F
P 11325 8575
F 0 "R?" V 11129 8575 50  0000 C CNN
F 1 "0R" V 11220 8575 50  0000 C CNN
F 2 "" H 11325 8575 50  0001 C CNN
F 3 "~" H 11325 8575 50  0001 C CNN
	1    11325 8575
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F49E159
P 11575 8825
F 0 "#PWR?" H 11575 8575 50  0001 C CNN
F 1 "GND" H 11580 8652 50  0000 C CNN
F 2 "" H 11575 8825 50  0001 C CNN
F 3 "" H 11575 8825 50  0001 C CNN
	1    11575 8825
	1    0    0    -1  
$EndComp
Wire Wire Line
	11425 8575 11575 8575
Wire Wire Line
	11575 8575 11575 8625
Wire Wire Line
	11575 8575 11900 8575
Wire Wire Line
	11900 8575 11900 8650
Connection ~ 11575 8575
Text Label 11000 8550 0    50   ~ 0
Q_P
Wire Wire Line
	11225 8575 11000 8575
Wire Wire Line
	11000 8575 11000 8550
$Comp
L opamps:LMV712-N U?
U 1 1 5F49B0D7
P 12200 6550
F 0 "U?" H 12200 6917 50  0000 C CNN
F 1 "LMV712-N" H 12200 6826 50  0000 C CNN
F 2 "Package_SO:MSOP-10_3x3mm_P0.5mm" H 12000 7350 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/lmv712-n.pdf" H 12050 7500 50  0001 C CNN
	1    12200 6550
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R?
U 1 1 5F4A14AD
P 12750 6550
F 0 "R?" V 12554 6550 50  0000 C CNN
F 1 "0R" V 12645 6550 50  0000 C CNN
F 2 "" H 12750 6550 50  0001 C CNN
F 3 "~" H 12750 6550 50  0001 C CNN
	1    12750 6550
	0    1    1    0   
$EndComp
Wire Wire Line
	12500 6550 12575 6550
$Comp
L Device:R_Small R?
U 1 1 5F4A14C5
P 12200 7125
F 0 "R?" V 12004 7125 50  0000 C CNN
F 1 "10k" V 12095 7125 50  0000 C CNN
F 2 "" H 12200 7125 50  0001 C CNN
F 3 "~" H 12200 7125 50  0001 C CNN
	1    12200 7125
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R?
U 1 1 5F4A14CB
P 11575 7125
F 0 "R?" V 11379 7125 50  0000 C CNN
F 1 "40k" V 11470 7125 50  0000 C CNN
F 2 "" H 11575 7125 50  0001 C CNN
F 3 "~" H 11575 7125 50  0001 C CNN
	1    11575 7125
	0    1    1    0   
$EndComp
Wire Wire Line
	12300 7125 12575 7125
Wire Wire Line
	12575 7125 12575 6550
Connection ~ 12575 6550
Wire Wire Line
	12575 6550 12650 6550
Wire Wire Line
	12100 7125 11825 7125
Wire Wire Line
	11900 6650 11825 6650
Wire Wire Line
	11825 6650 11825 7125
Connection ~ 11825 7125
Wire Wire Line
	11825 7125 11675 7125
Text Label 11225 7125 0    50   ~ 0
I_N
Wire Wire Line
	11475 7125 11225 7125
$Comp
L Device:R_Small R?
U 1 1 5F4A14DC
P 11575 6525
F 0 "R?" H 11516 6479 50  0000 R CNN
F 1 "20k" H 11516 6570 50  0000 R CNN
F 2 "" H 11575 6525 50  0001 C CNN
F 3 "~" H 11575 6525 50  0001 C CNN
	1    11575 6525
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Small R?
U 1 1 5F4A14E2
P 11325 6375
F 0 "R?" V 11129 6375 50  0000 C CNN
F 1 "0R" V 11220 6375 50  0000 C CNN
F 2 "" H 11325 6375 50  0001 C CNN
F 3 "~" H 11325 6375 50  0001 C CNN
	1    11325 6375
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F4A14E8
P 11575 6625
F 0 "#PWR?" H 11575 6375 50  0001 C CNN
F 1 "GND" H 11580 6452 50  0000 C CNN
F 2 "" H 11575 6625 50  0001 C CNN
F 3 "" H 11575 6625 50  0001 C CNN
	1    11575 6625
	1    0    0    -1  
$EndComp
Wire Wire Line
	11425 6375 11575 6375
Wire Wire Line
	11575 6375 11575 6425
Wire Wire Line
	11575 6375 11900 6375
Wire Wire Line
	11900 6375 11900 6450
Connection ~ 11575 6375
Text Label 11000 6350 0    50   ~ 0
I_P
Wire Wire Line
	11225 6375 11000 6375
Wire Wire Line
	11000 6375 11000 6350
Text Label 9900 2100 0    50   ~ 0
I_P
Text Label 9900 2300 0    50   ~ 0
I_N
Text Label 9900 2700 0    50   ~ 0
Q_P
Text Label 9900 2500 0    50   ~ 0
Q_N
Wire Wire Line
	9650 2100 9900 2100
Wire Wire Line
	9650 2300 9900 2300
Wire Wire Line
	9650 2500 9900 2500
Wire Wire Line
	9650 2700 9900 2700
Wire Wire Line
	15500 8450 15600 8450
Wire Wire Line
	15600 8450 15600 8375
Wire Wire Line
	15500 6250 15575 6250
Wire Wire Line
	15575 6250 15575 6175
$Comp
L power:GND #PWR?
U 1 1 5F4A7F98
P 14100 9250
F 0 "#PWR?" H 14100 9000 50  0001 C CNN
F 1 "GND" H 14105 9077 50  0000 C CNN
F 2 "" H 14100 9250 50  0001 C CNN
F 3 "" H 14100 9250 50  0001 C CNN
	1    14100 9250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F4A7FFF
P 14100 7050
F 0 "#PWR?" H 14100 6800 50  0001 C CNN
F 1 "GND" H 14105 6877 50  0000 C CNN
F 2 "" H 14100 7050 50  0001 C CNN
F 3 "" H 14100 7050 50  0001 C CNN
	1    14100 7050
	1    0    0    -1  
$EndComp
Text Notes 12775 9775 0    50   ~ 0
NOTE: to leave the option of using AIN2,\nlayout the CHSEL trace so it can be cut & pulled high
Text Notes 11825 5850 0    50   ~ 0
LMV712-N can handle capacitive loads of up to 200 pF without oscillation
Wire Wire Line
	12850 8750 13000 8750
$Comp
L Device:C_Small C?
U 1 1 5F4AA9FE
P 13400 8925
F 0 "C?" H 13492 8971 50  0000 L CNN
F 1 "100pF" H 13492 8880 50  0000 L CNN
F 2 "" H 13400 8925 50  0001 C CNN
F 3 "~" H 13400 8925 50  0001 C CNN
	1    13400 8925
	1    0    0    -1  
$EndComp
Wire Wire Line
	13400 8825 13400 8750
$Comp
L power:GND #PWR?
U 1 1 5F4AAA05
P 13400 9100
F 0 "#PWR?" H 13400 8850 50  0001 C CNN
F 1 "GND" H 13405 8927 50  0000 C CNN
F 2 "" H 13400 9100 50  0001 C CNN
F 3 "" H 13400 9100 50  0001 C CNN
	1    13400 9100
	1    0    0    -1  
$EndComp
Wire Wire Line
	13400 9025 13400 9100
Wire Wire Line
	12850 6550 12975 6550
Connection ~ 13000 8750
Connection ~ 13400 8750
Wire Wire Line
	13000 8750 13400 8750
$Comp
L Device:C_Small C?
U 1 1 5F4AD1C9
P 12975 6725
F 0 "C?" H 13067 6771 50  0000 L CNN
F 1 "100pF" H 13067 6680 50  0000 L CNN
F 2 "" H 12975 6725 50  0001 C CNN
F 3 "~" H 12975 6725 50  0001 C CNN
	1    12975 6725
	1    0    0    -1  
$EndComp
Wire Wire Line
	12975 6625 12975 6550
$Comp
L power:GND #PWR?
U 1 1 5F4AD1D0
P 12975 6900
F 0 "#PWR?" H 12975 6650 50  0001 C CNN
F 1 "GND" H 12980 6727 50  0000 C CNN
F 2 "" H 12975 6900 50  0001 C CNN
F 3 "" H 12975 6900 50  0001 C CNN
	1    12975 6900
	1    0    0    -1  
$EndComp
Wire Wire Line
	12975 6825 12975 6900
$Comp
L Device:C_Small C?
U 1 1 5F4AD1D7
P 13375 6725
F 0 "C?" H 13467 6771 50  0000 L CNN
F 1 "100pF" H 13467 6680 50  0000 L CNN
F 2 "" H 13375 6725 50  0001 C CNN
F 3 "~" H 13375 6725 50  0001 C CNN
	1    13375 6725
	1    0    0    -1  
$EndComp
Wire Wire Line
	13375 6625 13375 6550
$Comp
L power:GND #PWR?
U 1 1 5F4AD1DE
P 13375 6900
F 0 "#PWR?" H 13375 6650 50  0001 C CNN
F 1 "GND" H 13380 6727 50  0000 C CNN
F 2 "" H 13375 6900 50  0001 C CNN
F 3 "" H 13375 6900 50  0001 C CNN
	1    13375 6900
	1    0    0    -1  
$EndComp
Wire Wire Line
	13375 6825 13375 6900
Connection ~ 12975 6550
Wire Wire Line
	12975 6550 13375 6550
Connection ~ 13375 6550
Wire Wire Line
	13375 6550 14100 6550
Wire Wire Line
	13400 8750 14100 8750
$Comp
L Connector:TestPoint TP?
U 1 1 5F4B0260
P 14100 6650
F 0 "TP?" V 14125 6900 50  0000 C CNN
F 1 "TestPoint" V 14025 6675 50  0000 C CNN
F 2 "" H 14300 6650 50  0001 C CNN
F 3 "~" H 14300 6650 50  0001 C CNN
	1    14100 6650
	0    -1   -1   0   
$EndComp
$Comp
L Connector:TestPoint TP?
U 1 1 5F4B03DF
P 14100 8850
F 0 "TP?" V 14100 9100 50  0000 C CNN
F 1 "TestPoint" V 14025 8850 50  0000 C CNN
F 2 "" H 14300 8850 50  0001 C CNN
F 3 "~" H 14300 8850 50  0001 C CNN
	1    14100 8850
	0    -1   -1   0   
$EndComp
$Comp
L Connector:TestPoint TP?
U 1 1 5F4B0A20
P 14100 7050
F 0 "TP?" V 14125 7300 50  0000 C CNN
F 1 "TestPoint" V 14200 7050 50  0000 C CNN
F 2 "" H 14300 7050 50  0001 C CNN
F 3 "~" H 14300 7050 50  0001 C CNN
	1    14100 7050
	0    -1   -1   0   
$EndComp
Connection ~ 14100 7050
$Comp
L Connector:TestPoint TP?
U 1 1 5F4B0AFE
P 14100 9250
F 0 "TP?" V 14125 9500 50  0000 C CNN
F 1 "TestPoint" V 14200 9250 50  0000 C CNN
F 2 "" H 14300 9250 50  0001 C CNN
F 3 "~" H 14300 9250 50  0001 C CNN
	1    14100 9250
	0    -1   -1   0   
$EndComp
Connection ~ 14100 9250
Text Notes 10375 7900 0    50   ~ 0
I_P_max = 0.75*sin(wt) + VCC/2\nI_N_max = -0.75*sin(wt) + VCC/2\n\nWe want to keep that VCC/2 bias, so we're mostly just buffering I_P,\nsubtracting a bit of I_N via the feedback resistor,\nand ensuring the AC component on both lines sees the same\nimpedance to ground
$Comp
L power:+3.3VA #PWR?
U 1 1 5F4B32FA
P 10600 9975
F 0 "#PWR?" H 10600 9825 50  0001 C CNN
F 1 "+3.3VA" V 10600 10225 50  0000 C CNN
F 2 "" H 10600 9975 50  0001 C CNN
F 3 "" H 10600 9975 50  0001 C CNN
	1    10600 9975
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3VA #PWR?
U 1 1 5F4B3549
P 10400 9975
F 0 "#PWR?" H 10400 9825 50  0001 C CNN
F 1 "+3.3VA" V 10400 10225 50  0000 C CNN
F 2 "" H 10400 9975 50  0001 C CNN
F 3 "" H 10400 9975 50  0001 C CNN
	1    10400 9975
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3VA #PWR?
U 1 1 5F4B35C8
P 10150 10775
F 0 "#PWR?" H 10150 10625 50  0001 C CNN
F 1 "+3.3VA" H 10165 10948 50  0000 C CNN
F 2 "" H 10150 10775 50  0001 C CNN
F 3 "" H 10150 10775 50  0001 C CNN
	1    10150 10775
	1    0    0    -1  
$EndComp
Wire Wire Line
	10150 10775 10400 10775
$Comp
L power:GND #PWR?
U 1 1 5F4B477D
P 10600 10775
F 0 "#PWR?" H 10600 10525 50  0001 C CNN
F 1 "GND" H 10605 10602 50  0000 C CNN
F 2 "" H 10600 10775 50  0001 C CNN
F 3 "" H 10600 10775 50  0001 C CNN
	1    10600 10775
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3VA #PWR?
U 1 1 5F4B4BE7
P 15600 8375
F 0 "#PWR?" H 15600 8225 50  0001 C CNN
F 1 "+3.3VA" H 15600 8625 50  0000 C CNN
F 2 "" H 15600 8375 50  0001 C CNN
F 3 "" H 15600 8375 50  0001 C CNN
	1    15600 8375
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3VA #PWR?
U 1 1 5F4B4DD2
P 15575 6175
F 0 "#PWR?" H 15575 6025 50  0001 C CNN
F 1 "+3.3VA" H 15575 6425 50  0000 C CNN
F 2 "" H 15575 6175 50  0001 C CNN
F 3 "" H 15575 6175 50  0001 C CNN
	1    15575 6175
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5F4B57AE
P 15575 6350
F 0 "C?" H 15667 6396 50  0000 L CNN
F 1 "0.1uF" H 15667 6305 50  0000 L CNN
F 2 "" H 15575 6350 50  0001 C CNN
F 3 "~" H 15575 6350 50  0001 C CNN
	1    15575 6350
	1    0    0    -1  
$EndComp
Connection ~ 15575 6250
$Comp
L power:GND #PWR?
U 1 1 5F4B5922
P 15575 6450
F 0 "#PWR?" H 15575 6200 50  0001 C CNN
F 1 "GND" H 15580 6277 50  0000 C CNN
F 2 "" H 15575 6450 50  0001 C CNN
F 3 "" H 15575 6450 50  0001 C CNN
	1    15575 6450
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5F4B5B16
P 15600 8550
F 0 "C?" H 15692 8596 50  0000 L CNN
F 1 "0.1uF" H 15692 8505 50  0000 L CNN
F 2 "" H 15600 8550 50  0001 C CNN
F 3 "~" H 15600 8550 50  0001 C CNN
	1    15600 8550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F4B5B1C
P 15600 8650
F 0 "#PWR?" H 15600 8400 50  0001 C CNN
F 1 "GND" H 15605 8477 50  0000 C CNN
F 2 "" H 15600 8650 50  0001 C CNN
F 3 "" H 15600 8650 50  0001 C CNN
	1    15600 8650
	1    0    0    -1  
$EndComp
Connection ~ 15600 8450
$Comp
L power:+3.3VA #PWR?
U 1 1 5F4B856B
P 13650 7725
F 0 "#PWR?" H 13650 7575 50  0001 C CNN
F 1 "+3.3VA" H 13650 7975 50  0000 C CNN
F 2 "" H 13650 7725 50  0001 C CNN
F 3 "" H 13650 7725 50  0001 C CNN
	1    13650 7725
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F4B8578
P 13650 7925
F 0 "#PWR?" H 13650 7675 50  0001 C CNN
F 1 "GND" H 13655 7752 50  0000 C CNN
F 2 "" H 13650 7925 50  0001 C CNN
F 3 "" H 13650 7925 50  0001 C CNN
	1    13650 7925
	1    0    0    -1  
$EndComp
$Comp
L Device:CP_Small C?
U 1 1 5F4BA715
P 13650 7825
F 0 "C?" H 13738 7871 50  0000 L CNN
F 1 "10uF" H 13738 7780 50  0000 L CNN
F 2 "" H 13650 7825 50  0001 C CNN
F 3 "~" H 13650 7825 50  0001 C CNN
	1    13650 7825
	1    0    0    -1  
$EndComp
Text Notes 13975 7900 0    50   ~ 0
Use tantalum?\n10uF is a big load; we'll try and layout the\nboard so that two ADCs can share one.
$Comp
L Device:C_Small C?
U 1 1 5F4BB0DE
P 11025 10350
F 0 "C?" H 11117 10396 50  0000 L CNN
F 1 "10nF" H 11117 10305 50  0000 L CNN
F 2 "" H 11025 10350 50  0001 C CNN
F 3 "~" H 11025 10350 50  0001 C CNN
	1    11025 10350
	1    0    0    -1  
$EndComp
Wire Wire Line
	10600 9975 11025 9975
Wire Wire Line
	11025 9975 11025 10250
Connection ~ 10600 9975
Wire Wire Line
	10600 10775 11025 10775
Wire Wire Line
	11025 10775 11025 10450
Connection ~ 10600 10775
$Comp
L Device:C_Small C?
U 1 1 5F4C1111
P 11450 10350
F 0 "C?" H 11542 10396 50  0000 L CNN
F 1 "0.1uF" H 11542 10305 50  0000 L CNN
F 2 "" H 11450 10350 50  0001 C CNN
F 3 "~" H 11450 10350 50  0001 C CNN
	1    11450 10350
	1    0    0    -1  
$EndComp
Wire Wire Line
	11450 9975 11450 10250
Wire Wire Line
	11450 10775 11450 10450
Wire Wire Line
	11025 9975 11450 9975
Connection ~ 11025 9975
Wire Wire Line
	11025 10775 11450 10775
Connection ~ 11025 10775
Text Notes 2525 1275 0    50   ~ 0
this 22nF is awkward, can we use something else?\nAlso, add some PCB capacitance in the layout.
$Comp
L Device:C_Small C?
U 1 1 5F4C7618
P 7125 4950
F 0 "C?" V 7000 4900 50  0000 L CNN
F 1 "1nF" V 7250 4875 50  0000 L CNN
F 2 "" H 7125 4950 50  0001 C CNN
F 3 "~" H 7125 4950 50  0001 C CNN
	1    7125 4950
	0    1    1    0   
$EndComp
Text GLabel 6675 4950 0    50   Input ~ 0
24MHz_OSC
$Comp
L Device:C_Small C?
U 1 1 5F52BEC8
P 3100 1825
F 0 "C?" V 2871 1825 50  0000 C CNN
F 1 "100pF" V 2962 1825 50  0000 C CNN
F 2 "" H 3100 1825 50  0001 C CNN
F 3 "~" H 3100 1825 50  0001 C CNN
	1    3100 1825
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5F52BECE
P 3100 2200
F 0 "C?" V 2871 2200 50  0000 C CNN
F 1 "100pF" V 2962 2200 50  0000 C CNN
F 2 "" H 3100 2200 50  0001 C CNN
F 3 "~" H 3100 2200 50  0001 C CNN
	1    3100 2200
	0    1    1    0   
$EndComp
Wire Wire Line
	3000 1825 2925 1825
Wire Wire Line
	2925 1825 2925 2025
Wire Wire Line
	2925 2200 3000 2200
Connection ~ 2925 2025
Wire Wire Line
	2925 2025 2925 2200
Wire Wire Line
	3475 2025 3300 2025
Wire Wire Line
	3300 2025 3300 1825
Wire Wire Line
	3300 1825 3200 1825
Wire Wire Line
	3200 2200 3300 2200
Wire Wire Line
	3300 2200 3300 2025
Connection ~ 3300 2025
Wire Wire Line
	2675 2025 2925 2025
$Comp
L Device:C_Small C?
U 1 1 5F53636E
P 1475 1825
F 0 "C?" V 1246 1825 50  0000 C CNN
F 1 "100pF" V 1337 1825 50  0000 C CNN
F 2 "" H 1475 1825 50  0001 C CNN
F 3 "~" H 1475 1825 50  0001 C CNN
	1    1475 1825
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5F536374
P 1475 2200
F 0 "C?" V 1246 2200 50  0000 C CNN
F 1 "100pF" V 1337 2200 50  0000 C CNN
F 2 "" H 1475 2200 50  0001 C CNN
F 3 "~" H 1475 2200 50  0001 C CNN
	1    1475 2200
	0    1    1    0   
$EndComp
Wire Wire Line
	1375 1825 1300 1825
Wire Wire Line
	1300 2200 1375 2200
Wire Wire Line
	1675 1825 1575 1825
Wire Wire Line
	1575 2200 1675 2200
Wire Wire Line
	1675 1825 1675 2025
Wire Wire Line
	1300 1825 1300 2025
Connection ~ 1300 2025
Wire Wire Line
	1300 2025 1300 2200
Connection ~ 1675 2025
Wire Wire Line
	1675 2025 1675 2200
Text Notes 1150 4800 0    50   ~ 0
From BGA2818 datasheet:\n\n"The value of the input and output DC blocking capacitors C2 and C3 should \nnot be more than 100 pF for applications above 100 MHz. However, when \nthe device is operated below 100 MHz, the capacitor value should be increased."\n\nHowever, conservative spice modeling of the blocking capacitors\nand parasitic series inductance indicates that 200pF caps will work better\nfor 10 - 100 MHz, and also pass up to 3 GHz with no trouble.\n\nWe'll just have to play around with this when it's built.
Text Label 1725 3025 0    50   ~ 0
high-Z
$Comp
L Device:C_Small C?
U 1 1 5F53ED46
P 1525 3025
F 0 "C?" V 1625 3025 50  0000 C CNN
F 1 "1nF" V 1700 3025 50  0000 C CNN
F 2 "" H 1525 3025 50  0001 C CNN
F 3 "~" H 1525 3025 50  0001 C CNN
	1    1525 3025
	0    1    1    0   
$EndComp
Wire Wire Line
	1725 3025 1625 3025
Text Label 6600 3925 0    50   ~ 0
high-Z
Wire Wire Line
	8300 4950 8300 4750
$Comp
L Device:C_Small C?
U 1 1 5F556360
P 8700 5175
F 0 "C?" H 8792 5221 50  0000 L CNN
F 1 "39nF" H 8792 5130 50  0000 L CNN
F 2 "" H 8700 5175 50  0001 C CNN
F 3 "~" H 8700 5175 50  0001 C CNN
	1    8700 5175
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5F556420
P 9100 5300
F 0 "C?" H 9192 5346 50  0000 L CNN
F 1 "2.7nF" H 9192 5255 50  0000 L CNN
F 2 "" H 9100 5300 50  0001 C CNN
F 3 "~" H 9100 5300 50  0001 C CNN
	1    9100 5300
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R?
U 1 1 5F556604
P 8700 5525
F 0 "R?" H 8575 5475 50  0000 C CNN
F 1 "360R" H 8525 5575 50  0000 C CNN
F 2 "" H 8700 5525 50  0001 C CNN
F 3 "~" H 8700 5525 50  0001 C CNN
	1    8700 5525
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F556AC9
P 8700 5750
F 0 "#PWR?" H 8700 5500 50  0001 C CNN
F 1 "GND" H 8705 5577 50  0000 C CNN
F 2 "" H 8700 5750 50  0001 C CNN
F 3 "" H 8700 5750 50  0001 C CNN
	1    8700 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	8700 4750 8700 4975
Wire Wire Line
	8700 5275 8700 5325
Wire Wire Line
	8700 5625 8700 5675
Wire Wire Line
	8700 5675 9100 5675
Wire Wire Line
	9100 5675 9100 5400
Connection ~ 8700 5675
Wire Wire Line
	8700 5675 8700 5750
Wire Wire Line
	8700 5325 8500 5325
Wire Wire Line
	8500 5325 8500 4750
Connection ~ 8700 5325
Wire Wire Line
	8700 5325 8700 5425
Wire Wire Line
	8700 4975 9100 4975
Wire Wire Line
	9100 4975 9100 5200
Connection ~ 8700 4975
Wire Wire Line
	8700 4975 8700 5075
$Comp
L Device:R_Small R?
U 1 1 5F568D1A
P 9400 4975
F 0 "R?" V 9325 4975 50  0000 C CNN
F 1 "500R" V 9250 4975 50  0000 C CNN
F 2 "" H 9400 4975 50  0001 C CNN
F 3 "~" H 9400 4975 50  0001 C CNN
	1    9400 4975
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9100 4975 9300 4975
Connection ~ 9100 4975
$Comp
L Device:C_Small C?
U 1 1 5F56C732
P 9675 5300
F 0 "C?" H 9767 5346 50  0000 L CNN
F 1 "2.7nF" H 9767 5255 50  0000 L CNN
F 2 "" H 9675 5300 50  0001 C CNN
F 3 "~" H 9675 5300 50  0001 C CNN
	1    9675 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	9500 4975 9675 4975
Wire Wire Line
	9675 4975 9675 5200
Wire Wire Line
	9675 5400 9675 5675
Wire Wire Line
	9675 5675 9100 5675
Connection ~ 9100 5675
Wire Wire Line
	9675 4975 9675 4750
Wire Wire Line
	9675 4750 8900 4750
Connection ~ 9675 4975
$Comp
L power:+3.3V #PWR?
U 1 1 5F5969B9
P 10600 2700
F 0 "#PWR?" H 10600 2550 50  0001 C CNN
F 1 "+3.3V" H 10615 2873 50  0000 C CNN
F 2 "" H 10600 2700 50  0001 C CNN
F 3 "" H 10600 2700 50  0001 C CNN
	1    10600 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	10600 2950 10600 2700
Wire Wire Line
	10600 3100 10600 2950
Connection ~ 10600 2950
Wire Wire Line
	9650 2950 10600 2950
Wire Wire Line
	9650 3100 10600 3100
$Comp
L Device:C_Small C?
U 1 1 5F5AC177
P 10600 3300
F 0 "C?" H 10692 3346 50  0000 L CNN
F 1 "1nF" H 10692 3255 50  0000 L CNN
F 2 "" H 10600 3300 50  0001 C CNN
F 3 "~" H 10600 3300 50  0001 C CNN
	1    10600 3300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F5AC3BB
P 10600 3475
F 0 "#PWR?" H 10600 3225 50  0001 C CNN
F 1 "GND" H 10605 3302 50  0000 C CNN
F 2 "" H 10600 3475 50  0001 C CNN
F 3 "" H 10600 3475 50  0001 C CNN
	1    10600 3475
	1    0    0    -1  
$EndComp
Wire Wire Line
	10600 3100 10600 3200
Connection ~ 10600 3100
Wire Wire Line
	10600 3400 10600 3475
$Comp
L power:+3.3VA #PWR?
U 1 1 5F5C9B18
P 8325 775
F 0 "#PWR?" H 8325 625 50  0001 C CNN
F 1 "+3.3VA" H 8340 948 50  0000 C CNN
F 2 "" H 8325 775 50  0001 C CNN
F 3 "" H 8325 775 50  0001 C CNN
	1    8325 775 
	1    0    0    -1  
$EndComp
NoConn ~ 7900 4750
NoConn ~ 8100 4750
Wire Wire Line
	8325 775  8325 925 
Wire Wire Line
	7550 1600 7650 1600
Connection ~ 7550 1600
$Comp
L power:GND #PWR?
U 1 1 5F5E9030
P 7725 1400
F 0 "#PWR?" H 7725 1150 50  0001 C CNN
F 1 "GND" H 7730 1227 50  0000 C CNN
F 2 "" H 7725 1400 50  0001 C CNN
F 3 "" H 7725 1400 50  0001 C CNN
	1    7725 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7725 1325 7725 1400
Connection ~ 7850 925 
Wire Wire Line
	7850 925  7550 925 
Wire Wire Line
	7850 1125 7725 1125
$Comp
L power:GND #PWR?
U 1 1 5F5F9389
P 8025 1400
F 0 "#PWR?" H 8025 1150 50  0001 C CNN
F 1 "GND" H 8030 1227 50  0000 C CNN
F 2 "" H 8025 1400 50  0001 C CNN
F 3 "" H 8025 1400 50  0001 C CNN
	1    8025 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8025 1325 8025 1400
Wire Wire Line
	8150 1125 8025 1125
Wire Wire Line
	8150 925  8150 1125
Connection ~ 8150 925 
Connection ~ 8150 1600
Wire Wire Line
	8050 1600 8150 1600
Wire Wire Line
	7850 925  8150 925 
Connection ~ 7850 1125
Wire Wire Line
	7850 1125 7850 925 
Wire Wire Line
	7850 1125 7850 1600
Connection ~ 8150 1125
Wire Wire Line
	8150 1125 8150 1600
Wire Wire Line
	7550 925  7550 1125
$Comp
L Device:C_Small C?
U 1 1 5F634F96
P 7425 1225
F 0 "C?" H 7400 1400 50  0000 L CNN
F 1 "100pF" V 7500 975 50  0000 L CNN
F 2 "" H 7425 1225 50  0001 C CNN
F 3 "~" H 7425 1225 50  0001 C CNN
	1    7425 1225
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F634F9C
P 7425 1400
F 0 "#PWR?" H 7425 1150 50  0001 C CNN
F 1 "GND" H 7430 1227 50  0000 C CNN
F 2 "" H 7425 1400 50  0001 C CNN
F 3 "" H 7425 1400 50  0001 C CNN
	1    7425 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7425 1325 7425 1400
Wire Wire Line
	7550 1125 7425 1125
Connection ~ 7550 1125
Wire Wire Line
	7550 1125 7550 1600
$Comp
L power:GND #PWR?
U 1 1 5F63BFEA
P 8325 1400
F 0 "#PWR?" H 8325 1150 50  0001 C CNN
F 1 "GND" H 8330 1227 50  0000 C CNN
F 2 "" H 8325 1400 50  0001 C CNN
F 3 "" H 8325 1400 50  0001 C CNN
	1    8325 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8325 1325 8325 1400
Wire Wire Line
	8450 1125 8325 1125
Wire Wire Line
	8450 925  8450 1125
Connection ~ 8450 1125
Wire Wire Line
	8450 1125 8450 1600
$Comp
L power:GND #PWR?
U 1 1 5F641F8B
P 8525 1400
F 0 "#PWR?" H 8525 1150 50  0001 C CNN
F 1 "GND" H 8530 1227 50  0000 C CNN
F 2 "" H 8525 1400 50  0001 C CNN
F 3 "" H 8525 1400 50  0001 C CNN
	1    8525 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8525 1325 8525 1400
Wire Wire Line
	8650 1125 8525 1125
Wire Wire Line
	8650 925  8650 1125
Connection ~ 8650 1125
Wire Wire Line
	8650 1125 8650 1600
$Comp
L power:GND #PWR?
U 1 1 5F6483AD
P 8825 1400
F 0 "#PWR?" H 8825 1150 50  0001 C CNN
F 1 "GND" H 8830 1227 50  0000 C CNN
F 2 "" H 8825 1400 50  0001 C CNN
F 3 "" H 8825 1400 50  0001 C CNN
	1    8825 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8825 1325 8825 1400
Wire Wire Line
	8950 1125 8825 1125
Wire Wire Line
	8950 925  8950 1125
Connection ~ 8950 1125
Wire Wire Line
	8950 1125 8950 1600
$Comp
L power:GND #PWR?
U 1 1 5F64ECCA
P 9025 1400
F 0 "#PWR?" H 9025 1150 50  0001 C CNN
F 1 "GND" H 9030 1227 50  0000 C CNN
F 2 "" H 9025 1400 50  0001 C CNN
F 3 "" H 9025 1400 50  0001 C CNN
	1    9025 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9025 1325 9025 1400
Wire Wire Line
	9150 1125 9025 1125
Wire Wire Line
	9150 925  9150 1125
Connection ~ 9150 1125
Wire Wire Line
	9150 1125 9150 1600
Wire Wire Line
	8350 1600 8450 1600
Connection ~ 8450 1600
Wire Wire Line
	8850 1600 8950 1600
Connection ~ 8950 1600
Wire Wire Line
	9150 925  8950 925 
Connection ~ 8450 925 
Wire Wire Line
	8450 925  8325 925 
Connection ~ 8650 925 
Wire Wire Line
	8650 925  8450 925 
Connection ~ 8950 925 
Wire Wire Line
	8950 925  8650 925 
Connection ~ 8325 925 
Wire Wire Line
	8150 925  8325 925 
Text Notes 6550 6400 0    50   ~ 0
TODO: proper transmission line and \nterminations for the oscillator signal
$Comp
L Device:C_Small C?
U 1 1 5F686FDF
P 7725 1225
F 0 "C?" H 7700 1400 50  0000 L CNN
F 1 "100pF" V 7800 975 50  0000 L CNN
F 2 "" H 7725 1225 50  0001 C CNN
F 3 "~" H 7725 1225 50  0001 C CNN
	1    7725 1225
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5F68705F
P 8025 1225
F 0 "C?" H 8000 1400 50  0000 L CNN
F 1 "100pF" V 8100 975 50  0000 L CNN
F 2 "" H 8025 1225 50  0001 C CNN
F 3 "~" H 8025 1225 50  0001 C CNN
	1    8025 1225
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5F6870E5
P 8325 1225
F 0 "C?" H 8300 1400 50  0000 L CNN
F 1 "100pF" V 8400 975 50  0000 L CNN
F 2 "" H 8325 1225 50  0001 C CNN
F 3 "~" H 8325 1225 50  0001 C CNN
	1    8325 1225
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5F687D09
P 8525 1225
F 0 "C?" H 8500 1400 50  0000 L CNN
F 1 "100pF" V 8600 975 50  0000 L CNN
F 2 "" H 8525 1225 50  0001 C CNN
F 3 "~" H 8525 1225 50  0001 C CNN
	1    8525 1225
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5F687D87
P 8825 1225
F 0 "C?" H 8800 1400 50  0000 L CNN
F 1 "100pF" V 8900 975 50  0000 L CNN
F 2 "" H 8825 1225 50  0001 C CNN
F 3 "~" H 8825 1225 50  0001 C CNN
	1    8825 1225
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5F687E13
P 9025 1225
F 0 "C?" H 9000 1400 50  0000 L CNN
F 1 "100pF" V 9100 975 50  0000 L CNN
F 2 "" H 9025 1225 50  0001 C CNN
F 3 "~" H 9025 1225 50  0001 C CNN
	1    9025 1225
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5F6899F2
P 10925 3175
F 0 "C?" H 11017 3221 50  0000 L CNN
F 1 "1nF" H 11017 3130 50  0000 L CNN
F 2 "" H 10925 3175 50  0001 C CNN
F 3 "~" H 10925 3175 50  0001 C CNN
	1    10925 3175
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F689ACC
P 10925 3275
F 0 "#PWR?" H 10925 3025 50  0001 C CNN
F 1 "GND" H 10930 3102 50  0000 C CNN
F 2 "" H 10925 3275 50  0001 C CNN
F 3 "" H 10925 3275 50  0001 C CNN
	1    10925 3275
	1    0    0    -1  
$EndComp
Wire Wire Line
	10600 2950 10925 2950
Wire Wire Line
	10925 2950 10925 3075
$Comp
L Device:L_Small L?
U 1 1 5F6A02AA
P 1175 2875
F 0 "L?" H 1222 2921 50  0000 L CNN
F 1 "150nH" H 1222 2830 50  0000 L CNN
F 2 "" H 1175 2875 50  0001 C CNN
F 3 "~" H 1175 2875 50  0001 C CNN
	1    1175 2875
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 2025 1175 2025
Wire Wire Line
	1175 2250 1175 2025
Connection ~ 1175 2025
Wire Wire Line
	1175 2025 1300 2025
$Comp
L Device:R_Small R?
U 1 1 5F6C01FC
P 1175 3150
F 0 "R?" V 1100 3150 50  0000 C CNN
F 1 "50" V 1025 3150 50  0000 C CNN
F 2 "" H 1175 3150 50  0001 C CNN
F 3 "~" H 1175 3150 50  0001 C CNN
	1    1175 3150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F6C1B3E
P 1175 3325
F 0 "#PWR?" H 1175 3075 50  0001 C CNN
F 1 "GND" H 1180 3152 50  0000 C CNN
F 2 "" H 1175 3325 50  0001 C CNN
F 3 "" H 1175 3325 50  0001 C CNN
	1    1175 3325
	1    0    0    -1  
$EndComp
Wire Wire Line
	1675 2025 2075 2025
Wire Wire Line
	1175 2975 1175 3025
Wire Wire Line
	1175 3025 1425 3025
Connection ~ 1175 3025
Wire Wire Line
	1175 3025 1175 3050
Wire Wire Line
	1175 3250 1175 3325
$Comp
L Device:C_Small C?
U 1 1 5F72E0B2
P 2450 1500
F 0 "C?" H 2300 1425 50  0000 C CNN
F 1 "100pF" H 2225 1525 50  0000 C CNN
F 2 "" H 2450 1500 50  0001 C CNN
F 3 "~" H 2450 1500 50  0001 C CNN
	1    2450 1500
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F73E42C
P 2450 1600
F 0 "#PWR?" H 2450 1350 50  0001 C CNN
F 1 "GND" H 2455 1427 50  0000 C CNN
F 2 "" H 2450 1600 50  0001 C CNN
F 3 "" H 2450 1600 50  0001 C CNN
	1    2450 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	2275 1400 1950 1400
$Comp
L Device:L_Small L?
U 1 1 5F76EF01
P 1175 2600
F 0 "L?" H 1222 2646 50  0000 L CNN
F 1 "150nH" H 1222 2555 50  0000 L CNN
F 2 "" H 1175 2600 50  0001 C CNN
F 3 "~" H 1175 2600 50  0001 C CNN
	1    1175 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1175 2700 1175 2775
$Comp
L Device:C_Small C?
U 1 1 5F7A9E55
P 1175 2350
F 0 "C?" H 1025 2350 50  0000 C CNN
F 1 "0.1uF" H 1000 2425 50  0000 C CNN
F 2 "" H 1175 2350 50  0001 C CNN
F 3 "~" H 1175 2350 50  0001 C CNN
	1    1175 2350
	-1   0    0    1   
$EndComp
Wire Wire Line
	1175 2450 1175 2500
$Comp
L Device:C_Small C?
U 1 1 5F6DE413
P 7550 5200
F 0 "C?" H 7650 5150 50  0000 L CNN
F 1 "10pF" H 7250 5200 50  0000 L CNN
F 2 "" H 7550 5200 50  0001 C CNN
F 3 "~" H 7550 5200 50  0001 C CNN
	1    7550 5200
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Small R?
U 1 1 5F6DF083
P 7550 5475
F 0 "R?" V 7475 5475 50  0000 C CNN
F 1 "50" V 7400 5475 50  0000 C CNN
F 2 "" H 7550 5475 50  0001 C CNN
F 3 "~" H 7550 5475 50  0001 C CNN
	1    7550 5475
	1    0    0    -1  
$EndComp
Wire Wire Line
	7225 4950 7550 4950
Wire Wire Line
	7550 5100 7550 4950
Connection ~ 7550 4950
Wire Wire Line
	7550 4950 8300 4950
Wire Wire Line
	6675 4950 7025 4950
Wire Wire Line
	7550 5300 7550 5375
$Comp
L power:GND #PWR?
U 1 1 5F709A07
P 7550 5650
F 0 "#PWR?" H 7550 5400 50  0001 C CNN
F 1 "GND" H 7555 5477 50  0000 C CNN
F 2 "" H 7550 5650 50  0001 C CNN
F 3 "" H 7550 5650 50  0001 C CNN
	1    7550 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7550 5575 7550 5650
Text Notes 7650 5400 0    50   ~ 0
Reflection snubber
Text Notes 5600 4825 0    50   ~ 0
50 Ohm transmission line for clock
$EndSCHEMATC
