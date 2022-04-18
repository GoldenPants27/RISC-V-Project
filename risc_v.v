//////////////////////////////////////////////RISC-V_MODULE///////////////////////////////////////////////////
//module RISC_V(input clk,reset,
//              input IF_ID_write,
//              input PCSrc,PC_write,
//              input [31:0] PC_Branch,
//              input RegWrite_WB, 
//              input [31:0] ALU_DATA_WB,
//              input [4:0] RD_WB,
//              output [31:0] PC_ID,
//              output [31:0] INSTRUCTION_ID,
//              output [31:0] IMM_ID,
//              output [31:0] REG_DATA1_ID,REG_DATA2_ID,
//              output RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID,
//              output [1:0] ALUop_ID,
//              output ALUSrc_ID,
//              output Branch_ID,
//              output pipeline_stall
//              );
module RISC_V(input clk,
              input reset,
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              output [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output pipeline_stall
              );
  
  //////////////////////////////////////////IF signals////////////////////////////////////////////////////////
  wire [31:0] PC_IF;               //current PC
  wire [31:0] INSTRUCTION_IF;
  wire PC_write;
  
  ///////////////////////////////////////ID signals/////////////////////////////////////////////////////////////////
  
  wire [31:0] INSTRUCTION_ID;
  wire [31:0] PC_ID;
  wire [31:0] IMM_ID;
  wire [31:0] REG_DATA1_ID;
  wire [31:0] REG_DATA2_ID;
  wire RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID;
  wire [1:0] ALUop_ID;
  wire ALUSrc_ID, Branch_ID;
  
  ///////////////////////////////////////EX signals/////////////////////////////////////////////////////////////////
 
  wire [31:0] IMM_EX;
  wire [31:0] REG_DATA1_EX;
  wire [31:0] REG_DATA2_EX;
  wire RegWrite_EX;
  wire MemtoReg_EX;
  wire MemRead_EX;
  wire MemWrite_EX;
  wire [1:0] ALUop_EX;
  wire ALUSrc_EX;
  wire Branch_EX;
  wire [6:0] FUNCT7_EX;
  wire [2:0] FUNCT3_EX;
  wire [4:0] RD_EX;
  wire [4:0] RS1_EX;
  wire [4:0] RS2_EX;
  wire ZERO_EX;
  wire [31:0] PC_Branch_EX;
  wire [31:0] REG_DATA2_EX_FINAL;
  
  /////////////////////////////////////MEM Signals///////////////////////////////////
  
  wire RegWrite_MEM;
  wire MemtoReg_MEM;
  wire MemRead_MEM;
  wire MemWrite_MEM;
  wire [31:0] WRITE_DATA;
  wire ZERO_MEM;
  wire [31:0] BRANCH_SUM_MEM;
  wire BRANCH_MEM;
  wire [4:0] RD_MEM;
  wire [31:0] ADDRESS_MEM_WB;
  wire [31:0] ALU_DATA_MEM;
  
  /////////////////////////////////////WB Signals////////////////////////////////////
  
  wire [31:0] ALU_DATA_WB_INTER;
  wire RegWrite_MEM_WB;
  wire [4:0] RD_MEM_WB;
  wire [31:0] READ_DATA_WB;
  wire MemtoReg_WB;
  wire [4:0] RD_WB;
  wire RegWrite_WB;
  
  /////////////////////////////////////Hazard detection unit Signals/////////////////
  
  wire IF_ID_write;
  
  /////////////////////////////////////IF Module/////////////////////////////////////
  IF instruction_fetch(clk, reset, 
                       PCSrc, PC_write,
                       PC_MEM,
                       PC_IF,INSTRUCTION_IF);
  
  
  //////////////////////////////////////pipeline registers////////////////////////////////////////////////////
  IF_ID_reg IF_ID_REGISTER(clk,reset,
                           IF_ID_write,
                           PC_IF,INSTRUCTION_IF,
                           PC_ID,INSTRUCTION_ID);
  
  
  ////////////////////////////////////////ID Module//////////////////////////////////
  ID instruction_decode(clk,
                        PC_ID,INSTRUCTION_ID,
                        RegWrite_WB, 
                        ALU_DATA_WB,
                        RD_WB,
                        IMM_ID,
                        REG_DATA1_ID,REG_DATA2_ID,
                        RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID,
                        ALUop_ID,
                        ALUSrc_ID,
                        Branch_ID);
 
  wire [6:0] FUNCT7_ID; assign FUNCT7_ID = INSTRUCTION_ID[31:25];
  wire [2:0] FUNCT3_ID; assign FUNCT3_ID = INSTRUCTION_ID[14:12];
  wire [4:0] RD_ID; assign RD_ID = INSTRUCTION_ID[11:7];
  wire [4:0] RS1_ID; assign RS1_ID = INSTRUCTION_ID[19:15];
  wire [4:0] RS2_ID; assign RS2_ID = INSTRUCTION_ID[24:20];
  
  //////////////////////////////////////HAZARD DETECTION UNIT///////////////////////////////////////////////////////
  
  hazard_detection HAZARD_DETECTION_UNIT(RD_ID, RS1_ID, RS2_ID, MemRead_EX, PC_write, IF_ID_write, pipeline_stall);
  
  //////////////////////////////////////ID_EX pipeline register/////////////////////////////////////////////////////
  
  ID_EX_reg ID_EX_REG(clk, reset, IMM_ID,   // Date imediate in ID
                       REG_DATA1_ID,REG_DATA2_ID,   // val lui reg_data1 si reg_data2 in ID
                       RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID, // semnalele din control in ID
                       ALUop_ID,        // semalul ALUop din control in ID
                       ALUSrc_ID,       // semnal selectie mux ALU din EX in ID
                       Branch_ID,       // semnal de branch in ID
                       PC_ID,           // valoarea lui PC in ID
                       FUNCT7_ID,       // funct7 in ID
                       FUNCT3_ID,       // funct3 in ID
                       RD_ID,           // valoarea lui RD in ID
                       RS1_ID,          // valoarea registrului sursa 1 in ID
                       RS2_ID,          // valoarea registrului sursa 2 in ID
                       IMM_EX,          // date imediate in EX
                       REG_DATA1_EX,    // data1 din registru in EX
                       REG_DATA2_EX,    // data2 din registru in EX
                       RegWrite_EX,     // semnalul de scriere in registers in EX
                       MemtoReg_EX,     // semnal de selectie multiplexor WB in EX
                       MemRead_EX,      // semnal pentru activarea citirii din mem in EX
                       MemWrite_EX,     // semnal pentru activarea scrierii in mem in EX
                       ALUop_EX,        // ALUop in EX
                       ALUSrc_EX,       // ALUSrc in EX
                       Branch_EX,       // Branch in EX
                       PC_EX,           // PC in EX
                       FUNCT7_EX,       // Funct7 in EX
                       FUNCT3_EX,       // funct3 in EX
                       RD_EX,           // registrul destinatie in EX
                       RS1_EX,          // registrul sursa 1 in EX
                       RS2_EX           // registrul sursa 2 in EX
                       );

  //////////////////////////////////////EX Module///////////////////////////////////////////////////////////////////  
  
  EX execute(IMM_EX,            // val date imediate in EX
             REG_DATA1_EX,      // val registrului sursa 1
             REG_DATA2_EX,      // val registrului sursa 2
             PC_EX,             // adresa instructiunii curente in EX
             FUNCT3_EX,         // funct3 pt instr in EX
             FUNCT7_EX,         // funct7 pt instr in EX
             RD_EX,             // adresa reg destinatie
             RS1_EX,            // adresa reg sursa 1
             RS2_EX,            // adresa reg sursa 2
             RegWrite_EX,       // semnal de scriere in registers
             MemtoReg_EX,       // semnal selectie multiplexor WB in EX
             MemRead_EX,        // senmal pt activarea citirii din memorie
             MemWrite_EX,       // semnal pt activarea scrierii in memorie
             ALUop_EX,          // semnal de control ALUop in EX
             ALUSrc_EX,         // semnal de sel intre RD2 si IMM
             Branch_EX,         // semnal pt instr de tip Branch
             forwardA,          // semnal sel multiplexor forwarding
             forwardB,          // semnal sel multiplexor forwarding
             ALU_DATA_WB,        // val calc de ALU, prezenta in WB
             ALU_DATA_MEM,      // val calc de ALU, prezenta in MEM
             ZERO_EX,           // flag ZERO calc de ALU
             ALU_OUT_EX,        // rezultatul calc de ALU in EX
             PC_Branch_EX,      // adresa de salt in EX
             REG_DATA2_EX_FINAL // val reg sursa 2 selectata dintre val prez in EX, MEM, WB
             );
  
  ///////////////////////////////////////FORWARDING UNIT////////////////////////////////////////////////////////////
  
  forwarding FORWARDING_UNIT(RS1_EX,        // adresa reg sursa 1 in EX
                             RS2_EX,        // adresa reg sursa 2 in EX
                             RD_MEM,        // adresa reg dest in MEM
                             RD_WB,         // adresa reg dest in WB
                             RegWrite_MEM,  // semnal de control din MEM
                             RegWrite_WB,   // semnal de control din WB
                             forwardA,      // semnal sel mux forwarding
                             forwardB       // semnal sel mux forwarding
                             );
  
  ///////////////////////////////////////EX_MEM PIPELINE////////////////////////////////////////////////////////////
  
  EX_MEM_reg EX_MEM_REG(clk,                // semnal de clock
                        reset,              // semnal de reset
                        RegWrite_EX,        // semnalul de control reg write in EX
                        MemtoReg_EX,        // semnalul de control MemtoReg in EX
                        MemRead_EX,         // semnalul de control MemRead in EX
                        MemWrite_EX,        // semnalul de control MemWrite in EX
                        ALU_OUT_EX,         // outputul din ALU in EX
                        REG_DATA2_EX_FINAL, // val reg sursa 2 selectata dintre val prez in EX, MEM, WB
                        ZERO_EX,            // flagul de ZERO in EX
                        PC_Branch_EX,       // adresa de branch in EX
                        Branch_EX,          // samnalul de branch in EX
                        RD_EX,              // adresa registrului destinatie in EX
                        RegWrite_MEM,       // semnalul de control RegWrite in MEM
                        MemtoReg_MEM,       // semnalul de control MemtoReg in MEM
                        MemRead_MEM,        // semnalul de control MemRead in MEM
                        MemWrite_MEM,       // semnalul de control MemWrite in MEM
                        ALU_DATA_MEM,       // adresa calculata de ALU in EX trimisa in MEM
                        WRITE_DATA,         // valoarea ce trebuie scrisa in memorie in MEM
                        ZERO_MEM,           // flagul de ZERO in MEM
                        BRANCH_SUM_MEM,     // adresa de branch in MEM
                        BRANCH_MEM,         // semnalul de branch in MEM
                        RD_MEM              // adresa registrului destinatie in MEM
                        );
  
  //////////////////////////////////////MEM Module//////////////////////////////////////////////////////////////////
  
  MEM memory(clk,               // semnalul de clock
             MemRead_MEM,       // semnalul de control MemRead in MEM
             MemWrite_MEM,      // semnalul de control MemWrite in MEM
             ALU_DATA_MEM,      // adresa de scriere in memorie in MEM
             WRITE_DATA,        // valoarea ce trebuie scrisa in memorie in MEM
             ZERO_MEM,          // flagul de ZERO in MEM
             BRANCH_SUM_MEM,    // adresa de branch in MEM
             BRANCH_MEM,        // semnalul de branch in MEM
             ADDRESS_MEM_WB,    // adresa de scrie in memorie la iesirea din MEM spre WB
             DATA_MEMORY_MEM,   // valoare citita din memorie in MEM
             PC_MEM,            // adresa de branch dupa sumator in cazul de ZERO = 1
             PCSrc              // semnalul de alegere pentru muxul din IF
             );
  
  //////////////////////////////////////MEM_WB PIPELINE/////////////////////////////////////////////////////////////
  
  MEM_WB_reg MEM_WB_REG(clk,            // semnalul de clock
                        reset,          // semnalul de reset
                        RegWrite_MEM,   // semnalul de control RegWrite din MEM
                        MemtoReg_MEM,   // semnalul de control MemtoReg din MEM
                        RD_MEM,         // adresa registrului destinatie in MEM
                        ADDRESS_MEM_WB, // adresa din memorie din MEM
                        DATA_MEMORY_MEM,// valoarea citita din memorie in MEM
                        RegWrite_MEM_WB,// semnalul de control RegWrite in WB
                        MemtoReg_WB,    // semnalul de control MemtoReg in WB
                        RD_MEM_WB,      // adresa registrului destinatie in WB
                        ALU_DATA_WB_INTER,// adresa din memorie in WB
                        READ_DATA_WB    // valoare citita din memorie in WB
                        );
  
  //////////////////////////////////////WB Module///////////////////////////////////////////////////////////////////
  
  WB write_back(RD_MEM_WB,      // adresa registrului destinatie in WB
                ALU_DATA_WB_INTER,// adresa din memorie in WB
                READ_DATA_WB,   // valoarea citita din memorie in WB
                MemtoReg_WB,    // semnalul de control MemtoReg in WB
                RegWrite_MEM_WB,// semnalul de control RegWrite in WB
                ALU_DATA_WB,    // ALU la iesirea din WB
                RegWrite_WB,    // semnalul de control RegWrite ce va fi trimis spre ID
                RD_WB           // adresa reg RD la iesirea din WB
                );
                                     
endmodule
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
