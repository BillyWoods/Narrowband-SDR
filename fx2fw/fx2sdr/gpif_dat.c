const char __xdata WaveData[128] =     
{                                      
// Wave 0 
/* LenBr */ 0x01,     0x01,     0x01,     0x01,     0x01,     0x01,     0x01,     0x07,
/* Opcode*/ 0x00,     0x00,     0x00,     0x00,     0x00,     0x00,     0x00,     0x00,
/* Output*/ 0x01,     0x01,     0x01,     0x01,     0x01,     0x01,     0x01,     0x01,
/* LFun  */ 0x00,     0x00,     0x00,     0x00,     0x00,     0x00,     0x00,     0x3F,
// Wave 1 
/* LenBr */ 0x01,     0x01,     0x01,     0x01,     0x01,     0x01,     0x01,     0x07,
/* Opcode*/ 0x00,     0x00,     0x00,     0x00,     0x00,     0x00,     0x00,     0x00,
/* Output*/ 0x01,     0x01,     0x01,     0x01,     0x01,     0x01,     0x01,     0x01,
/* LFun  */ 0x00,     0x00,     0x00,     0x00,     0x00,     0x00,     0x00,     0x3F,
// Wave 2 
/* LenBr */ 0x03,     0x0B,     0x01,     0xB8,     0x01,     0x01,     0x01,     0x07,
/* Opcode*/ 0x10,     0x02,     0x02,     0x03,     0x02,     0x02,     0x02,     0x00,
/* Output*/ 0x00,     0x00,     0x01,     0x01,     0x01,     0x01,     0x01,     0x01,
/* LFun  */ 0x00,     0x00,     0x00,     0x2D,     0x00,     0x00,     0x00,     0x3F,
// Wave 3 
/* LenBr */ 0x01,     0x01,     0x01,     0x01,     0x01,     0x01,     0x01,     0x07,
/* Opcode*/ 0x00,     0x00,     0x00,     0x00,     0x00,     0x00,     0x00,     0x00,
/* Output*/ 0x01,     0x01,     0x01,     0x01,     0x01,     0x01,     0x01,     0x01,
/* LFun  */ 0x00,     0x00,     0x00,     0x00,     0x00,     0x00,     0x00,     0x3F,
};
const char __xdata FlowStates[36] =   
{                                      
/* Wave 0 FlowStates */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
/* Wave 1 FlowStates */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
/* Wave 2 FlowStates */ 0x81,0x2D,0x00,0x00,0x20,0x01,0x03,0x02,0x00,
/* Wave 3 FlowStates */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
};
const char __xdata InitData[7] =                                   
{                                                                
/* Regs  */ 0xA0,0x10,0x00,0x01,0xCE,0x4E,0x00     
};
