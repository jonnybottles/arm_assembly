/*

   Test harness for ARM Assembly labs.

*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <string.h>
#include <stdarg.h>
#include <arm_neon.h>
#include <dlfcn.h>
#include "student.h"

struct ARM_REGS
{                // Struct of registers r0-12
    uint32_t r0; // After each test, the register
    uint32_t r1; // state is saved so they can be
    uint32_t r2; // tested by the harness code.
    uint32_t r3;
    uint32_t r4;
    uint32_t r5;
    uint32_t r6;
    uint32_t r7;
    uint32_t r8;
    uint32_t r9;
    uint32_t r10;
    uint32_t r11;
    uint32_t r12;
};

#define LAB_VALIDATED(level, num)                                                    \
    printf("Lab %d.%d validated (%lu bytes)\n", level, num, LabSize##level##_##num); \

static void test_wrapper(struct ARM_REGS *regs, void *func, ...)
{
    va_list args;
    va_start(args, func);

    asm(
        "ldr lr, %[func]\n\t"
        "ldr r4, %[args]\n\t"    // load address of args into r4
        "ldmia r4!, {r0-r3}\n\t" // Set up r0-r3 for call to function label.

        "ldr r5, [r4, #4]\n\t" // pass args 5 and 6 (untested)
        "push {r5}\n\t"
        "ldr r5, [r4]\n\t"
        "push {r5}\n\t"

        "blx lr\n\t"     // Branch to Function Label
        "add sp, #8\n\t" // cleanup args 5 & 6

        "ldr lr, %[regs]\n\t"    // Load Regs struct into lr
        "stmia lr, {r0-r12}\n\t" // Fill Regs struct with r0-r12
        :
        : [func] "irm"(func), [args] "irm"(args), [regs] "m"(regs)
        : "r0", "r1", "r2", "r3", "r4", "r5", "lr" // List of registers we clobber
    );

    va_end(args);
}

int main(int argc, char *argv[])
{
    int failed = 0;
    int section_failed = 0;
    int a = 1;
    int b = 2;
    int c = 3;
    char d[64];
    int z = 4;

    struct ARM_REGS regs;

#define FAILED(msg, ...)            \
    ({                              \
        printf(msg, ##__VA_ARGS__); \
        failed++;                   \
        section_failed++;           \
    })

    HelloWorld();

    // Practice
    printf("Calling arm_practice...\n");
    arm_practice();
    printf("...arm_practice finished.\n");
    printf("Calling thumb_practice...\n");
    thumb_stub();
    printf("...thumb_practice finished.\n");

    //*********************************************
    //	Lab1_1
    //	mov r0 <- 256, r1 <- 257, r2 <- -1
    //*********************************************

    test_wrapper(&regs, Lab1_1);
    if (regs.r0 != 256 ||
        regs.r1 != 257 ||
        regs.r2 != -1)
        FAILED("Failed Lab1_1!\n");
    else
    {
        LAB_VALIDATED(1, 1)
    }

    //*********************************************
    //	Lab1_2
    //	swap r0, r1
    //*********************************************
    test_wrapper(&regs, Lab1_2, 1, 2);
    if (regs.r0 != 2 || regs.r1 != 1)
        FAILED("Failed Lab1_2!\n");
    else
    {
        LAB_VALIDATED(1, 2)
    }

    //*********************************************
    //	Lab1_3
    //	r0 = r1 + r2 + 0x42
    //*********************************************
    test_wrapper(&regs, Lab1_3, 1, 2, 3);
    if (regs.r0 != 71)
        FAILED("Failed Lab1_3!\n");
    else
    {
        LAB_VALIDATED(1, 3)
    }

    if (section_failed)
        return EXIT_FAILURE;
    printf("----------------\n");

    //*********************************************
    //	Lab2_1
    //	r0 = r1 ^ (r0 * 4)
    //*********************************************
    test_wrapper(&regs, Lab2_1, 4, 0x42424242);
    if (regs.r0 != (0x42424242 ^ (4 * 4)))
        FAILED("Failed Lab2_1!\n");
    else
    {
        LAB_VALIDATED(2, 1)
    }

    //*********************************************
    //	Lab2_2
    //	Top byte of r0 into r1
    //*********************************************
    test_wrapper(&regs, Lab2_2, 0xff000000);
    if (regs.r1 != 0xff)
        FAILED("Failed Lab2_2!\n");
    else
    {
        LAB_VALIDATED(2, 2)
    }

    //*********************************************
    //	Lab2_3
    //	Reverse the value in r0 (host byte oder to network byte order)
    //*********************************************
    test_wrapper(&regs, Lab2_3, 0x87654321);
    if (regs.r0 != 0x21436587)
        FAILED("Failed Lab2_3: should have 0x21436587, did have %x!\n", regs.r0);
    else
    {
        LAB_VALIDATED(2, 3)
    }

    //*********************************************
    //      Lab2_4
    //	Do Lab2_1 but first put your own key of 0x41414141 in r1
    //*********************************************
    test_wrapper(&regs, Lab2_4, 4);
    if (regs.r0 != 0x41414151)
        FAILED("Failed Lab2_4! ,you had %X, should have had 0x41414151\n", regs.r0);
    else
    {
        LAB_VALIDATED(2, 4)
    }

    if (section_failed)
        return EXIT_FAILURE;
    printf("----------------\n");


    //*********************************************
    //	Lab3_1
    //	if (r0 == 42) r1 = 2; if (r2 == 42) r3 = 2;
    //*********************************************
    test_wrapper(&regs, Lab3_1, 41, 0, 42, 0);
    if (regs.r1 != 2 && regs.r3 != 1)
        FAILED("Lab3_1 Failed!\n");
    else
    {
        LAB_VALIDATED(3, 1)
    }

    //*********************************************
    //	Lab3_2
    //	r0 *= r1
    //*********************************************
    failed = 0;
    test_wrapper(&regs, Lab3_2, 0, 4);
    if (regs.r0 != (0 * 4))
    {
        FAILED("Lab3_2 failed, should have %d, did have %d!\n", (0 * 4), regs.r0);
    }

    test_wrapper(&regs, Lab3_2, 4, 0);
    if (regs.r0 != (4 * 0))
    {
        FAILED("Lab3_2 failed, should have %d, did have %d!\n", (4 * 0), regs.r0);
    }

    test_wrapper(&regs, Lab3_2, 1, 6);
    if (regs.r0 != (1 * 6))
    {
        FAILED("Lab3_2 failed, should have %d, did have %d!\n", (1 * 6), regs.r0);
    }

    test_wrapper(&regs, Lab3_2, 6, 1);
    if (regs.r0 != (6 * 1))
    {
        FAILED("Lab3_2 failed, should have %d, did have %d!\n", (6 * 1), regs.r0);
    }

    test_wrapper(&regs, Lab3_2, 15, 4);
    if (regs.r0 != (15 * 4))
        FAILED("Lab3_2 failed, should have %d, did have %d!\n", (15 * 4), regs.r0);

    if (!failed)
    {
        LAB_VALIDATED(3, 2)
    }

    //*********************************************
    //	Lab3_3
    //*********************************************
    test_wrapper(&regs, Lab3_3, 41, 0, 42, 0);
    if (regs.r1 != 2 && regs.r3 != 1)
        FAILED("Lab3_3 Failed!\n");
    else
    {
        LAB_VALIDATED(3, 3)
    }

    //*********************************************
    //	Lab3_4
    //	Determine which bits of the CPSR
    //	are modifiable in user mode.
    //*********************************************
    Lab3_4();

    printf("--->Lab3_4 didn't crash...\n");

    if (section_failed)
        return EXIT_FAILURE;
    printf("----------------\n");

    //*********************************************
    //	Lab4_1
    //	r0 *= r1, again
    //*********************************************

    failed = 0;
    test_wrapper(&regs, Lab4_1, 0, 4);
    if (regs.r0 != (0 * 4))
    {
        FAILED("Lab4_1 failed, should have %d, did have %d!\n", (0 * 4), regs.r0);
    }

    test_wrapper(&regs, Lab4_1, 4, 0);
    if (regs.r0 != (4 * 0))
    {
        FAILED("Lab4_1 failed, should have %d, did have %d!\n", (4 * 0), regs.r0);
    }

    test_wrapper(&regs, Lab4_1, 1, 7);
    if (regs.r0 != (1 * 7))
    {
        FAILED("Lab4_1 failed, should have %d, did have %d!\n", (1 * 7), regs.r0);
    }

    test_wrapper(&regs, Lab4_1, 7, 1);
    if (regs.r0 != (7 * 1))
    {
        FAILED("Lab4_1 failed, should have %d, did have %d!\n", (7 * 1), regs.r0);
    }

    test_wrapper(&regs, Lab4_1, 15, 6);
    if (regs.r0 != (15 * 6))
        FAILED("Lab4_1 failed, should have %d, did have %d!\n", (15 * 6), regs.r0);

    if (!failed)
    {
        LAB_VALIDATED(4, 1)
    }

    //*********************************************
    //	Lab4_2
    //	r0 /= r1
    //*********************************************
    failed = 0;

    test_wrapper(&regs, Lab4_2, 1, 8);
    if (regs.r0 != (1 / 8))
    {
        FAILED("Lab4_2 failed, should have %d, did have %d!\n", (1 / 8), regs.r0);
    }

    test_wrapper(&regs, Lab4_2, 8, 1);
    if (regs.r0 != (8 / 1))
    {
        FAILED("Lab4_2 failed, should have %d, did have %d!\n", (8 / 1), regs.r0);
    }

    test_wrapper(&regs, Lab4_2, 15, 4); //a divided by b -- integer division
    if (regs.r0 != (15 / 4))
        FAILED("Lab4_2 failed, should have %d, did have %d!\n", (15 / 4), regs.r0);

    if (!failed)
    {
        LAB_VALIDATED(4, 2)
    }

    if (section_failed)
        return EXIT_FAILURE;
    printf("----------------\n");

    //*********************************************
    //	Lab5_1
    //	swap r0 and r1 using memory at r3
    //*********************************************
    test_wrapper(&regs, Lab5_1, 15, 2, 0, &a);
    if (regs.r0 != 2 || regs.r1 != 15)
        printf("Lab5_1 failed!\n");
    else
    {
        LAB_VALIDATED(5, 1)
    }

    //*********************************************
    //	Lab5_2
    //	set byte pointed to by r0 to the lowest byte pointed to by r1
    //*********************************************
    a = 0xaabbccdd;
    b = 0x11223344;
    test_wrapper(&regs, Lab5_2, &a, &b);
    if (a != 0xaabbcc44)
        printf("Failed Lab5_2!\n");
    else
    {
        LAB_VALIDATED(5, 2)
    }

    //*********************************************
    //	Lab5_3
    //	Fill buffer pointed to by r0 with byte-sized integers from 0-63 inclusive
    //*********************************************
    test_wrapper(&regs, Lab5_3, d);
    for (a = 0; a < 64; a++)
    {
        if ((int)d[a] != a)
        {
            ++failed;
            break;
        }
    }
    if (!failed)
    {
        LAB_VALIDATED(5, 3)
    }
    else
        printf("Failed Lab5_3!\n");

    //*********************************************
    //	Lab5_4
    //	Copy a string, prepend length to dest
    //  TODO: Add some more test cases
    //*********************************************
    {
        char buffer[32];
        const char *proverb = "Forewarned, ForeARMed";

        strcpy(buffer, "XAAAAAAAAAAAAAAAAAAAAABCDEEE");
        test_wrapper(&regs, Lab5_4, buffer, proverb, strlen(proverb));
        if (buffer[0] != strlen(proverb))
            FAILED("Failed Lab5_4!: wrong lenth reported, had %d should have had %d\n",
                   buffer[0], strlen(proverb));
        else if (strncmp(buffer + 1, proverb, strlen(proverb)))
            FAILED("Failed Lab5_4!: data did not match\n");
        else if ('B' != buffer[strlen(proverb) + 1])
            FAILED("Failed Lab5_4!: copied past provided length %c\n", buffer[strlen(proverb) + 1]);

        strcpy(buffer, "XAAAAAAAAAAAAAAAAAAAAABCDEEE");
        test_wrapper(&regs, Lab5_4, buffer, proverb, sizeof(buffer));
        if (buffer[0] != strlen(proverb))
            FAILED("Failed Lab5_4!:wrong lenth reported, had %d should have had %d\n",
                   buffer[0], strlen(proverb));
        if (buffer[1 + strlen(proverb)])
            FAILED("Failed Lab5_4!: Didn't copy null terminator");
        if ('C' != buffer[1 + strlen(proverb) + 1])
            FAILED("Failed Lab5_4!: Copied past null terminator");

        if (!failed)
        {
            LAB_VALIDATED(5, 4)
        }
    }
    //*********************************************
    //	Lab5_5
    //	Host byte order to Network byte order (using setend)
    //*********************************************
    a = 0x87654321;
    test_wrapper(&regs, Lab5_5, 0, &a);
    if (a != 0x21436587)
        FAILED("Failed Lab5_5!\n");
    else
    {
        LAB_VALIDATED(5, 5)
    }

    if (section_failed)
        return EXIT_FAILURE;

    //*********************************************
    //	Lab5_6
    //	Implement strcpy
    //*********************************************
    {
        char src[32];
        char dest[32];
        char check[32];

        memset(src, 0, sizeof(src));
        memset(dest, 'A', sizeof(dest));
        memset(check, 'A', sizeof(check));
        strcpy(src, "This is the data\n");
        strcpy(check, src);

        test_wrapper(&regs, Lab5_6, dest, src);

        if (memcmp(check, dest, sizeof(dest)))
            FAILED("Lab5_6 failed: data did not match!\n");
        else
        {
            LAB_VALIDATED(5, 6)
        }
    }
    if (section_failed)
        return EXIT_FAILURE;
    printf("----------------\n");

    //*********************************************
    //	Lab5_7
    //	Transfer blocks of data at a time with ldm/stm
    //*********************************************
    {
        char data[1024] = {0};
        char buffer[1024] = {0};

        memset(data, 'x', sizeof(data));
        memcpy(data,
               "I'm very well acquainted, too, with matters mathematical, "
               "I understand equations, both simple and quadratical...........\n",
               120);

        test_wrapper(&regs, Lab5_7, buffer, data, 120);
        if (memcmp(data, buffer, 120) != 0)
            FAILED("Lab5_7 failed!, transferred data does not match original data.\n");
        else if (buffer[120] == 'x')
            FAILED("Lab5_7 failed!, you transferred too much data!!\n");
        else
        {
            LAB_VALIDATED(5, 7)
        }
    }
    //*********************************************
    //	Lab5_8
    //	Transfer blocks of data at a time with ldm/stm
    //*********************************************
    {
        char data[1024] = {0};
        char buffer[1024] = {0};

        memset(buffer, 0, sizeof(buffer));
        memcpy(data + 120, "some more random data\n", 22);
        test_wrapper(&regs, Lab5_8, buffer, data, 142);
        if (memcmp(data, buffer, 142) != 0)
            printf("Lab5_8 failed!, transferred data does not match original data.\n");
        else if (buffer[142] == 'x')
            printf("Lab5_8 failed!, you transferred too much data!\n");
        else
        {
            LAB_VALIDATED(5, 8)
        }

        if (section_failed)
            return EXIT_FAILURE;
    }
    printf("----------------\n");

    //*********************************************
    //	Lab6_1
    //	Exchange r0, r1 using push and pop
    //*********************************************
    test_wrapper(&regs, Lab6_1, 1, 2);
    if (regs.r0 != 2 || regs.r1 != 1)
        FAILED("Failed Lab6_1!\n");
    else
    {
        LAB_VALIDATED(6, 1)
    }

    //*********************************************
    //	Lab6_2
    //	Exchange r1, r2 by pushing r0-r12 and popping them
    //*********************************************
    test_wrapper(&regs, Lab6_2, 0, 1, 2);
    if (regs.r1 != 2 || regs.r2 != 1)
        FAILED("Failed Lab6_2!\n");
    else
    {
        LAB_VALIDATED(6, 2)
    }

    //*********************************************
    //	Lab6_3
    //	Add 0x100 to the stack
    //*********************************************

    asm("stmfd sp!, {r1-r12}\n\t"
        "mov r5, sp\n\t"
        "sub sp, #0x100\n\t"
        "bl Lab6_3\n\t"
        "sub r0, sp, r5\n\t"
        "mov sp, r5\n\t"
        "ldmfd sp!, {r1-r12}\n\t"
        "mov %[diff], r0\n\t"
        : [diff] "+r"(a)
        :
        :);
    if (a)
        FAILED("Lab6_3 Failed - the stack pointer is off by %d!\n", a);
    else
    {
        LAB_VALIDATED(6, 3)
    }

    if (section_failed)
        return EXIT_FAILURE;
    printf("----------------\n");

    //*********************************************
    //	Lab7_1
    //	switch modes
    //*********************************************
    //test_wrapper(&regs, Lab7_1); //allows for b Lab7_1 functionality to work properly
    Lab7_1();

    printf("--->Lab7_1 didn't crash\n");

    //*********************************************
    //	Lab7_2
    //	Redo 3_3 in thumb mode (if(r0 == 42) r1=2...)
    //*********************************************
    test_wrapper(&regs, Lab7_2, 41, 0, 42, 0);
    if (regs.r1 != 2 && regs.r3 != 1)
        FAILED("Lab7_2 failed!\n");
    else
    {
        LAB_VALIDATED(7, 2)
    }

    //*********************************************
    //	Lab7_3
    //	Write to stdout with a syscall.
    //      Test harness doesn't validate this one
    //*********************************************
    test_wrapper(&regs, Lab7_3);

    //*********************************************
    //	Lab 7_4
    //	Call an internal function with 5 arguments. One argument
    //      will be on the stack and should be fetched from the
    //      stack. Return value in R0.
    //*********************************************
    test_wrapper(&regs, Lab7_4, 1, 2, 3, 4, 5);
    if (regs.r0 != 80)
        printf("Failed!, Returned: %d should have been %d\n", regs.r0, 80);
    else
    {
        LAB_VALIDATED(7, 4)
    }

    if (section_failed)
        return EXIT_FAILURE;
    printf("----------------\n");

    //*********************************************
    //	Lab8_1
    //	Use neon instructions to mov r0 and r1 into d0, r2 and
    //      r3 into d1, then add each 8 bit vector component
    //	return values in r0 and r1
    //*********************************************
    test_wrapper(&regs, Lab8_1, 0xa0a0a0a0, 0xb1b1b1b1, 0xc0c0c0c0, 0xd1d1d1d1);
    if (regs.r0 != 0x60606060 || regs.r1 != 0x82828282)
        FAILED("Lab 8_1 failed\n");
    else
    {
        LAB_VALIDATED(8, 1)
    }

    if (section_failed)
        return EXIT_FAILURE;
    printf("----------------\n");


    //*********************************************
    //	Lab9_1
    //	Fibonacci
    //*********************************************

    a = Lab9_1(1);
    b = Lab9_1(10);
    if (a != 0 || b != 34)
        FAILED("Lab9_1 Failed!\n");
    else
    {
        LAB_VALIDATED(9, 1)
    }

    //*********************************************
    //	Lab9_2
    //	sum of multiples of both 3 and 5
    //*********************************************

    a = Lab9_2(0);
    b = Lab9_2(100);
    c = Lab9_2(200);
    z = Lab9_2(0xffff);
    if (a != 0 || b != 315 || c != 1365 || z != 143193975)
        FAILED("Lab9_2 Failed!\n");
    else
    {
        LAB_VALIDATED(9, 2)
    }

    //*********************************************
    //	Lab9_3
    //	Largest set of 5 integers
    //*********************************************

    int list1[] = {1, 2, 3, 4, 5, 6, 5, 7, 8, 9, 1, 2};
    int *list1p = list1;
    a = Lab9_3(12, list1p);
    b = Lab9_3(5, list1p);

    if (a != 15120 || b != 120)
        FAILED("Lab9_3 Failed Should have 15120, did have %d!\n", a);
    else
    {
        LAB_VALIDATED(9, 3)
    }

    if (section_failed)
        return EXIT_FAILURE;
    printf("----------------\n");

    printf("Congrats, you finished all the labs!\n");
    return EXIT_SUCCESS;
}
