all: install
build: clean student

clean: # remove IFF files already exists
	rm -f student
	rm -f practice_arm
	rm -f practice_thumb
	rm -f practice_arm.o
	rm -f practice_thumb.o
	rm -f student_hexdump
	rm -f practice64
	rm -f practice_arm64.o
	rm -f practice_arm_hexdump
	rm -f practice_thumb_hexdump
	rm -f practice_thumb_text.bin
	rm -f practice_arm_text.bin

student: student.S test_harness.c # build 'student' and verify that it has no .text relocations
	arm-linux-androideabi-as practice_arm.S -o practice_arm.o
	arm-linux-androideabi-as practice_thumb.S -o practice_thumb.o
	@./check_textrel.sh practice_arm.o || (echo "FATAL: .text relocations present."; rm student; exit 1)
	@./check_textrel.sh practice_thumb.o || (echo "FATAL: .text relocations present."; rm student; exit 1)
	arm-linux-androideabi-objcopy practice_thumb.o --dump-section .text=practice_thumb_text.bin
	arm-linux-androideabi-objcopy practice_arm.o --dump-section .text=practice_arm_text.bin
	arm-linux-androideabi-gcc practice_arm.o practice_thumb.o -fpic -Wl,-pie -march=armv7-a -g -mfpu=neon -mfloat-abi=softfp -o student $^
	@./check_textrel.sh student || (echo "FATAL: .text relocations present."; rm student; exit 1)
	xxd student > student_hexdump
	@echo "BUILD SUCCESS" # If the script makes it to here the build was successful

install: build # put 'student' on connected phone
	@echo "PUSHING TO PHONE"
	adb push student /data/local/tmp/student

test: install # build 'student', push it to phone, and execute it.
	@echo "EXECUTING ON PHONE"
	adb shell /data/local/tmp/student

gdb: install # build 'student', push it to phone, and execute it via gdbserver on port 1111
	@echo "EXECUTING ON PHONE VIA GDBSERVER. TO CONNECT VIA ANOTHER TERMINAL, RUN:\n"
	@echo "hostpc> arm-linux-androideabi-gdb student"
	@echo "(...GDB STARTS...)"
	@echo ">>> target remote :1111\n"
	adb shell /data/local/tmp/gdbserver :1111 /data/local/tmp/student

reconstruct:
	xxd -r student_hexdump > student_reconstructed

.PHONY: clean build install all test gdb practice practice64 reconstruct
