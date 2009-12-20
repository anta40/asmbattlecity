# Точка входа
a 100
    # Инизиализцируем видеорежим
    mov ax, A000
    mov es, ax
    mov ax, 13
    int 10
    #
    # Устанавливаем палитру
    mov si, {.$gamePalette}
    call {.setpalette}
    #
    # Очищаем экран
    call {.cls}
    #
    # Tank bitblit
    call {.redraw_player}

#
# Игровой цикл
#
a
+.gameloop
    call {.input}
    mov cx, 0A
    call {.delay}
    jmp {.gameloop}

#
# Выход из игры
#
a
+.exit
    call {.cls}
    mov ax, 3
    int 10
    int 20
    ret

#
# Очищает предыдущее местоположение игрока от мусора
#
a
+.dirty_rect_player
    push ax
    push bx
    push cx
    push dx
    mov ax, 0
    mov cx, 10
    mov dl, 10
    mov bx, [{.player_x}]
    mov dh, by [{.player_y}]
    call {.drawrect}
    pop dx
    pop cx
    pop bx
    pop ax
    ret

#
# Перерисовка игрока на новой позиции
#
a
+.redraw_player
    push ax
    mov si, {.$playerTank}
#
    mov ax, word [{.player_direction}]
    cmp ax, 0000
    jz {.rp_ani}
    cmp ax, 01
    je {.rp_dup}
    cmp ax, 02
    je {.rp_dri}
    cmp ax, 03
    je {.rp_dle}
    +.rp_dup
        add si, 600
        jmp {.rp_ani}
    +.rp_dri
        add si, 400
        jmp {.rp_ani}
    +.rp_dle
        add si, 200
        jmp {.rp_ani}
    +.rp_ani
        cmp by [{.player_tracks}], FF
        je {.rp_blt}
        add si, 100
    +.rp_blt
        xor dx, dx
        mov cx, 10
        mov dl, 10
        mov bx, [{.player_x}]
        mov dh, by [{.player_y}]
        call {.bitblt}
    pop ax
    ret

# Подключаем процедурки
#include src/cls.s
#include src/blt.s
#include src/plot.s
#include src/palset.s
#include src/rect.s
#include src/delay.s
#include src/input.s
#include src/readkey.s
#include src/vars.s
#include src/sprites.s
