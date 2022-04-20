#arithmetic
	.data

varA: 	.word 	15
varB: 	.word 	10
varC: 	.word 	5
varD: 	.word 	2
varE: 	.word 	18
varF: 	.word 	3
varZ: 	.word 	0

	.text
main:
	lw s0, varA
	lw s1, varB
	lw s2, varC
	lw s3, varD
	lw s4, varE
	lw s5, varF
	

	la  t0, varZ
    	sw  s0, 0(t0)
    	sw  s1, 0(t0)
    	sw  s2, 0(t0)
    	sw  s3, 0(t0)
	sw  s4, 0(t0)
	sw  s5, 0(t0)
	
	sub t1, s0,s1
	mul t2, s2, s3
	add t1, t1, t3
	sub t3, s4, s5
	div t4, s0, s2
	sub t2, t3, t4
	add t0, t1, t2
	
	li a7, 1
	li a7, &t0
	 
	
	#Z = (A-B) + (C*D) + (E-F) - (A/C);
	
	li a7, 10
	ecall
