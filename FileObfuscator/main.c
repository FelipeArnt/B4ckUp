#include <stdio.h>
#include <stdlib.h>

int obfuscator(int c)
{
  return ~c;
}

int main()
{
  int c;
  while((c = getchar()) != EOF)
    putchar(obfuscator(c));
}
