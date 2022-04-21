.data
B : .word 0 1 2 4 8 16
A: .word 0 0 0 0 0
size: .word 5

.text


 main:
 	
 	
 		
 	
 	la a0, A
 	la a1, B
 	li, a3, 0
 	li, s8, 0
 	li, a5, 5
 	li, t1, 0
	 	
 	
 		add t0, s8, s8
 	loop1:	
 		slti t1, a3, 5
 		beqz t1, loop2
 		slli, t2, a3, 2
 		add s10, a0, t2
 		lw s1,0(s10)
 		add s11, a1, t2
 		lw s2, 0(s11)
 		mv s0, s2
 		add s2 ,s1, s2
 		sw s11, 0(a0)
 		mv s0,s
 		addi a3, a3, 1
 		#sub t6,t6,t6
 		jal s8, loop1 		
 	loop2: 
 		
 		
 	end:
 		li a7,10
 		
 		ecall
 		
