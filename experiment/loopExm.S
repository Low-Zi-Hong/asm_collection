# this show how to do cmp and jmp

  .data
fmt_even:
  .asciz "%lld is Even\n"
fmt_odd:
  .asciz "%lld is Odd\n"

  .text
  .global main
main:
  pushq   %rbx      # push to the top of the stack with eq to subq then movq
  subq    $32, %rsp # so this rsp must be multiply of 16 here main fn ori got 8 and then the pushq got 8 and window need 32 so 48 which works fine
  # in this case rbx is Callee-saved which be4 and after the fn must be same

  movq    $1, %rbx  # set the rbx to 1

.L_loop_start:
  testq   $1, %rbx      # this test the rbx is 1 or not or this is test the num is even or odd if odd the last digit must be 1 else 0
  jz      .L_case_even  # if yes then jmp to even

.L_case_odd:
  movq    %rbx, %rdx  # else continue here
  leaq    fmt_odd(%rip), %rcx 
  call    printf  # printout prompt
  jmp     .L_loop_step  # skip through the even case

.L_case_even:
  movq    %rbx, %rdx
  leaq    fmt_even(%rip), %rcx
  call    printf

.L_loop_step:
  incq    %rbx  # increase rbx by 1

  cmpq    $5, %rbx    # here do rbx - 5
  jle     .L_loop_start # jump if rbx  <= 5

.L_exit:
  movl    $0, %eax
  addq    $32, %rsp
  popq    %rbx
  ret


# pushq -> Push Quadword -> push a quad to stack
# popq -> Pop Quadword -> pop a quad from stack