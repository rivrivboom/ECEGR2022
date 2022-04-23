.data
I : .word 0
Z: .word 2
.text

 main:
 
 	li s0,21
 	li s1, 100
 	li s2 0
 	li s3, 1
 	li s4, 2
 	lw t4, Z
 	lw t3,I
 	
	loop1: 
		bgt t3, s0, loop2
		add t4,t4, s3
		add t3,t3,s4
		j loop1	
 	loop2: 
 		bgt,t4,s1,loop3
 		add t4,t4,s3
 		blt,t4,s1,loop2
 	
 	
 	loop3:
 		blt,t3,s2,return
 		sub t3,t3,s3
 		sub t4,t4,s3
 		j loop3
 	return:
 		add  t4,t4,s2
 		add t3,t3,s2
		sw t4, Z, s9
		sw t3, I, s9
 	li a7, 10
 	ecall
 		
  
 
 	
 	
