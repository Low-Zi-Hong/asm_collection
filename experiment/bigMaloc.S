  .global main
  .data
fmt:
  .string "malloc addr: %p to %p, val[0]: %lld, val[1]: %lld\n"

  .text
main:
  pushq   %rbp
  movq    %rsp, %rbp

  subq    $48, %rsp

  # call malloc for 4 G bytes which is malloc(16)
  movl    $0xF0000000, %ecx 
  # here use l cuz movq will extend sign bit if use C000 0000 it will become FFFF FFFF C000 0000
  call    malloc
  # then if more than 4GB use movabsq to rcx.

  movq    %rax, -8(%rbp)  # save the pointer to the stack

  movq    -8(%rbp), %rax
  movq    $1111, (%rax)
  movl    $0xF0000000, %r10d
  movq    $2222, (%rax, %r10) # write to the last bit of the 4GB

  # use printf
  leaq    fmt(%rip), %rcx
  movq    -8(%rbp), %rdx
  movq    -8(%rbp), %rax
  leaq    (%rax, %r10), %r8
  movq    (%rax), %r9
  movq    (%rax, %r10), %r11
  movq    %r11, 32(%rsp)
  call    printf

  # free out malloc
  movq    -8(%rbp), %rcx
  call    free

  xorl    %eax, %eax
  addq    $48, %rsp
  popq    %rbp
  ret
