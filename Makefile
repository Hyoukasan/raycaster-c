# Configuration
TARGET 	    := game
BUILD_DIR   := build
SRC_DIR     := src
INCLUDE_DIR := include

# GCC configuration link
GLFW_LIBS_GCC  ?= -lglfw3
# MSVC configutation link
GLFW_LIBS_MSVC ?= lib/libglfw/glfw3dll.lib

# Flags
CC ?= gcc

ifeq ($(CC), gcc)
	OPT_FLAGS := -O2
	CFLAGS    := -Wextra -g -I./$(INCLUDE_DIR)
	LDFLAGS   := $(GLFW_LIBS_GCC)
else ifeq ($(CC), cl)
	OPT_FLAGS := /O2
	CFLAGS    := /Wextra /Zi /I./$(INCLUDE_DIR)
	LDFLAGS   := $(GLFW_LIBS_MSVC)
endif

# Tools
OBJECTS = $(SRCS:src/%.c=$(BUILD_DIR)/%.o)

# Rules
all: $(BUILD_DIR) $(TARGET)

clean:
	rmdir /s /q "$(BUILD_DIR)"


# Recipes

$(BUILD_DIR):
	@if not exist "$(BUILD_DIR)" mkdir "$(BUILD_DIR)"

$(TARGET): $(OBJECTS)
	$(CC) $(OPT_FLAGS) -g -o $@ $^ $(CFLAGS)

$(BUILD_DIR)/%.o: src/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

