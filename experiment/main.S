# This file show how to call an external function
  .data
msg:
  .asciz  "Result of (5 * 5) + 7 is %lld\n"

  .text
  .global main
  .def  main; .scl  2; .type 32; .endef

main:
  subq    $40, %rsp

  movq    $5, %rcx
  movq    $7, %rdx
  call    square_and_add

  movq    %rax, %rdx
  leaq    msg(%rip), %rcx
  call    printf

  movl    $0, %eax
  addq    $40, %rsp
  ret