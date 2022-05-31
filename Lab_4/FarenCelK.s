.data
#adrian rivera
K: .float 273.15
prompt: .asciz "Enter a Farenheit Temp: "
Kelvin: .asciz "In Kelvin: "
Celsius: .asciz "In Celsius: "

newln: .asciz "\r\n"

.text

main: 
	li a7, 4 
	la a0, prompt
	
	ecall
	
	li a7, 6
	
	ecall
	
	fmv.x.w a0, fa0
	jal FerToCel
	
	fmv.s.x fs0, a1
	
	mv a0, a1
	jal CelToKel
	
	fmv.s.x fs1, a1
	
	li a7, 10
	ecall
	
	
FerToCel:
	addi t0, x8, 32
	fcvt.s.w ft0, t0
	addi t0, x8, 9
	fcvt.s.w ft1, t0
	addi t0, x8, 5
	fcvt.s.w ft2,t0
	
	fmv.s.x fa0, a0
	
	fsub.s fa0, fa0, ft0 #F - 32
	fmul.s fa0, fa0, ft2
	fdiv.s fa0, fa0, ft1
	
	li a7,4
	la a0,Celsius
	ecall
	
	li a7,2
	ecall
	
	li a7,4
	la a0,newln
	ecall
	
	fmv.x.s a1,fa0
	ret

CelToKel:
	flw ft0, K, t0
	fmv.s.x fa0, a0
	fadd.s fa0, fa0, ft0
	
	li a7, 4
	la a0, Kelvin
	ecall
	
	li a7, 2
	ecall
	li a7, 4
	la a0, newln
	ecall
	fmv.x.s a1, fa0
	ret
	