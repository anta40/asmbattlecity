# Процедура очистки экрана
a
+.cls
    mov cx, FA00
    mov al, 0
    rep stosb
    ret

#