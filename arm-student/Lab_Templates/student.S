/* ARM Assembly Course
*  For each lab, use only the instructions/registers already discussed
*/

#include <asm/unistd.h>

.syntax unified

.global Lab1_1
.global Lab1_2
.global Lab1_3
.global Lab2_1
.global Lab2_2
.global Lab2_3
.global Lab2_4
.global Lab3_1
.global Lab3_2
.global Lab3_3
.global Lab3_4
.global Lab4_1
.global Lab4_2
.global Lab5_1
.global Lab5_2
.global Lab5_3
.global Lab5_4
.global Lab5_5
.global Lab5_6
.global Lab5_7
.global Lab5_8
.global Lab6_1
.global Lab6_2
.global Lab6_3
.global Lab7_1
.global Lab7_2
.global Lab7_3
.global Lab7_4
.global Lab8_1
.global Lab9_1
.global Lab9_2
.global Lab9_3
.global HelloWorld
.global LabSize1_1
.global LabSize1_2
.global LabSize1_3
.global LabSize2_1
.global LabSize2_2
.global LabSize2_3
.global LabSize2_4
.global LabSize3_1
.global LabSize3_2
.global LabSize3_3
.global LabSize3_4
.global LabSize4_1
.global LabSize4_2
.global LabSize5_1
.global LabSize5_2
.global LabSize5_3
.global LabSize5_4
.global LabSize5_5
.global LabSize5_6
.global LabSize5_7
.global LabSize5_8
.global LabSize6_1
.global LabSize6_2
.global LabSize6_3
.global LabSize7_1
.global LabSize7_2
.global LabSize7_3
.global LabSize7_4
.global LabSize8_1
.global LabSize9_1
.global LabSize9_2
.global LabSize9_3



.arm

/********************************************************
*    Lab 0                                  *
*       Hello, World                                    *
*********************************************************/

HelloWorld:
     push {r0-r12, lr}
     adr r0, message
     mov r1, #1
     bl printf
     pop {r0-r12, pc}

message:
    .asciz "Hello ARM World %d!\n"
.align 4
/********************************************************
*    Lab 1_1                                  *
*    move the values 256, 257, and 0xffffffff into   *
*    r0, r1, r2 respectively                            *
*       NOTE:  If you get stuck on one, move on for now *
*********************************************************/

Lab1_1:
        push {r5-r11, lr}

        /**** Your code below here ****/
        mov r0, #256
        movt r1, #257
        mov r2,  #0xffffffff
        /**** Your code above here ****/

        pop {r5-r11, pc}

LabSize1_1:
    .long . - Lab1_1 - 8

/********************************************************
*    Lab 1_2                        *
*    exchange values in registers r0 and r1        *
*    REGISTERS: r0, r1, r2                *
*    PRESERVE: nothing                *
*********************************************************/

Lab1_2:
        push {r2, r4-r8, r10-r11, lr }

    /**** Your code below here ****/
    // mov r0, 1
    // mov r1, 2
    // mov r2, 0

    mov r2, r0
    // r0 = 1
    // r1 = 2
    // r2 = 1

    mov r0, r1
    // r0 = 2
    // r1 = 2
    // r2 = 1
    mov r1, r2
    // r0 = 2
    // r1 = 1
    // r2 = 1

    /**** Your code above here ****/

        pop {r2, r4-r8, r10-r11, pc}

LabSize1_2:
    .long . - Lab1_2 - 8

/********************************************************
*    Lab 1_3                        *
*    Perform this action:                *
*    r0 = r1 + r2 + 0x42                *
*    REGISTERS: r0, r1, r2                *
*    PRESERVE: do not use any other registers    *
*                            *
*    NOTE: If you didn’t complete all of the MOV’s   *
*             in Lab 1_1, consider going back after     *
*             this lab and using a combination of     *
*          instructions to accomplish the goal    *
*********************************************************/

Lab1_3:
    push {r2, r3, r5, lr}

    /**** Your code below here ****/
    ADD r0, r1, #0x42
    ADD r0, r0, r2
    /**** Your code above here ****/

    pop {r2, r3, r5, pc}

LabSize1_3:
    .long . - Lab1_3 - 8
/********************************************************************************
*    Lab 2_1                                    *
*    Perform this action:                            *
*    Multiply the value in r0 by 4, exclusive OR r0 with key in r1        *
*    Use only the instructions provided so far                *
*    REGISTERS: r0, r1                            *
*********************************************************************************/
Lab2_1:
    push {r2, r3, r4, r5, lr}
    /**** Your code below here ****/
    /**** Your code above here ****/
    pop {r2-r5, pc}

LabSize2_1:
    .long . - Lab2_1 - 8
/********************************************************************************
*    Lab 2_2                                    *
*    Perform this action:                            *
*    Take the top byte in r0 and place it in the bottom of r1        *
*    zero extended                                *
*********************************************************************************/
Lab2_2:
    push {r2-r5, lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    pop {r2-r5, pc}
LabSize2_2:
    .long . - Lab2_2 - 8
/********************************************************************************
*    Lab 2_3                                    *
*    Perform this action:                            *
*    Reverse the value in r0 (host byte order to network byte order)        *
*    E.g. 0x87654321 to 0x21436587                        *
*    You may use r0, r1, r2, and r3                        *
*********************************************************************************/
Lab2_3:
    push {r1-r5, lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    pop {r1-r5, pc}
LabSize2_3:
    .long . - Lab2_3 - 8
/****************************************************************************************
*    Lab 2_4                                        *
*    Perform this action:                                *
*    Modify lab 2_1 to use  your own key of 0x41414141 by placing that value in r1    *
*    Remember to only use the instructions you have been provided thus far        *
*****************************************************************************************/
Lab2_4:
    push {r1-r5, lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

        bl Lab2_1
    pop {r1-r5, pc}
LabSize2_4:
    .long . - Lab2_4 - 8
/********************************************************************************
*    Lab 3_1                                    *
*    Perform this action:                            *
*    If r0 == 42, r1 = 2, else r1 = 1. If r2 == 42, r3 =1, else r3 = 2    *
*********************************************************************************/
Lab3_1:
    push {lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    pop {pc}
LabSize3_1:
    .long . - Lab3_1 - 8
/********************************************************************************
*    Lab 3_2                                    *
*    Perform this action:                            *
*    Multiply value in r0 by value in r1 with result in r0            *
*        don't forget the edge cases such as multiplying by 0 or 1    *
*        use only the instructions provided so far            *
*********************************************************************************/
Lab3_2:

    push {lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    pop {pc}
LabSize3_2:
    .long . - Lab3_2 - 8
/*  STOP HERE - Additional Instruction Before Lab3_3, Lab3_4  */

/****************************************************************************************
*    Lab 3_3                                        *
*    Redo Lab 3_1 below utilizing "intrinsic" conditional execution (e.g. MOVEQ etc.)*
    If r0 == 42, r1 = 2, else r1 = 1. If r2 == 42, r3 =1, else r3 = 2
*****************************************************************************************/
Lab3_3:

    push {lr}
    /**** Your code below here ****/
    /**** Your code above here ****/
    pop {pc}
LabSize3_3:
    .long . - Lab3_3 - 8
/****************************************************************************************
*    Lab 3_4                                        *
*    Utilize the appropriate MSR/MRS instruction to determine exactly which        *
*    bits of the CPSR are writable in user mode                    *
*    HINT: This lab will crash your executable, therefore, there is no        *
*    regular test code for it.  You will need to use your GDB tools to         *
*    identify the correct answers and fill out the appropriate slide...        *
*****************************************************************************************/
Lab3_4:

    push {lr}
    /**** Your code below here ****/
    /**** Your code above here ****/
    pop {pc}
LabSize3_4:
    .long . - Lab3_4 - 8
/****************************************************************
*    Lab 4_1                            *
*    redo Lab 3_2 using a multiplication instruction        *
*****************************************************************/
Lab4_1:
    push {lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    pop {pc}
LabSize4_1:
    .long . - Lab4_1 - 8
/********************************************************************************
*    Lab 4_2                                                                    *
*    Perform this action:                                                       *
*    Divide r0 by r1 with the result in r0 - this is integer division           *
*    Example:  12/5 = 2                                                         *
*    you do not need to check for division by 0. You are not using UDIV/SDIV    *
*********************************************************************************/
Lab4_2:
    stmfd sp!, {r1-r12, lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    ldmfd sp!, {r1-r12, pc}
LabSize4_2:
    .long . - Lab4_2 - 8
/****************************************************************************************
*    Lab 5_1                                        *
*    swap r0 and r1 using only those registers and the memory pointed to by r3    *
*****************************************************************************************/
Lab5_1:
    stmfd sp!, {r4-r12, lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    ldmfd sp!, {r4-r12, pc}
LabSize5_1:
    .long . - Lab5_1 - 8
/************************************************************************************************
*    Lab 5_2                                            *
*    Set the byte pointed to by r0 to the value of the lowest byte pointed to by r1        *
*    The rest of the value in r0 must remain the same                    *
*************************************************************************************************/
Lab5_2:
    stmfd sp!, {r4-r12, lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    ldmfd sp!, {r4-r12, pc}
LabSize5_2:
    .long . - Lab5_2 - 8
/************************************************************************************************
*    Lab 5_3                                            *
*    Fill the buffer pointed to by r0 with the byte-sized integers from 0-63 inclusive so    *
*    that a memory dump of [r0] will look like: 00 01 02 03 04....                *
*************************************************************************************************/
Lab5_3:
    stmfd sp!, {r4-r12, lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    ldmfd sp!, {r4-r12, pc}
LabSize5_3:
    .long . - Lab5_3 - 8
/********************************************************************************************************
*    Implement strncpy with a small twist - Place the size of the string into the first byte of    *
*    the destination buffer                                        *
*    - Destination will be in r0                                    *
*    - Source will be in r1                                        *
*    - Size of R1 will be in r2.                                    *
*    Remember to only use the instructions you have been provided thus far                *
*********************************************************************************************************/
Lab5_4:
    stmfd sp!, {r4-r12, lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    ldmfd sp!, {r4-r12, pc}
LabSize5_4:
    .long . - Lab5_4 - 8
/********************************************************************************
*    Lab 5_5                                    *
*    rework lab 2_3 with the value to be reversed pointed to in r1        *
*    utilize setend instruction                        *
*    Reverse the value in r0 (host byte order to network byte order)        *
*    E.g. 0x87654321 to 0x21436587                        *
*    You may use r0, r1, r2, and r3                        *

*********************************************************************************/
Lab5_5:
    stmfd sp!, {r4-r12, lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    ldmfd sp!, {r4-r12, pc}
LabSize5_5:
    .long . - Lab5_5 - 8
/****************************************************************************************
*    Lab 5_6                                        *
*    Implement strcpy utilizing Pre or Post indexing form of LDX/STX instructions    *
*    r0 will have the address of the destination buffer                *
*    r1 will have the address of the source string                    *
*****************************************************************************************/
Lab5_6:
    stmfd sp!, {r4-r12, lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    ldmfd sp!, {r4-r12, pc}
LabSize5_6:
    .long . - Lab5_6 - 8
/************************************************************************************************
*    Lab 5_7                                            *
*    Transfer a block of data using the ldm/stm instructions and registers r3-r12        *
*    Pointer to destination will be in r0                            *
*    Pointer to source will be in r1                                *
*    Size in bytes will be in r2                                *
*    Data size will be a multiple of 10 words to make it easy                *
*    PRESERVE: all registers                                                *
*************************************************************************************************/
Lab5_7:
    stmfd sp!, {r0-r12, lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    ldmfd sp!, {r0-r12, pc}
LabSize5_7:
    .long . - Lab5_7 - 8

/********************************************************************************
*    Lab 5_8 - BONUS!!!!                                *
*    Same as above, but the data size may not be in 10 word chunks.        *
*    Your code should be able to handle any size data, while still        *
*    making use of the ldm/stm instructions for the bulk of the work.    *
*********************************************************************************/
Lab5_8:
    stmfd sp!, {r0-r12, lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    ldmfd sp!, {r0-r12, pc}
LabSize5_8:
    .long . - Lab5_8 - 8
/************************************************************************
*    Lab 6_1                                *
*    Exchange r0 and r1 using ONLY push and pop instructions        *
*    PRESERVE:  all but r0 and r1                     *
*************************************************************************/
Lab6_1:
    stmfd sp!, {r4-r12, lr}

    /**** Your code below here ****/
    /**** Your code above here ****/

    ldmfd sp!, {r4-r12, pc}
LabSize6_1:
    .long . - Lab6_1 - 8
/********************************************************
*    Lab 6_2                        *
*    push r0-r12, then exchange r1 and r2         *
*    PRESERVE: all but r1 and r2 and ensure        *
*    you leave the stack the way you found it    *
*********************************************************/
Lab6_2:
    stmfd sp!, {r4-r12, lr}
    /**** Your code below here ****/
    /**** Your code above here ****/

    ldmfd sp!, {r4-r12, pc}
LabSize6_2:
    .long . - Lab6_2 - 8
/****************************************************************
*    Lab 6_3                            *
*    remove 0x100 bytes from the top of the stack        *
*    preserve all but SP                    *
*    If done incorrectly, you will likely crash!        *
*****************************************************************/
Lab6_3:

    /**** Your code below here ****/
    /**** Your code above here ****/
    mov pc, lr
LabSize6_3:
    .long . - Lab6_3 - 4
/********************************************************************************************************
*    Lab7_1                                                *
*    Mode changes...write a simple function to change modes to Thumb from ARM            *
*    Confirm that you have changed modes by examining the CPSR register while stepping        *
*    through the function.  Return to ARM mode upon exit.                         *
*    From here on - you are responsible for preserving the appropriate registers!             *
*    Bonus - make mode changes using arithmetic instructions                        *
*                                                    *
*********************************************************************************************************/

Lab7_1:
    /**** Your code below here ****/
    /**** Your code above here ****/
LabSize7_1:
    .long . - Lab7_1
/****************************************************************************************
*    Lab 7_2                                        *
*    Mode changes...Redo Lab3_1 in Thumb mode.                    *
*        Lab 3_1                                    *
*        Perform this action:                            *
*        If r0 == 42, r1 = 2, else r1 = 1. If r2 == 42, r3 =1, else r3 = 2    *
*****************************************************************************************/
Lab7_2:

    /**** Your code below here ****/
    /**** Your code above here ****/
LabSize7_2:
    .long . - Lab7_2

/********************************************************************************************************
*    Lab7_3                                                *
*    Write to stdout by executing a system call.                            *
*    Your buffer is at the symbol string_7_3.  Standard file descriptors - 1 is stdout        *
*     Syscall numbers are found in asm/unistd.h                            *
*********************************************************************************************************/
Lab7_3:

    /**** Your code below here ****/
    /**** Your code above here ****/


LabSize7_3:
    .long . - Lab7_3

string_7_3:
    .ascii "--->Lab7_3 Passed! \n"
.align 4
string_7_3_size:
    .long . - string_7_3
.align 4

Function1:
    push {r4, r11, lr}
    add r11, sp, #8

    add r0, r1
    sub r0, r2
    eor r0, r3
    ldr r4, [r11, #4]
    mul r0, r4

    sub sp, r11, #8
    pop {r4, r11, lr}
    bx lr

/********************************************************************************************************
*    Lab7_4                                                *
*    You have been passed 5 numbers according to the ARM calling convention                *
*    Call the function: Function1(int a, int b, int c, int d, int e) in your code.            *
*    Call the function with the values you have been passed.                        *
*    Take the value it returns and multiply it by 4                            *
*    and return the result                                        *
*                                                    *
*    If you get stuck, look at Function1 for guidance on convention                    *
*********************************************************************************************************/
Lab7_4:
    /**** Your code below here ****/
    /**** Your code above here ****/

LabSize7_4:
    .long . - Lab7_4
/********************************************************************************************************
*    Lab 8_1                                                *
*    Use the appropriate manual to research instructions to use to accomplish the following:        *
*    copy 32 bits each from r0 and r1 to vector register d0 and r2, r3 to d1.              *
*                                                    *
*    In one instruction, add each 8 bit vector component together.  Return the results        *
*    to r0 and r1.  You will need to use NEON instructions.                      *
*********************************************************************************************************/
Lab8_1:

    /**** Your code below here ****/
    /**** Your code above here ****/
LabSize8_1:
    .long . - Lab8_1
/*********************************************************************************************************
*    BONUS!!!!!                                                                                       *
*********************************************************************************************************/
/*********************************************************************************************************
*    Lab 9_1                                                                                             *
*    Write a function that takes as a single argument (N) and returns the Nth fibonacci number.       *
*    Assume the sequence starts at 0, and is 1-based (that is, the first number is 0, the second is   *
*    1, and there is no 0th number).                                           *
**********************************************************************************************************/
.align 4
Lab9_1:
    /**** Your code below here ****/
    /**** Your code above here ****/


LabSize9_1:
    .long . - Lab9_1
/********************************************************************************************************
*    Lab 9_2
*    Write a function that takes as a single argument (N) and returns the sum of the natural numbers
*    from 0 to N that are multiples of both 3 and 5.  Bonus if you only use add/sub (no mul/divide)
**********************************************************************************************************/
Lab9_2:
    /**** Your code below here ****/
    /**** Your code above here ****/


LabSize9_2:
    .long . - Lab9_2
/********************************************************************************************************
    Lab 9_3
    Write a function that takes as arguments:
    1) an integer N representing the length of
    2) a pointer to an array of integers.
    Return the largest product of five consecutive integers.
      Worded another way: find the largest product of five consecutive
    integers within an N-length array of integers.
*********************************************************************************************************/
Lab9_3:
    /**** Your code below here ****/
    /**** Your code above here ****/
LabSize9_3:
    .long . - Lab9_3
