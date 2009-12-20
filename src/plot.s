# setpixel
#         arguments:
#         [al] pixel color
#         [cx] x coordinate
#         [dx] y coordinate
a
+.setpixel
#   coord = Y * 320 + X
    push ax
    push cx
    mov ax, dx
#    Load Y loc into DX and AX
    mov dx, ax
#   AH := 256 * Y
    xchg ah, al
#   DX := 64 * Y
    xor cx, cx
    mov cl, 6
    shl dx, cl
    pop cx
#   AX := 320 * Y
    add ax, dx
    mov dx, cx
#   AX := 320 * Y + X
    add ax, dx
#   ES:DI := address of pixel
    mov di, ax
    pop ax
    stosb
    ret

