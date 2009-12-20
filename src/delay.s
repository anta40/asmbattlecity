a
+.delay
    push ax
    push dx
    push bx
    jcxz {.l3}
    +.l1
        mov al, 4
        out 43, al
        in al, 40
        mov dl, al
        nop
        in al, 40
        mov dh, al
    +.l2
        mov al, 4
        out 43, al
        in al, 40
        mov al, al
        nop
        in al, 40
        xchg al, ah
        mov bx, dx
        sub bx, ax
        cmp bx, 910
        jb {.l2}
        loop {.l1}
    +.l3
        pop bx
        pop dx
        pop ax
        ret

