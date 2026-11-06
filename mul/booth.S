#This one use the booth algo  
  
  .data
fmt_prompt:
  .asciz  "input two numbers to multiply: "

fmt_debug:
  .asciz  "debug: %d, %d\n"

fmt_raw:
  .asciz  "raw: %p \n"

fmt_in:
  .asciz "%d"

fmt_result:
  .asciz  "result: %d"

  .text
  .global main
main:
  pushq   %rbx
  # here track the rsp size: 8 + 32 +  8(for 2 input)
  subq    $64, %rsp

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

.Generate_sub_num:
  movl    32(%rsp), %eax
  negl    %eax
  shlq    $32, %rax
  movq    %rax, 48(%rsp)

# 40 rsp is now the number can be add
# 48 rsp is now the number can be sub

# use rbx to save the CF
  movq    $0, %rbx
  movq    $0, %rdx        # as counter
  movl    36(%rsp), %eax
.Booth_Algo:
  testq   $1, %rbx  
  jz      .Booth_Sub  # if CF is 0
  testq   $1, %rax    # here if CF is 1 test the first is 1/0
  jz      .Booth_Add  # if CF and firstBit is 01
  jmp     .Booth_Shift

.Booth_Add:
  addq    40(%rsp), %rax
  jmp     .Booth_Shift
.Booth_Sub:     
  testq   $1, %rax    # here if CF is 1 test the first is 1/0
  jz      .Booth_Shift # if CF and firstBit is 11
  addq    48(%rsp), %rax
.Booth_Shift:
  sarq    $1, %rax     
  setc    %bl   # saving the CF to rbx
  incq    %rdx
  cmpq    $32, %rdx
  jl      .Booth_Algo   


  movq    %rax, 40(%rsp)

.Debug:
  movl  32(%rsp), %edx
  movl  36(%rsp), %r8d
  leaq  fmt_debug(%rip), %rcx
  call  printf

  leaq   fmt_raw(%rip), %rcx
  movq   40(%rsp), %rdx
  call   printf

.Print_Result:
  movq  40(%rsp), %rdx
  leaq  fmt_result(%rip), %rcx
  call  printf

.End_Of_Program:
  movl    $0, %eax
  addq    $64, %rsp
  popq    %rbx
  ret