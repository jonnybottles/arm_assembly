


int main(void){
	__asm__("nop");
	__asm__ volatile (".byte 0x01, 0x08, 0x00, 0xf2"); 
	__asm__("nop");
}

// int main(void){
// 	__asm__("nop");
// 	__asm__ volatile (".byte 0x09, 0x2a, 0xa0, 0xe3"); 
// 	__asm__("nop");
// }

// this is what is put in that byte area 0xe3a02a09