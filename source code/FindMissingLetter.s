# this function tels us which letter is missing
.global _FindMissingLetter
_FindMissingLetter:

pushl %ebp
movl %esp, %ebp
subl $12, %esp

movl 8(%ebp), %ebx # table is here

movl $96, %edx #check variable
# movl $0, %esi  # i
movl $25, %eax
movl $1, %ecx # f

loop1:
cmpl $0, %ecx
jz after1
movl $0, %ecx
incl %edx

movl $-1, %esi  # i
loop11:
incl %esi
cmpl $25, %esi
jz loop1
movl (%ebx,%esi,4), %eax
cmpl %eax, %edx
jnz loop11
movl $1, %ecx
jmp loop1

after11:
after1:
movl %edx, %eax
movl %ebp, %esp
popl %ebp
ret
