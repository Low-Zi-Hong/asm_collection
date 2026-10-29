# This show how to get the cin << work

  .data
prompt:
  .asciz "Enter an integer: "
fmt_in:
  .asciz  "%d"
fmt_out:
  .asciz "You entered: %d\n"

  .text
  .global main
main:
  subq    $40, %rsp

  # print out the prompt
  # same using rcx without rdx just.
  leaq    prompt(%rip), %rcx
  call    printf

  # use scanf to the the buffer just like cin >> x
  leaq    fmt_in(%rip), %rcx  # rcx = the input format
  leaq    32(%rsp), %rdx      # rdx = the final address to store the result
  call    scanf

  # printf again
  movl    32(%rsp), %edx
  leaq    fmt_out(%rip), %rcx
  call    printf

  # just like previous return 0 and fill back the stack
  movl    $0, %eax
  addq    $40, %rsp
  ret

# leaq means copy the adress to another reg
# like leaq %rip, %rcx -> copy address of %rip to rcx

