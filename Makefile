# Configuration
TARGET 	    := game
BUILD_DIR   := build
SRC_DIR     := src
INCLUDE_DIR := include

SRCS := $(wildcard $(SRC_DIR)/*.c)        

# GCC configuration link
GLFW_LIBS_GCC  ?= -lglfw3
# MSVC configutation link
GLFW_LIBS_MSVC ?= lib/libglfw/glfw3dll.lib


# Flags
CC ?= gcc

ifeq ($(CC), gcc)
	OPT_FLAGS := -O2
	CFLAGS    := -Wextra -g -I./$(INCLUDE_DIR) -I./$(INCLUDE_DIR)/extra
	LDFLAGS   := $(GLFW_LIBS_GCC)
else ifeq ($(CC), cl)
	OPT_FLAGS := /O2
	CFLAGS    := /Wextra /Zi /I./$(INCLUDE_DIR) /I./$(INCLUDE_DIR)/extra
	LDFLAGS   := $(GLFW_LIBS_MSVC)
endif


# Tools
OBJECTS = $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)


# Rules
.PHONY: all clean

all: $(BUILD_DIR) $(TARGET)

clean:
	@if exist "$(BUILD_DIR)" rmdir /s /q "$(BUILD_DIR)"
	@if exist "$(TARGET).exe" del /f /q "$(TARGET).exe"


# Recipes
$(BUILD_DIR):
	@if not exist "$(BUILD_DIR)" mkdir "$(BUILD_DIR)"

$(TARGET): $(OBJECTS)
	$(CC) $(OPT_FLAGS) -o $@ $^ $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

