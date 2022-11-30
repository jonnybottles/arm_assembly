/* ARM Assembly Course
*  For each lab, use only the instructions/registers already discussed
*/

#include <asm/unistd.h>


.syntax unified

.global thumb_stub

/********************************************************
*    Practice                                           *
*       Use this file to practice writing asm           *
*       The practice function is invoked from c         *
*         via test_harness.c                            *
*********************************************************/

.arm
thumb_stub:
    push {lr}
    blx thumb_practice
    pop {pc}

.align 4

.thumb

thumb_practice:
    push {r0-r12, lr}
    /**** Your code below here ****/
    /**** Your code above here ****/
    pop {r0-r12, pc}

.align 4
