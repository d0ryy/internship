BITS 32             ;  Tell nasm this is 32-bit code.

jmp short one       ;  Jump down to a call at the end.

two:
; ssize_t write(int fd,  const void *buf, size_t count);
  pop ecx           ;  Pop the return address (string ptr) into ecx.
  mov eax, 4        ;  Write syscall #.
  mov ebx, 1        ;  STDOUT file descriptor
  mov edx, 15       ;  Length of the string
  int 0x80          ;  Do syscall: write(1, string, 14)

; void _exit(int status);
  mov eax, 1        ; Exit syscall #
  mov ebx, 0        ; Status = 0
  int 0x80          ; Do syscall: exit(0)

one:
  call two   ; Call back upwards to avoid null bytes
  db "Hello, world!", 0x0a, 0x0d ; with newline and carriage return bytes.
