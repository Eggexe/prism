CC      := gcc
TARGET  := Prism
BUILD   := build

CFLAGS  := -std=c99 -Wall -Wextra -Wpedantic -MMD -MP -I. -Iinclude \
           -D_GNU_SOURCE=1 -DGLFW_INCLUDE_NONE
LDFLAGS :=
LDLIBS  := -lglfw -lm -ldl

SRCS := $(wildcard *.c) $(wildcard src/*.c)
OBJS := $(SRCS:%.c=$(BUILD)/%.o)
DEPS := $(OBJS:.o=.d)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS) $(LDLIBS)

$(BUILD)/%.o: %.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILD) $(TARGET)

.PHONY: all clean

-include $(DEPS)
