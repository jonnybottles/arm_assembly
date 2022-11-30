LAB CONTENTS:

student.S        - Contains course labs to be completed by the student.
student.h        - Headoer file used for the labs. You will not need to modify this file.
Makefile         - Contains rules necessary to build the contained source files.
check_textrel.sh - Script used by Makefile to ensure your code will run on the pixel 3.
test_harness.c   - Contains test code for labs and practice files.
practice_arm.S   - Utility file for use by student for testing ARM instructions.
practice_thumb.S - Utility file for use by student for testing THUMB instructions.
practice_arm64.S - Utility file for use by student for testing ARM64 instructions.
                   NOTE: We will not be using this unless we finish the class early.

IMPORTANT NOTES:

This is an intermediate-level class. Let the instructor know if you think that
you may be out of your comfort zone and we will make sure that you get the most of of it.

If you have prior experience with another assembly language such as x86, then you should
find this class straight-forward. If you have never written any C or ASM code before,
then you will likely find this course quite challenging.

ASSEMBLY CODING CAN GET BORING. IF YOU ARE GETTING SLEEPY, MOVE AROUND AND TAKE A BREAK!

This is a very hands-on class. Much of your time will be spent coding. When you
run into trouble building or executing your code, or have difficulty coming up with the solution
to a lab problem - please try to do it yourself first. But, when you get stuck,
you are encouraged to ask a neighbor for assistance before asking the teacher. This
gives your neighbor an opportunity to reinforce his/her learning by helping you.

We are all comrades who came here to learn, and you will learn more by working
collaboratively with your neighbors (and helping them when they are stuck).
When you have completed this lab setup, please assist your neighbors with theirs.

This course assumes that you have some familiarity with Linux. You will need to ask a
neighbor for help if it has been a while since you used a Linux machine. You need to
be able to make quick edits to source code files in this class, and you will need to
have at least two linux terminals open at the same time to complete the labs. We will
not be covering basic linux commands such as 'cp', 'cd', 'ls', etc. If you feel that
you are very rusty and/or are having difficulty following along, you are encouraged to
use pen and paper to make yourself a cheat sheet, or take notes here in this file!

Do not use the internet if you get lost and need to catch up - ask the instructor for help!

If you finish the labs that the class is working on early, you are encouraged to skip
ahead at your own pace; however, please assist your comrades too, and ask your teacher
interesting questions.


REGARDING THE EXAM

Hint: Take notes in your slide book while the instructor is presenting. If you take
excellent notes, complete all of the labs, and pay attention to some tricks that the
instructor may show you, you should not have much trouble passing the exam.

Hint: This class is difficult partly because of its length. 8 hours of lecture and coding
can get very tiring. Please do everything you can to stay ALERT during the class, so that
you do not miss any hints or tricks.

Hint: If you are not sure how some assembly code would behave, code it. The quizzes and
the exam are all open laptop. By writing a short snippet of assembly code and running it,
you will learn a lot about it. Do not be afraid to run assembly code that mighit not work!
You should always check your own work and double-check the exact wording of quiz/exam questions.
Remember that there are often multiple ways to figure out the answer to a particular question.


LAB SETUP INSTRUCTIONS:

0) This is an ASSEMBLY class. Your mind must be in the right state. Begin counting from zero.
   Make two backup copies of the entire folder containing all of the student lab materials. You
   may discover that you accidentally did something bad that prevents you from compiling or whatever.
   These files are tiny and you may make as many backup copies of things as you like.

1) Turn ON your phone, and plug it into your computer using the provided USB cable.
NOTE: You may see a warning message at startup about an unlocked bootloader. This is normal.
      You may need to turn ON your phone. Press and hold the button on the top-right side
      of the device to turn it on. If it does not power on, it may be out of batteries.
      It is safe to use the device while the batteries are charging. If your phone battery
      is dead, give it a couple minute to charge via USB and then power it on while it is
      plugged into the laptop.
      To prevent your phone's battery from dying, power it off before you leave for the day.

2) Go to phone settings app by dragging your finger UP from the bottom of the screen.
   Tap the "gear" icon. Ask a neighbor or your instructor if you need help navigating menus.
   Note that these menus appear in different places on different Android phones.
   Note that some of the classroom phones may already have these options set; however,
   do not assume that just because some of these options may have been set for you, that they
   all have been set correctly.

   Perform the following steps:
- Turn OFF Wifi
- Turn OFF Location Services
- Disable system updates
- Turn your phone volume to 50%. Use the two buttons on the phone below the power button to do this.
- Enable Developer Options
    This is a tricky one. To do this,e
    a) Navigate to Settings->About phone
    b) tap the Build number repeatedly until you see:
        'you are a developer'
        or
        'you are already a developer'
- Now navigate to settings->system->advanced->Developer options
  a) Set 'stay-awake' to ON
  b) Set 'lock screen' option to None
  c) Enable USB debugging
  d) tap 'revoke USB debugging authorizations'
  c) Set 'Default USB Configuration' to 'PTP'
NOTE: Check with instructor to ensure that you have completed these steps completely.

3) Run the following command to make sure that your phone is connected.
adb devices
NOTE: You will likely need to accept a popup message on the phone to authorize your PC
      If you see an 'unauthorized' device when you run the above command, you likely
      need to accept the popup message. If you don't see the popup message but your 
      device is still 'unauthorized', make sure that you enabled USB debugging. Revoke
      USB debugging authorizations and toggle USB debugging OFF and ON again. If that
      doesn't make the popup appear, try rebooting the phone.

4) Copy gdbserver from the lab folder to /data/local/tmp on your phone

5) execute the following command (on host) to enable gdb to communicate with the phone:
adb forward tcp:1111 tcp:1111

6) Verify that you can build and execute the labs on the phone by running:
make test
NOTE: You should see a "hello world" message indicating thhat your code ran on the phone
      If you see errors, ask a neighbor to help or call the instructor over to help you ASAP.

7) Verify that you can use gdb/gdbserver with your phone by running:
make gdb
NOTE: Follow the instructions that are printed on your terminal now to connect to gdbserver.
      ^^ YOU WILL NEED TO USE A SECOND TERMINAL TO DO THIS ^^
      Run 'continue' once connected to gdbserver and ensure that the program runs to completion.
      If you see errors, ask a neighbor to help or call the instructor over to help you ASAP.

8) Copy the .gdbinit file from the lab materials folder to your home directory. This is very
   important, because it will make it much easier for you to use GDB correctly.

9) Add the following to your ~/.bashrc file:
alias gdb='arm-linux-androideabi-gdb'
alias objdump='arm-linux-androideabi-objdump'
alias readelf='arm-linux-androideabi-readelf'
alias objdump64='aarch64-linux-android-objdump'
NOTE: This will make it easier for you to reverse-engineer and test your compiled/assembled code.

10) Configure your editing environment for writing code.
NOTE: You will need to be able to make quick changes to source to reduce test cycle time.

11) Learn your tools:
NOTE: Collectively, these are the "swiss-army knife" for working with Android ARM assembly files.
make
adb
xxd
arm-linux-androideabi-gdb (We will be using this extensively in this class)
arm-linux-androideabi-readelf
arm-linux-androideabi-objdump
arm-linux-androideabi-objcopy
arm-linux-androideabi-gcc
arm-linux-androideabi-as
NOTE: You are welcome to modify your makefile, but please make a backup copy before you do this.

12) Copy libc.so off of your phone and onto your PC so we can take a look at the ARM instructions
    that are inside of it. Ask the instructor how to do this.
