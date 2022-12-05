/* ARM Assembly Course
*  For each lab, use only the instructions/registers already discussed
*/

#include <asm/unistd.h>


.syntax unified

.global arm_practice

/********************************************************
*    Practice                                           *
*       Use this file to practice writing asm           *
*       The practice function is invoked from c         *
*         via test_harness.c                            *
*********************************************************/

.arm

arm_practice:
    push {r0-r12, lr}
    /**** Your code below here ****/
    mov r0, #1
    mov r1, #2
    mov r2, #3
    add r0, r1, r2, lsl#2
/**** Your code above here ****/
    pop {r0-r12, pc}

.align 4

// HelloWorld:
//      push {r0-r12, lr}
//      adr r0, message
//      mov r1, #1
//      bl printf
//      pop {r0-r12, pc}

// message:
//     .asciz "Hello ARM World %d!\n"
// .align 4
