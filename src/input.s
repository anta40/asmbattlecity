#
# Обработка нажатий клавиш
# Надо переписать.
#
a
+.input
    push cx
    call {.readkey}
#
    # key down
    mov cx, 3
    cmp ax, 5000
    jz {.i_dn}
    #
    # key up
    cmp ax, 4800
    jz {.i_up}
    #
    # key right
    cmp ax, 4D00
    jz {.i_ri}
    #
    # key left
    cmp ax, 4B00
    jz {.i_le}
    #
    # escape
    cmp ah, 01
    jz {.i_ex}
#
    pop cx
    ret
    +.i_ex
        mov bp, {.inp_exit}
        jmp {.inp_jbp}
    +.i_dn
        mov bp, {.keydn}
        jmp {.inp_jbp}
    +.i_up
        mov bp, {.keyup}
        jmp {.inp_jbp}
    +.i_ri
        mov bp, {.keyright}
        jmp {.inp_jbp}
    +.i_le
        mov bp, {.keyleft}
    +.inp_jbp
        jmp bp

a
+.keydn
    cmp wo [{.player_y}], 00B8
    jge {.keydn_rtn}
    mov wo [{.player_direction}], 00
    not by [{.player_tracks}]
    +.keydncyc
        push cx
        call {.dirty_rect_player}
        inc wo [{.player_y}]
        call {.redraw_player}
        mov cx, 10
        call {.delay}
        pop cx
        loop {.keydncyc}
        jmp {.keyrtn}
    +.keydn_rtn
        pop cx
        retn

a
+.keyup
    cmp by [{.player_y}], 01
    jle {.keyrtn}
    mov wo [{.player_direction}], 01
    not by [{.player_tracks}]
    +.keyupcyc
        push cx
        call {.dirty_rect_player}
        dec wo [{.player_y}]
        call {.redraw_player}
        mov cx, 10
        call {.delay}
        pop cx
        loop {.keyupcyc}
        jmp {.keyrtn}

a
+.keyright
    cmp wo [{.player_x}], 0130
    jge {.keyrtn}
    mov wo [{.player_direction}], 02
    not by [{.player_tracks}]
    +.keyrightcyc
        push cx
        call {.dirty_rect_player}
        inc wo [{.player_x}]
        call {.redraw_player}
        mov cx, 10
        call {.delay}
        pop cx
        loop {.keyrightcyc}
        jmp {.keyrtn}

a
+.keyleft
    cmp wo [{.player_x}], 01
    jle {.keyrtn}
    mov wo [{.player_direction}], 03
    not by [{.player_tracks}]
    +.keyleftcyc
        push cx
        call {.dirty_rect_player}
        dec wo [{.player_x}]
        call {.redraw_player}
        mov cx, 10
        call {.delay}
        pop cx
        loop {.keyleftcyc}
        jmp {.keyrtn}

a
+.inp_exit
    jmp ne {.exit}

a
+.keyrtn
    pop cx
    ret

