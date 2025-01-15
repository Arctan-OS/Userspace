PRODUCT := $(ARC_ROOT)/initramfs-constant/userspace.elf

ifeq (,$(ARC_ROOT))
	ARC_ROOT := .
	PRODUCT := ./userspace.elf
endif

CPPFLAGS := $(CPPFLAG_DEBUG) $(CPPFLAG_E9HACK) $(CPP_DEBUG_FLAG) $(CPP_E9HACK_FLAG) $(ARC_TARGET_ARCH) \
	    $(shell find ~+ -type d -wholename "*src/c/include" -exec echo "-I$1" {} \;)

export CPPFLAGS

CFLAGS := -c -m64 -c -masm=intel -fno-stack-protector -fno-stack-check \
		  -fno-lto -mno-mmx -mno-80387 -mno-red-zone -Wall \
		  -Wextra -mno-sse -mno-sse2 -ffreestanding -nostdlib \
		  -fPIE -ffunction-sections -march=x86-64-v2

export CFLAGS

LDFLAGS := -Tlinker.ld -melf_x86_64 --no-dynamic-linker -static -pie -o $(PRODUCT)

NASMFLAGS := -f elf64

export NASMFLAGS

CFILES := $(shell find ./src/c/ -type f -name "*.c")
ASFILES := $(shell find ./src/asm/ -type f -name "*.asm")
OFILES := $(CFILES:.c=.o) $(ASFILES:.asm=.o)

.PHONY: all
all: build
	$(LD) $(LDFLAGS) $(shell find . -type f -name "*.o")

.PHONY: arch-x86-64
arch-x86-64:
	echo "Nothing"

.PHONY: build
build: pre-build
	$(MAKE) $(OFILES)

.PHONY: pre-build
pre-build: clean


src/c/%.o: src/c/%.c
	$(CC) -c $(CPPFLAGS) $(CFLAGS) $< -o $@

src/asm/%.o: src/asm/%.asm
	nasm $(NASMFLAGS) $< -o $@

.PHONY: clean
clean:
	find . -type f -name "*.o" -delete
