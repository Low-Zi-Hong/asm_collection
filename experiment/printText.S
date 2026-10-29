  .data
msg:
  .asciz "Hello from pure assembly! 1 + 1 = %d\n"

  .text
  .global main
main:
  # create stack space
  subq  $40,  %rsp

  movl  $1, %eax  # peform 1+1
  addl  $1, %eax

  # according to window put first variable to rcx then drx
  leaq  msg(%rip),  %rcx  # rcx = the string ptr
  movl  %eax, %edx        # rdx = 2 (result we got)

  call  printf # call printf

  movl  $0, %eax # return 0
  addq  $40, %rsp # return the stack original pos
  ret