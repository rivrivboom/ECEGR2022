.data
A : .word 15
B : .word 15
C : .word 10
Z : .word 0
.text

 main:
	lw t0,A #load value of A B and C
	lw t1,B
	lw t2,C
	lw t4,Z
	li s7, 5
	li s6, 7
	li s5, 1
	li s4, 2
	li s10, 3
	

	blt t0, t1,And#if A<B
	#bgt t2,s7,One #if C > 5
	bgt t0,t1,Two
	test2:
		bgt t0,t1,Two
		addi a0,t2,1
		beq a0,s6,Two
		#if A>B
		j ELSE
	
	And: 
		bgt, t2,s7,One
		j test2
	ELSE:
#else condition
		li t4,3 #set z = 3
		j exit

	One:
		li t4,1 #set z = 1
		j exit

	Two:
		li t4,2 #set z = 2
		j exit

	exit:
		beq t4,s5,case1
		beq t4,s4,case2
		beq t4,s10,case3
		j default

	case1:
		li t4,-1 # z = -1
		j end

	case2:
		li t4,-2 # z = -2
		j end

	case3: 
		li t4, -3
		j end
	default:
		li t4,0 #set z = 0
		j end


	end:
		sw t4,Z,a3
	li a7,10
	ecall