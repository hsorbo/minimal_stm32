TARGET = minimal
DEBUG = 1
OPT = -Og
BUILD_DIR = build
C_SOURCES = minimal.c
ASM_SOURCES =  

PREFIX = arm-none-eabi-
CC = $(PREFIX)gcc
OBJCOPY = $(PREFIX)objcopy
SZ = $(PREFIX)size

CPU = -mcpu=cortex-m0
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)
AS_DEFS = 
C_DEFS =

AS_INCLUDES = 
C_INCLUDES = 

ASFLAGS = $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections
CFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif

CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"

LDSCRIPT = minimal.ld

LIBS = -lc -lm -lnosys 
LIBDIR = 
LDFLAGS = $(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin

OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(OBJCOPY) -O ihex $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(OBJCOPY) -O binary -S $< $@	
	
$(BUILD_DIR):
	mkdir $@		

clean:
	-rm -fR $(BUILD_DIR)
  
-include $(wildcard $(BUILD_DIR)/*.d)
