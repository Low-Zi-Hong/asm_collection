  .global main
  .data
fmt:
  .string "malloc addr: %p, val[0]: %lld, val[1]: %lld\n"

  .text
main:
  pushq   %rbp
  movq    %rsp, %rbp

  subq    $48, %rsp

  # call malloc for 16 bytes which is malloc(16)
  movq    $16, %rcx
  call    malloc

  movq    %rax, -8(%rbp)  # save the pointer to the stack

  movq    -8(%rbp), %rax
  movq    $1111, (%rax)
  movq    $2222, 8(%rax)

  # use printf
  leaq    fmt(%rip), %rcx
  movq    -8(%rbp), %rdx
  movq    -8(%rbp), %rax
  movq    (%rax), %r8
  movq    8(%rax), %r9
  call    printf

  # free out malloc
  movq    -8(%rbp), %rcx
  call    free

  xorl    %eax, %eax
  addq    $48, %rsp
  popq    %rbp
  ret
