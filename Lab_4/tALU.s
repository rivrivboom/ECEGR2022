.data

.text

main: 
	li a0, 0x01234567
	li a1, 0x11223344
	
	add s0, a0, a1
	
	#addi t1, a0, 0x11223344
	
	sub s2, a0, a1
	
	li a0, 0x11223344
	sub s3, a0, a1
	
	li a1, 0xFFFFFFFF
	and s4, a0, a1
	
	andi s5, a0, 0xFFFFFFFF
	
	li a1, 0x11110011
	li a0, 0x11001100
	or s6, a0, a1
	
	#ori s7, a0, 0x11001100
	
	li a0, 0xCBACBDFF
	li a1, 0x00000001
	
	sll, s8, a0, a1
	
	slli, s9, a0,1
	
	srl s10,a0,a1
	srli s11, a0, 1
	
	mv t0,a1