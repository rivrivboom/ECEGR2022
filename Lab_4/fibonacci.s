.data
.text

main:
	
	addi a6,zero,10		
	jal Fib			
	add t3, zero, a0
	
	addi a6, zero, 3
	jal Fib
	add t4,zero,a0
	
	#addi a6, zero, 20,
	#jal Fib
	#add t5,zero,a0
	
	#for some reason it fails doing 20, I have tried various different ways 
	#Ive re-written this so many times, this one seems to be the best working given everything
	
	li a7,10
	ecall
	
Fib:
	addi t1,zero,1		
	bge zero, a6, if	
	beq a6, t1, elseif	
	
	addi sp,sp,-8		
	sw ra, 0(sp)
	sw a6, 4(sp)
	
	addi a6,a6,-1		
	
	jal Fib			
	
	add a1, zero, a0	
	
	lw ra, 0(sp)		
	lw a6, 4(sp)
	addi sp,sp,8		

	addi sp,sp,-12		
	sw ra, 0(sp)
	sw a6, 4(sp)
	sw a1, 8(sp)
	
	addi a6,a6,-2
	
	jal Fib			
	add a2,zero,a0		
	
	lw ra, 0(sp)
	lw a6, 4(sp)
	lw a1, 8(sp)
	addi sp,sp,12		
	
	add a0,a1,a2		
	
	ret			

if:
	add a0,zero,zero	
	ret
elseif:
	addi a0,zero,1		
	ret
