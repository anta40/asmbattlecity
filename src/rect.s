a
+.drawrect
    push ax
    xor ax, ax
    mov [{.inxcrd}], bx
    mov [{.xcoord}], bx
    mov [{.inycrd}], ax
    mov by [{.inycrd}], dh
    mov [{.ycoord}], ax
    mov by [{.ycoord}], dh
    mov [{.iwidth}], cx
    mov [{.height}], ax
    mov by [{.height}], dl
    pop ax
    mov cx, ax
    +.drawrect_blitrow
        push cx
        mov cx, [{.xcoord}]
        mov dx, [{.ycoord}]
        call {.setpixel}
        pop cx
        inc wo [{.xcoord}]
        loop {.drawrect_blitrow}
    # blitting next row
    inc wo [{.ycoord}]
    mov cx, [{.inxcrd}]
    mov [{.xcoord}], cx
    mov cx, [{.ycoord}]
    sub cx, [{.inycrd}]
    cmp cx, [{.height}]
    je {.drawrect_blitend}
    mov cx, [{.iwidth}]
    jmp {.drawrect_blitrow}
    +.drawrect_blitend
        ret

