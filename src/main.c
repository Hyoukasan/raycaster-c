#include <types.h>
#include <GLFW/glfw3.h>
#include <game.h>
#include <stdio.h>

int main(void)
{
    if(!glfwInit()) {
        printf("Cannot be init\n");
        return -1;
    }
    printf("Test!\n");
    return 0;
}