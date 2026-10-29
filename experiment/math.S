# This file show how to import or cross file calling


  .text
    .global	square_and_add
    .def	square_and_add; .scl 2; .type 32; .endef

# the signature of the function
# long long square_and_add(long long a, long long b)

square_and_add:
  movq    %rcx, %rax    # rax =a
  imulq   %rax, %rax    # rax = a*a
  addq    %rdx, %rax    # rax = (a * a) + b
  ret 
# rax is alr the return value