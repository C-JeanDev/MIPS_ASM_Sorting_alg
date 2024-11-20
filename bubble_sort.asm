# BUBBLE SORT

# $s6 will be used as an array
addi $s6, $s6 -100

# fill the array 
li $t0, 37        
li $t1, 123       
li $t2, 42        
li $t3, 89        
li $t4, 56        
li $t5, 201       

sw $t0,0($s6)
sw $t1,4($s6)
sw $t2,8($s6)
sw $t3,12($s6)
sw $t4,16($s6)
sw $t5,20($s6)


jal BUBBLE_SORT

BUBBLE_SORT:
	# Allocate space for 3 register in the stack
	addi $sp, $sp, -12 
	sw $s2, 8($sp) 
	sw $s1, 4($sp) 
	sw $s0, 0($sp) 

	# var as argument
	move $a0,$s6
	li $a1,6
	#vars for the for loop
	li $s0,0 # i 
	addi $s2,$a1,-1 #t0 = len - 1

FOR1:
	slt $t1, $s0,$s2      	# t1 = 0 if s0>s2 else t1 = 1
	beq $t1,$zero,END  	# exit if t1 == 0 

	move $s1,$zero 	     	# j = 0
	sub $t2,$s2,$s0	     	# t2 = n-1-i
	
FOR2:
	slt $t3, $s1, $t2 	# $t3 è zero se j ≥ n-i-1
	beq $t3, $zero, END_FOR_1 #salta a ESCI2 se j ≥ n-i-1
	
 
	sll $t4,$s1,2 		# t4 contain j*4
	add $t4,$a0,$t4 	# $t4 = address of array[j]
	lw $t5, 0($t4) 		# t5 = v[j]
	lw $t6 ,4($t4) 		# t6 = v[j+1]
	
	slt $t7,$t6,$t5
	beq $t7,$zero,END_FOR_2
	move $a2,$s1	
	jal SWAP	
	
END_FOR_2:
	addi $s1, $s1, 1 	# j++
	j FOR2
		
END_FOR_1:
	addi $s0,$s0,1 		# i++
	j FOR1

SWAP:
	sll $t0, $a2, 2  	# multiply by 4 the index
	add $t0,$a0,$t0  	# t0 = address of array[index]
	lw $t8,0($t0)	 	# $t8 = array[index]
	lw $t9,4($t0)		# $t9 = array[index + 1]
	sw $t9,0($t0)		# array[index] = array[index + 1]
	sw $t8,4($t0)		# array[index + 1] = array[index]
	jr $ra

END: 
	# Deallocate space from the stack
	lw $s0, 0($sp) 
	lw $s1,4($sp) 
	lw $s2, 8($sp) 
	addi $sp,$sp,12

