.text
    .globl  main
main:
    # 操作系统初始只映射了第一页，下一页（4KB 内）是 Guard Page。
    # 我们直接跨越 16384 字节（16KB），故意不碰中间的 Guard Page：
    subq    $4194304, %rsp

    # 尝试直接向未提交、未映射物理内存的虚空地址写入 1 字节：
    movb    $42, (%rsp)

    # 恢复（如果命大没死的话）
    addq    $16384, %rsp
    movl    $0, %eax
    ret