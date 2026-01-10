#include "raylib.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define SCREEN_WIDTH 800
#define SCREEN_HEIGHT 450
#define X_AXIS_Y (SCREEN_HEIGHT / 2)
#define Y_AXIS_X (SCREEN_WIDTH / 2)


int main(void)
{
  InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Visualizador de funções");
  SetTargetFPS(60);

    while (!WindowShouldClose())
    {
        BeginDrawing();
            ClearBackground(RAYWHITE);
            DrawText("Primeira função do projeto de plot!", 20, 20, 20, BLACK);
            
            DrawLine(0, X_AXIS_Y, SCREEN_WIDTH, X_AXIS_Y, LIGHTGRAY);
            DrawLine(Y_AXIS_X, 0, Y_AXIS_X, SCREEN_HEIGHT, LIGHTGRAY);
            
            for (int x = 0; x < SCREEN_WIDTH - 1; x++){
                float math_x1 = (float)(x - Y_AXIS_X) / 50.0f;
                float math_x2 = (float)((x + 1) - Y_AXIS_X) / 50.0f;

                float math_y1 = sin(math_x1);
                float math_y2 = sin(math_x2);

                int screen_y1 = X_AXIS_Y - (int)(math_y1 * 100.0f);
                int screen_y2 = X_AXIS_Y - (int)(math_y2 * 100.0f);

                DrawLine(x, screen_y1, x + 1, screen_y2, RED);

    }
        EndDrawing();

    }

    CloseWindow();

    return 0;
}
