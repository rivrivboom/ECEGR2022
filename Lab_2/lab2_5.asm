 
#part5
.data
A : .word 0
B: .word 0
C: .word 0


.text


main:
	li t0, 5
	li t1, 10
	la s1, A
	la s2, B
	la s3, C
	
	addi sp, sp, -8
	sw t0, 0(sp)
	sw t1,4(sp)
	jal addItUp
	
	add t4,t4,t1
	sw  t4, A, t5

	jal addItUp

	add t6, t6, t1
	sw t6,B, t5
	
	add s8, t4,t6
	
	sw s8,C,t5
	
	li a7,10
	ecall
	
	
addItUp: 
	lw a1, 0(sp)
	addi sp, sp, 4
	li t1, 0
	li t0, 0
start:
	bge t0,a1, return
	addi t1,t1,1
	add t1,t0,t1 
	addi t0, t0, 1 

	j start
return:
	jr ra
				 
		 