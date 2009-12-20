# bit_blt
#         arguments:
#         [ds:si] sprite address
#         [cx] rows count
#         [dl] cols count
#         [bx] x coordinate
#         [dh] y coordinate
a
+.bitblt
    push ax
    xor ax, ax
#
    mov [{.inxcrd}], bx
    mov [{.xcoord}], bx
    mov [{.inycrd}], ax
    mov byte [{.inycrd}], dh
    mov [{.ycoord}], ax
    mov byte [{.ycoord}], dh
    mov [{.iwidth}], cx
    mov [{.height}], ax
    mov byte [{.height}], dl
#
#   Блит одного сканлайна
#
    +.blitrow
        lodsb
#
#       Проверяем пиксель на прозрачность
#
        cmp al, FF
        je {.nextcol}
        push cx
        mov cx, [{.xcoord}]
        mov dx, [{.ycoord}]
        call {.setpixel}
        pop cx
#
        +.nextcol
            inc wo [{.xcoord}]
            xor ax, ax
            loop {.blitrow}
#
#   Блиттим следующий сканлайн
#
    inc wo [{.ycoord}]
#
    mov cx, [{.inxcrd}]
    mov [{.xcoord}], cx
    mov cx, [{.ycoord}]
    sub cx, [{.inycrd}]
    cmp cx, [{.height}]
    je {.blitend}
    mov cx, [{.iwidth}]
    jmp {.blitrow}
    +.blitend
        pop ax
    ret

