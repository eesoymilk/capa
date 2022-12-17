XLEN ?=64

src_dir = $(HOME)/repos/capa

RISCV_PREFIX ?= riscv$(XLEN)-unknown-elf-
RISCV_GCC ?= $(RISCV_PREFIX)gcc
RISCV_GCC_OPTS ?= -DPREALLOCATE=1 -DHOST_DEBUG=0 -mcmodel=medany -static -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf
RISCV_LINK ?= $(RISCV_GCC) -T $(src_dir)/common/test.ld $(incs)
RISCV_LINK_MT ?= $(RISCV_GCC) -T $(src_dir)/common/test-mt.ld
RISCV_LINK_OPTS ?= -nostdlib -nostartfiles -ffast-math -lgcc -lc
RISCV_OBJDUMP ?= $(RISCV_PREFIX)objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.data

VPATH += $(src_dir)/common
incs  += -I$(src_dir)/env -I$(src_dir)/common


################
#              #
# Source files #
#              #
################
	
c_src = \
	syscalls.c \
	
riscv_src = \
	crt.S \
	tmp.S \

###################
#                 #
# Executable name #
#                 #
###################

riscv_bin = part3.riscv
riscv_dump = $(riscv_bin).dump


c_objs     = $(patsubst %.c, %.o, $(c_src))
riscv_objs = $(patsubst %.S, %.o, $(riscv_src))


all: $(riscv_bin)  $(riscv_dump)


$(riscv_dump): $(riscv_bin)
	$(RISCV_OBJDUMP) $(riscv_bin) > $(riscv_dump)

$(riscv_bin) : $(c_objs) $(riscv_objs)
	$(RISCV_LINK) $(c_objs) $(riscv_objs) $(RISCV_LINK_OPTS) -o $(riscv_bin)

%.o: %.c
	$(RISCV_GCC) $(RISCV_GCC_OPTS) \
	             -c $(incs) $< -o $@

%.o: %.S tmp.S 
	$(RISCV_GCC) $(RISCV_GCC_OPTS) -D__ASSEMBLY__=1 \
	             -c $(incs) $< -o $@
tmp.S: main.S 
	sed "s/NUM1, NUM2, NUM3, NUM4, NUM5, NUM6, NUM7/8, 7, 15, 4, 20, 10, 2/" $< > $@
	

clean:
	rm -rf $(c_objs) $(riscv_objs) $(riscv_bin) $(riscv_dump) tmp.S
