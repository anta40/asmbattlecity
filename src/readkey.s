a
+.readkey
    mov ah, 1
    int 16
    #jz {.rk_rtn}
    mov ah, 0
    int 16
    #+.rk_rtn
        ret

