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
    mov r1, #260
    /**** Your code above here ****/
    pop {r0-r12, pc}

.align 4
