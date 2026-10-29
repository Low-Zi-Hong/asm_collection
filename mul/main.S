  .data
fmt_prompt:
  .asciz  "input two numbers to multiply: "

fmt_debug:
  .asciz  "debug: %d, %d"

fmt_in:
  .asciz "%d"

fmt_result:
  .asciz  "result: %d"

  .text
  .global main
main:

  # here track the rsp size: 8 + 32 +  8(for 2 input)
  subq    $56, %rsp

.M_Print_Prompt:
  leaq    fmt_prompt(%rip), %rcx
  call    printf

.M_Get_Input:
  leaq    fmt_in(%rip), %rcx
  leaq    32(%rsp), %rdx
  call    scanf

.M_Get_2nd_Input:
  leaq    fmt_in(%rip), %rcx
  leaq    36(%rsp), %rdx
  call    scanf

# so now 2 input are in rsp one in 32 another 36

.Generate_add_num:
  movl    32(%rsp), %eax
  shlq    $32, %rax
  movq    %rax, 40(%rsp)

# 40 rsp is now the number can be add

  movq    $0, %rdx        # as counter
  movl    36(%rsp), %eax
.add_shift_algo:
  testq   $1, %rax        # eax and rax are the same reg
  jz      .add_shift_shift
  addq    40(%rsp), %rax
.add_shift_shift:
  sarq    $1, %rax     
  incq    %rdx
  cmpq    $32, %rdx
  jl      .add_shift_algo   

  movl    %eax, 40(%rsp)

.Debug:
  movl  32(%rsp), %edx
  movl  36(%rsp), %r8d
  leaq  fmt_debug(%rip), %rcx
  call  printf

.Print_Result:
  movl  40(%rsp), %edx
  leaq  fmt_result(%rip), %rcx
  call  printf

.End_Of_Program:
  movl    $0, %eax
  addq    $56, %rsp
  ret