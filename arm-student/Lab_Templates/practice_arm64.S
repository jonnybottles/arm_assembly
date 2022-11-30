/* ARM Assembly Course
*  For each lab, use only the instructions/registers already discussed
*/

#include <asm/unistd.h>


.global asm_practice

/********************************************************
*    Practice                                           *
*       Use this file to practice writing asm           *
*       The practice function is invoked from c         *
*         via test_harness.c                            *
*********************************************************/

asm_practice:
    /**** Your code below here ****/
    sub	sp, sp, #0x10 //Modify this to allocate enough stack space
    //stp	x29, x30, [sp,#32] //Save registers
    
    //ldp	x29, x30, [sp,#32] //Restore registers
    add	sp, sp, #0x10 //Modify this to restore stack space 
    /**** Your code above here ****/
    ret
.align 4
