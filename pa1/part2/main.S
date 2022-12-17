.section .data
# There are two global variables:
#  1. array: Store the input numbers.
#  2. size: the number of the list
# You can modify the following two lines to test your program,
# but DO NOT change the line number
array: .dword 15, 20, 6, 35, 70, 7, 14, 36, 1, 21, 13, 3, 24, 5, 22, 2, 4, 10, 8, 12
size: .dword 20

# Variables for print function
# DO NOT modify these
dummy_msg: .ascii "   "
newline_msg: .ascii "\n"
ascii_msg: .ascii "Test"
magic_mem: .space 64

.section .text
.global main
main:

  # save return pointer
  addi sp, sp, -8
  sd ra, 0(sp)

  la a0, array      # assign array address to a0
  ld a2, size       # assign array size to a2

  li a3, 0          # low
  addi a2, a2, -1   # high

  jal partition     # jump to function
  
  jal print         # show results

  li a0, 0

  ld ra, 0(sp)
  addi sp, sp, 8

  ret               # return (jump to the address stored in register ra)

.global partition
partition:

  #########################
  # Finish your code here #
  #########################

  # save registers
  # pivot = s0, i = s1, j = s2, a0 + 8 * j = s3, arr[j] = s4
  addi sp, sp, -48
  sd s4, 40(sp)
  sd s3, 32(sp)
  sd s2, 24(sp)
  sd s1, 16(sp)
  sd s0, 8(sp)
  sd ra, 0(sp)

  # pivot = arr[high]
  addi s4, zero, 8
  mul s1, s4, a2
  add s1, s1, a0
  ld s0, 0(s1)

  # i = j = low
  addi s1, a3, 0
  addi s2, a3, 0
  
  # get j's actual address
  mul s3, a3, s4
  add s3, s3, a0

  # partitioning
  l1:
    # break if j >= high
    bge s2, a2, l3

    # s4 = arr[j]
    ld s4, 0(s3)

    # continue if arr[j] >= pivot
    bge s4, s0, l2
    # swap(&arr[i++], &arr[j])
    addi a3, s1, 0
    addi a4, s2, 0
    jal swap
    addi s1, s1, 1

    # next iteration
    l2:
      # j += 1
      addi s2, s2, 1
      addi s3, s3, 8
      beq x0, x0, l1
  l3:
    # swap(&arr[i], &arr[high])
    addi a3, s1, 0
    addi a4, a2, 0
    jal swap

  # load registers
  ld s4, 40(sp)
  ld s3, 32(sp)
  ld s2, 24(sp)
  ld s1, 16(sp)
  ld s0, 8(sp)
  ld ra, 0(sp)
  addi sp, sp, 48

  ret

.global swap
swap:

  # save registers
  addi sp, sp, -40
  sd s3, 32(sp)
  sd s2, 24(sp)
  sd s1, 16(sp)
  sd s0, 8(sp)
  sd ra, 0(sp)

  # get swapping addresses
  addi s1, zero, 8
  mul s0, s1, a3
  add s0, s0, a0
  mul s1, s1, a4
  add s1, s1, a0

  # load swapping numbers
  ld s2, 0(s0)
  ld s3, 0(s1)

  # swap
  sd s3, 0(s0)
  sd s2, 0(s1)

  # load registers
  ld s3, 32(sp)
  ld s2, 24(sp)
  ld s1, 16(sp)
  ld s0, 8(sp)
  ld ra, 0(sp)
  addi sp, sp, 40

  ret

####################################
# Helper function to print results #
#     DO NOT modify this!!!!!!     #
####################################
.global print
print:

  addi sp, sp, -72
  sd s7, 64(sp)
  sd s6, 56(sp)
  sd s5, 48(sp)
  sd s4, 40(sp)
  sd s3, 32(sp)
  sd s2, 24(sp)
  sd s1, 16(sp)
  sd s0, 8(sp)
  sd ra, 0(sp)

  la s0, array
  ld s1, size

  li s2, 0

print_loop:
  slli s3, s2, 3
  add s3, s0, s3
  ld s4, 0(s3)

  li s3, 10
  div s5, s4, s3
  rem s4, s4, s3

  beq s5, zero, less_than_10

  addi s5, s5, 48
  la s7, ascii_msg 
  sw s5, 0(s7)

  la s7, magic_mem
  li s6, 64
  sw s6, 0(s7)
  li s6, 1
  sw s6, 8(s7)
  la s6, ascii_msg
  sw s6, 16(s7)
  li s6, 1
  sw s6, 24(s7)
  la s6, tohost
  sw s7, 0(s6)

wait1:
  la s6, fromhost
  ld s7, 0(s6)
  beq s7, zero, wait1

  sw zero, 0(s6)

less_than_10:

  addi s4, s4, 48
  la s7, ascii_msg 
  sw s4, 0(s7)

  la s7, magic_mem
  li s6, 64
  sw s6, 0(s7)
  li s6, 1
  sw s6, 8(s7)
  la s6, ascii_msg
  sw s6, 16(s7)
  li s6, 1
  sw s6, 24(s7)
  la s6, tohost
  sw s7, 0(s6)

wait2:
  la s6, fromhost
  ld s7, 0(s6)
  beq s7, zero, wait2

  sw zero, 0(s6)

  la s7, magic_mem
  li s6, 64
  sw s6, 0(s7)
  li s6, 1
  sw s6, 8(s7)
  la s6, newline_msg
  sw s6, 16(s7)
  li s6, 1
  sw s6, 24(s7)
  la s6, tohost
  sw s7, 0(s6)

wait3:
  la s6, fromhost
  ld s7, 0(s6)
  beq s7, zero, wait3

  sw zero, 0(s6)

  addi s2, s2, 1
  bne s2, s1, print_loop

  ld ra, 0(sp)
  ld s0, 8(sp)
  ld s1, 16(sp)
  ld s2, 24(sp)
  ld s3, 32(sp)
  ld s4, 40(sp)
  ld s5, 48(sp)
  ld s6, 56(sp)
  ld s7, 64(sp)
  addi sp, sp, 72

  ret