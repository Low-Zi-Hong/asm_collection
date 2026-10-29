# this one show how to read file

  .data
filename:
  .asciz  "test.txt"
mode:
  .asciz "r"

  .bss
file_buffer:
  .space 128

  .text
  .global main
main:
  subq    $56, %rsp # 32 byte for stack

  # fopen("test.txt", "r")
  leaq    filename(%rip), %rcx  # first is the file pointer
  leaq    mode(%rip), %rdx      # second is the mode to open which is read("r")
  call    fopen
  testq   %rax, %rax            # check if the FILE* is null
  jz      error_exit

  movq    %rax, 40(%rsp)        # put the file pointer back to the stack first

  # fread(file_buffer, 1, 127, fp)
  # rcx = buffer, rdx = element size, r8 = num to read, r9 = pointer of file
  leaq    file_buffer(%rip), %rcx
  movq    $1, %rdx
  movq    $127, %r8
  movq    40(%rsp), %r9
  call    fread

  # at the end put a '\0' to close the string
  leaq    file_buffer(%rip), %rbx
  movq    $0, (%rbx, %rax)  # rax put the real size of fread as the last element pointer

  # puts(file_buffer)
  leaq    file_buffer(%rip), %rcx
  call    puts

  movq    40(%rsp), %rcx
  call    fclose

error_exit:
  movl    $0, %eax
  addq    $56, %rsp
  ret
