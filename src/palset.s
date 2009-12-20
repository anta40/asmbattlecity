# setpalette
#         arguments:
#         [si] palette address
a
+.setpalette
    push ax
    push cx
    push dx
    mov dx, 3c8
    xor al, al
    out dx, al
    inc dl
    mov cx, 300
    cli
    +.outsb
        lodsb
        out dx, al
        loop {.outsb}
    sti
    pop dx
    pop cx
    pop ax
    ret

