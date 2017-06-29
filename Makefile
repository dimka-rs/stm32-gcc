CC=arm-none-eabi-gcc
AS=arm-none-eabi-as
CFLAGS=-I. -IInclude -DSTM32L073xx

OBJ = main.o startup_stm32l073xx.o system_stm32l0xx.o

%.o: %.c %.s
	$(CC) -c -o $@ $< $(CFLAGS)

startup_stm32l073xx.o:
	$(AS) gcc/startup_stm32l073xx.s -o $@

main: $(OBJ)
	$(CC) -nostdlib -o $@ $^ $(CFLAGS) -T STM32L073RZTx_FLASH.ld

bin:
	arm-none-eabi-objcopy -O binary main main.bin

all: main bin

flash:
	./st-flash write ./main.bin 0x8000000
