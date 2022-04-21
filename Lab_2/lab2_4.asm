.data
B : .word 0, 1, 2, 4, 8, 16
A: .word 0, 0, 0, 0, 0, 0
size: .word 5

.text


 main:
 	
 	
 		
 	
 	la a1, A
 	la a2, B
 	li, a3, 0
 	li, a4, 0
 	li, a5, 5
 	li, t1, 0
 	li t4,1
 	li t5, 2
	 	
 	
 		add t0, a4, a4
 	loop1:	
 		slti t1, a3, 6
 		beqz t1, step2
 		slli, t2, a3, 2
 		add s10, a1, t2
 		lw s1,0(s10)
 		add s11, a2, t2
 		lw s2, 0(s11)
 		mv s0, s2
 		sub s2,s2,t4
 		add s1 ,s1, s2
 		sw s1, 0(s10)
 		addi a3, a3, 1
 		
 		jal a4, loop1 		
 	
 	step2: sub a3,a3,t4
 		j loop2
 	
 	loop2:  beqz a3, end
 		slli, t2, a3, 2
 		add s10, a1, t2
 		lw s1,0(s10)
 		add s11, a2, t2
 		lw s2, 0(s11)
 		mv s0, s2
 		add s1 ,s1, s2
 		mul s1, s1, t5
 		sw s1, 0(s10)
 		sub a3, a3, t4
 		j loop2
 		
 	end:
 		li a7,10
 		
 		ecall
 		
