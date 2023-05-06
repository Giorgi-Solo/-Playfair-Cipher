#this finds position of the letter in the table
.global _FindPosition
_FindPosition:
# function uses eax, ebx, ecx, esi
pushl %ebp
movl %esp, %ebp
movl 8(%ebp), %ebx  #Here is address to table
movl 12(%ebp), %ecx  #Here is character, whose position is up to be determined

movl $-1, %esi #index
LoopForPosition:
incl %esi
movl (%ebx,%esi,4), %eax
cmpl %eax, %ecx
jnz LoopForPosition
incl %esi # here is the position of the letter

#determine number of row
xorl %edx, %edx
movl %esi, %eax
movl $5, %ecx
idivl %ecx #position/5 # result is in eax, remainder is in edx
cmpl $0, %edx
jz fivemultiple
incl %eax
fivemultiple:
#number of row determined it is in eax

#determine number of collumn
imull %eax, %ecx  #  5 x row
subl %esi, %ecx   #5 x row - position
subl $5, %ecx
imull $-1, %ecx
#number of collumn determined, in %ecx

#return values :
#               position %esi
#               row      %eax
#               collumn  %ecx


movl %ebp, %esp
popl %ebp
ret
