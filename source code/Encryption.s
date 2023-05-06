.global _Encryption
_Encryption:

pushl %ebp
movl %esp, %ebp
subl $40, %esp  # four local variable

movl 8(%ebp), %ebx   #  ebx = first  pointer
movl 12(%ebp), %ecx  #  ecx = second pointer
movl 20(%ebp), %edx  #  edx = ommittedletter

movl (%ebx), %ebx    #  ebx = first
movl (%ecx), %ecx    #  ecx = second

movl $1, %edi        #  edi = 1 first flag
movl $2, %esi        #  esi = 2 second flag

cmpl %edx, %ebx      #  check if first is ommitted
jnz firstnotommitted
xorl %edi, %edi      #  make first flag 0
xorl $35, %ebx       #  encrypt ebx - ebx ^ '#'
firstnotommitted:

cmpl %edx, %ecx      #  check if second is ommitted
jnz secondnotommitted
xorl %esi, %esi      #  make second flag 0
xorl $35, %ecx       #  encrypt ecx - ecx ^ '#'
secondnotommitted:

orl %esi, %edi       #  check if both of them are encrypted
jz endofecryption    #  both are encrypted - end

cmpl $3, %edi        #  check if one of them is encrypted
jnz swapvalues       #  one of them is envrypted - swap values for final encryption

cmpl $97, %ebx       #  check if the first is not letter
js swapvalues
cmpl $122, %ebx
jg swapvalues

cmpl $97, %ecx       #  check if the second is not letter
js swapvalues
cmpl $122, %ecx
jg swapvalues

movl 16(%ebp), %edx  #  address to table

movl %edx, -40(%ebp) #  pass the table
movl %ebx, -36(%ebp) #  pass the first
movl %ecx, -4(%ebp)  #  save the second
movl %ebx, -20(%ebp) #  save the first

call _FindPosition

movl %esi, -24(%ebp) #  save position of the first
movl %eax, -28(%ebp) #  save row of the first
movl %ecx, -32(%ebp) #  save collumn of the first

movl -4(%ebp), %ecx
movl %ecx, -36(%ebp) #  pass the second
call _FindPosition

movl %esi, -8(%ebp)  #  save position of the second
movl %eax, -12(%ebp) #  save row of the second
movl %ecx, -16(%ebp) #  save collumn of the second

movl -28(%ebp), %ebx #  ebx = row of the first
movl -32(%ebp), %ecx #  ecx = collumn of the first

movl -12(%ebp), %edx #  edx = row of the second
movl -16(%ebp), %eax #  eax = collumn of the second

cmpl %ebx, %edx
jz samerow
cmpl %ecx, %eax
jz samecollumn
                     #  update the first
decl %edx            #  --edx  dec row of the second
imull $5, %edx       #  5 x edx
addl %ecx, %edx
decl %edx            #  position of new value for the first

                     #  update the second
decl %ebx
imull $5, %ebx
addl %eax, %ebx
decl %ebx            #   position of the new value for the second

movl 16(%ebp), %esi  #  pointer to the table
movl (%esi,%edx,4), %edx # new value for the first
movl (%esi,%ebx,4), %ebx # new value for the second

movl 8(%ebp), %eax   #  pointer to the first
movl %edx, (%eax)    #  update the first

movl 12(%ebp), %eax   #  pointer to the second
movl %ebx, (%eax)    #  update the second

jmp end

samerow:
cmpl %ecx, %eax
jz end # if they are the same letters
js firstIsRight
                     # second is right
movl -24(%ebp), %ebx # ebx = position first
movl 8(%ebp), %edi   # edi = pointer to the first
movl 16(%ebp), %esi  # esi = pointer to the table

movl (%esi,%ebx,4), %ebx
movl %ebx, (%edi)    # update the first

cmpl $5, %eax
jnz notInfivecol
movl -8(%ebp), %ebx  # ebx = position second
movl 12(%ebp), %edi  # edi = pointer to the second
subl $5, %ebx
movl (%esi,%ebx,4), %ebx
movl %ebx, (%edi)    # update the second
jmp end
notInfivecol:
movl -8(%ebp), %ebx  # ebx = position second
movl 12(%ebp), %edi  # edi = pointer to the second
movl (%esi,%ebx,4), %ebx
movl %ebx, (%edi)    # update the second
jmp end

firstIsRight:        #  first is right
movl 16(%ebp), %esi  # esi = pointer to the table
movl -8(%ebp), %ebx  # ebx = position second
movl 12(%ebp), %edi  # edi = pointer to the second
movl (%esi,%ebx,4), %ebx
movl %ebx, (%edi)    # update the second

cmpl $5, %ecx
jnz notInfivecol2
movl -24(%ebp), %ebx  # ebx = position first
movl 8(%ebp), %edi  # edi = pointer to the first
subl $5, %ebx
movl (%esi,%ebx,4), %ebx
movl %ebx, (%edi)    # update the first
jmp end

notInfivecol2:
movl -24(%ebp), %ebx # ebx = position first
movl 8(%ebp), %edi   # edi = pointer to the first
movl (%esi,%ebx,4), %ebx
movl %ebx, (%edi)    # update the first
jmp end

samecollumn:
cmpl %ebx, %edx
js firstbelow
                     #  second is below
movl -24(%ebp), %ecx # ecx = position first
movl 8(%ebp), %edi   # edi = pointer to the first
movl 16(%ebp), %esi  # esi = pointer to the table
addl $4, %ecx
movl (%esi,%ecx,4), %ecx
movl %ecx, (%edi)    # update the first

cmpl $5, %edx
jnz notinfifthrow
movl -8(%ebp), %ecx  # ecx = position second
movl 12(%ebp), %edi  # edi = pointer to the second
subl $21, %ecx
movl (%esi,%ecx,4), %ecx
movl %ecx, (%edi)    # update the second
jmp end

notinfifthrow:
movl -8(%ebp), %ecx  # ecx = position second
movl 12(%ebp), %edi  # edi = pointer to the second
addl $4, %ecx
movl (%esi,%ecx,4), %ecx
movl %ecx, (%edi)    # update the second
jmp end

firstbelow:
movl -8(%ebp), %ecx  # ecx = position second
movl 12(%ebp), %edi  # edi = pointer to the second
movl 16(%ebp), %esi  # esi = pointer to the table
addl $4, %ecx
movl (%esi,%ecx,4), %ecx
movl %ecx, (%edi)    # update the second

cmpl $5, %ebx
jnz notinfifthrow2
movl -24(%ebp), %ecx  # ecx = position first
movl 8(%ebp), %edi  # edi = pointer to the first
subl $21, %ecx
movl (%esi,%ecx,4), %ecx
movl %ecx, (%edi)    # update the first
jmp end

notinfifthrow2:
movl -24(%ebp), %ecx  # ecx = position first
movl 8(%ebp), %edi  # edi = pointer to the first
addl $4, %ecx
movl (%esi,%ecx,4), %ecx
movl %ecx, (%edi)    # update the first
jmp end


swapvalues:
movl 8(%ebp), %edi  #   pointer to the first
movl 12(%ebp), %esi #   pointer to the second

movl %ebx, (%esi)   #   update the second value
movl %ecx, (%edi)   #   update the first value
jmp end

endofecryption:
movl 8(%ebp), %edi  #   pointer to the first
movl 12(%ebp), %esi #   pointer to the second

movl %ebx, (%edi)   #   update the first value
movl %ecx, (%esi)   #   update the second value
jmp end

end:
movl %ebp, %esp
pop %ebp
ret
