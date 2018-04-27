	.equ SWI_Print_Int, 0x6B
	.equ SWI_Exit, 0x11
	.equ SWI_Print_Char, 0x00

	.data
array_source:
	.word 42, 67, 81, 90, 124, -5
array_sink:
	.word 0, 0, 0, 0, 0, 0
array_length:
	.word 6
add_amount:
	.word 5
	
	.text
	.global _start
_start:	
        ;; TODO: write your code below this comment
		
	ldr r0,=array_source
	ldr r1,=array_length
	ldr r1,[r1] ;;stores value from array_length
	ldr r2,=array_sink
	ldr r3,=add_amount
	ldr r3,[r3] ;; stores value from add amount

loop1: 
	cmp r1,#0 ;; Comparison: checking if arraylength greater than zero. subtracts zero from r1
	beq end_loop ;; if zero bit set go to end
	ldr r4,[r0] ;; loads value from array_source to r4 
	add r4, r4, r3 ;; adds value in r4 with r3(add_amount)
	str r4,[r2] ;; stores value from r4 in array_sink
	add r0,r0,#4 ;; Shifting array_source: adding 4 shifts memory location by 4 BYTES which brings us to next memory location.
	add r2, r2, #4 ;; Shifting array_sink: adding 4 shifts memory location by 4 BYTES which brings us to next memory location.
	sub r1, r1, #1 ;; decrement r1(array_length) by 1.
	b loop1
	
end_loop:
	;; I do not take credit for the lines of code below this line as they were provided by the professor.
	
	;; ---DO NOT REMOVE OR EDIT THE CODE BELOW THIS COMMENT---
	;; The code below will print out the contents of the
	;; array_sink array.
	
	;; r2: current sink position
	;; r3: array length
	;; r4: counter
	ldr r2, =array_sink
	ldr r3, =array_length
	ldr r3, [r3]
	mov r4, #0
	

print_loop_begin:
	;; still in loop?
	cmp r3, r4
	beq print_loop_end

	;; get element and print it
	mov r0, #1
	ldr r1, [r2]
	swi SWI_Print_Int
	mov r0, #'\n
	swi SWI_Print_Char

	;; increment
	add r2, r2, #4
	add r4, r4, #1
	b print_loop_begin

print_loop_end:	
	;; end the program
	swi SWI_Exit
	.end
	
