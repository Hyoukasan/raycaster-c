CC = gcc
OPT = -O2
CFLAGS = -Wall -Wextra -g -I include/extra
MKDIR_BUILD = @if not exist "$(BUILD_DIR)" mkdir "$(BUILD_DIR)"
CLEAN_BUILD = rmdir /s /q "$(BUILD_DIR)"

TARGET = game
BUILD_DIR = build
SRCS = src/main.c

OBJECTS = $(SRCS:src/%.c=$(BUILD_DIR)/%.o)

all: $(BUILD_DIR) $(TARGET)

$(BUILD_DIR):
	$(MKDIR_BUILD)

$(TARGET): $(OBJECTS)
	$(CC) $(OPT) -g -o $@ $^ $(CFLAGS)

$(BUILD_DIR)/%.o: src/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	&(CLEAN_BUILD)


