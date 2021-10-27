// ex1
.data
	lineIndex: .space 4
	columnIndex: .space 4
	matrix: .space 1600
	roles: .space 100
	n: .space 4
	value: .space 4
	left: .space 4
	right: .space 4
	task: .space 4
	m: .space 4
	bfs: .space 100
	bfsIndex: .space 4
	bfsSize: .space 4
	visited: .space 100
	current: .space 4
	ct: .space 4
	source: .space 4
	dest: .space 4
	cod: .space 100
	codificat: .space 4
	
	formatSwitchMal: .asciz "switch malitios index %d: "
	formatSwitchMalNode: .asciz "switch malitios index %d; "
	formatHost: .asciz "host index %d; "
	formatController: .asciz "controller index %d; "
	formatSwitch: .asciz "switch index %d; "
	formatNew: .asciz "\n"
	yes: .asciz "Yes\n"
	no: .asciz "No\n"	
	formatRead: .asciz "%d"
	formatString: .asciz "%s"
	
.text
.global main
main:

//facem citirea 

	push $n
	push $formatRead
	call scanf
	pop %ebx
	pop %ebx
	
	pushl $m
	pushl $formatRead
	call scanf
	popl %ebx
	popl %ebx
	
	movl $0, lineIndex
	lea matrix, %esi

read_pairs:
	movl lineIndex, %ecx
	cmp m, %ecx
	je read_roles
	
	pushl $left
	pushl $formatRead
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $right
	pushl $formatRead
	call scanf
	popl %ebx
	popl %ebx
	
	movl left, %eax
	mull n
	add right, %eax
	movl $1, (%esi, %eax, 4)
	
	movl right, %eax
	mull n
	add left, %eax
	movl $1, (%esi, %eax, 4)
	
	add $1, lineIndex
	jmp read_pairs
	
//citirea tipurilor de nod

read_roles:
	lea roles, %edi
	movl $0, lineIndex
	
	for_loop:
	
		movl lineIndex, %ecx
		cmp n, %ecx
		je read_task
	
		pushl $value
		pushl $formatRead
		call scanf
		popl %ebx
		popl %ebx
	
		movl value, %ecx
	
		movl lineIndex, %edx
	
		movl %ecx, (%edi, %edx, 4)
	
		add $1, lineIndex
		jmp for_loop
	
// citirea task ului

read_task:

	pushl $task
	pushl $formatRead
	call scanf
	popl %ebx
	popl %ebx
	
	movl task, %ecx
	cmp $1, %ecx
	je taskOne
	cmp $2, %ecx
	je taskTwo
	cmp $3, %ecx
	je taskThree

//prima cerinta

taskOne:
	
	movl $0, lineIndex
		
	iterate:
		
		movl lineIndex, %ecx
		cmp n, %ecx
		je et_exit
		
		movl lineIndex, %eax
		
		movl (%edi, %eax, 4), %ecx
		
		cmp $3, %ecx
		je printSwitch
		
		add $1, lineIndex
		jmp iterate
	
printSwitch:
	
	pushl lineIndex
	pushl $formatSwitchMal
	call printf
	popl %ebx
	popl %ebx
	
	movl $0, columnIndex
	iterate_columns:
		
		movl columnIndex, %ecx
		cmp %ecx, n
		je cont_iterate
		
		movl n, %eax
		mull lineIndex
		addl columnIndex, %eax
		
		movl (%esi, %eax, 4), %ecx
		cmp $1, %ecx
		je printNode
		
		add $1, columnIndex
		jmp iterate_columns
	
	cont_iterate:
	
		pushl $formatNew
		call printf
		popl %ebx
		add $1, lineIndex
		jmp iterate
	

printNode:
	movl columnIndex, %eax
	movl (%edi, %eax, 4), %ecx
	cmp $1, %ecx
	je printHost
	cmp $2, %ecx
	je printSwitchNode
	cmp $3, %ecx
	je printSwitchMal
	cmp $4, %ecx
	je printController

printHost:
	

	pushl columnIndex
	pushl $formatHost
	call printf
	popl %ebx
	popl %ebx
	
	add $1, columnIndex
	jmp iterate_columns

printSwitchNode:

	pushl columnIndex
	pushl $formatSwitch
	call printf
	popl %ebx
	popl %ebx

	add $1, columnIndex
	jmp iterate_columns
	
printSwitchMal:

	pushl columnIndex
	pushl $formatSwitchMalNode
	call printf
	popl %ebx
	popl %ebx
	
	add $1, columnIndex
	jmp iterate_columns
	
printController:

	pushl columnIndex
	pushl $formatController
	call printf
	popl %ebx
	popl %ebx

	add $1, columnIndex
	jmp iterate_columns


taskTwo:
	
	lea visited, %ebx
	movl $0, %eax
	movl $1, (%ebx, %eax, 4)
	lea bfs, %ebx
	movl $0, (%ebx, %eax, 4)
	movl $1, bfsSize
	movl $0, bfsIndex
	
	while_loop:
		lea bfs, %ebx
		movl bfsIndex, %ecx
		cmp bfsSize, %ecx
		je checkConex
		
		lea bfs, %ebx
		movl (%ebx, %ecx, 4), %edx
		movl %edx, current
		add $1, bfsIndex
		
		movl $0, columnIndex
		
		movl current, %eax
		movl (%edi, %eax, 4), %ecx
		cmp $1, %ecx
		je printHost2
		
		
		while_columns:
		
			movl columnIndex, %ecx
			cmp n, %ecx
			je while_loop
			
			movl current, %eax
			mull n
			add columnIndex, %eax
			movl (%esi, %eax, 4), %ecx
			cmp $1, %ecx
			je add_node
			
			addl $1, columnIndex
			jmp while_columns

		add_node:
			
			movl columnIndex, %eax
			lea visited, %ebx
			movl (%ebx, %eax, 4), %ecx
			
			cmp $1, %ecx
			je Visited
			
			lea bfs, %ebx
			movl bfsSize, %eax
			
			movl columnIndex, %edx
			movl %edx, (%ebx, %eax, 4)
			addl $1, bfsSize
			
			lea visited, %ebx
			movl columnIndex, %eax
			movl $1, (%ebx, %eax, 4)
			lea bfs, %ebx
			addl $1, columnIndex
			jmp while_columns
		
		Visited:
		
			lea bfs, %ebx
			addl $1, columnIndex
			jmp while_columns
		
		jmp while_loop
	
	checkConex:
	
		pushl $formatNew
		call printf
		popl %ebx
		
		lea visited, %ebx
		movl $0, ct
		movl $0, bfsIndex
		for_visited:
			movl bfsIndex, %ecx
			cmp n, %ecx
			je printAnswer
			
			movl bfsIndex, %eax
			movl (%ebx, %eax, 4), %ecx
			cmp $1, %ecx
			je addCt
			
			addl $1, bfsIndex
			jmp for_visited
		
		addCt:
			addl $1, ct
			addl $1, bfsIndex
			jmp for_visited
		printAnswer:
			movl ct, %ecx
			cmp n, %ecx
			je printYes
			
			pushl $no
			call printf
			popl %ebx
			jmp et_exit
			
		printYes:
			
			pushl $yes
			call printf
			popl %ebx
			jmp et_exit
		
printHost2:

	pushl current
	pushl $formatHost
	call printf
	popl %ebx
	popl %ebx
	
	jmp while_columns
			
			
taskThree:
	
	pushl $source
	pushl $formatRead
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $dest
	pushl $formatRead
	call scanf
	popl %ebx
	popl %ebx
	
	push $cod
	push $formatString
	call scanf
	pop %ebx
	pop %ebx
	
	lea visited, %ebx
	movl source, %eax
	movl $1, (%ebx, %eax, 4)
	lea bfs, %ebx
	movl source, %ecx
	movl $0, %eax
	movl %ecx, (%ebx, %eax, 4)
	movl $1, bfsSize
	movl $0, bfsIndex
	
	while_loop2:
		lea bfs, %ebx
		movl bfsIndex, %ecx
		cmp bfsSize, %ecx
		je Decode
		
		lea bfs, %ebx
		movl (%ebx, %ecx, 4), %edx
		movl %edx, current
		add $1, bfsIndex
		
		movl $0, columnIndex
		
		
		while_columns2:
		
			movl columnIndex, %ecx
			cmp n, %ecx
			je while_loop2
			
			movl current, %eax
			mull n
			add columnIndex, %eax
			movl (%esi, %eax, 4), %ecx
			cmp $1, %ecx
			je add_node2
			
			addl $1, columnIndex
			jmp while_columns2

		add_node2:
			
			movl columnIndex, %eax
			lea visited, %ebx
			movl (%ebx, %eax, 4), %ecx
			
			cmp $1, %ecx
			je Visited2
			
			lea roles, %edi
			movl (%edi, %eax, 4), %ecx
			cmp $3, %ecx
			je Visited2
			
			lea bfs, %ebx
			movl bfsSize, %eax
			
			movl columnIndex, %edx
			movl %edx, (%ebx, %eax, 4)
			addl $1, bfsSize
			
			lea visited, %ebx
			movl columnIndex, %eax
			movl $1, (%ebx, %eax, 4)
			lea bfs, %ebx
			addl $1, columnIndex
			jmp while_columns2
		
		Visited2:
		
			lea bfs, %ebx
			addl $1, columnIndex
			jmp while_columns2
		
		jmp while_loop2

		
		Decode:
				
			movl dest, %eax
			lea visited, %ebx
			movl (%ebx, %eax, 4), %ecx
			cmp $1, %ecx
			je printCod
			
			lea cod, %ebx
			movl $0, %ecx
			
		etfor:
			
			movb (%ebx, %ecx, 1), %al
			cmp $0, %al
			je printCod
			
			movb $0, %ah
			addb $16, %al
			subb $97, %al
			movb $26, %dl
			idivb %dl
			movb $97, %al
			addb %ah, %al
			
			movb %al, (%ebx, %ecx, 1)
			
			addl $1, %ecx
			jmp etfor
		
		printCod:
			
			push $cod
			push $formatString
			call printf
			pop %ebx
			pop %ebx
			
			push $formatNew
			call printf
			pop %ebx
			
			jmp et_exit

et_exit:

	push $0
	call fflush
	pop %ebx
	mov $1, %eax
	mov $0, %ebx
	int $0x80
