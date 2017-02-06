#include <stdio.h>
#include <string.h>

#define BUFFERSIZE 6912

int sprite = 0;

void getXYFromIndex(unsigned int * x, unsigned int * y, unsigned int i);
unsigned int incSpriteIndex(unsigned int * i);

int main(int argc, char **argv) {

  if (argc == 3 && strcmp("--sprite", argv[2]) == 0) {
    sprite = 1;
  } else if (argc != 2) {
    return 1;
  }

  FILE *scr = fopen(argv[1], "r");
  FILE *assembly = fopen("out.asm", "w");

  unsigned char buf[BUFFERSIZE];
  size_t read = fread(buf, sizeof(unsigned char), BUFFERSIZE, scr);
  fclose(scr);
  if (read < BUFFERSIZE) {
    printf("Couldn't read as many bytes as we expected");
    return 1;
  }

  unsigned int i = 0;
  unsigned int j = 0;
  unsigned int x = 0;
  unsigned int y = 0;
  unsigned char temp;
  if (sprite) {
    while (i < 1984) {
      temp = buf[i];
      j = 0;
      while (j < 255 && buf[i] == temp && i < 1984) {
        j++;
        if (i % 32 == 5) {
          i+= 27;
          y++;
        }
        else {
          i++;
        }
        if (y >= 6) {
          i+= 64;
          y = 0;
        }
      }
      fprintf(assembly, "\tdefb %d,%d\n", temp, j);
    }
    // now do attribute bytes

    /*
    temp = buf[i];
    j = 1;
    for (unsigned int x = 0; x < 288; ++x) {
      incSpriteIndex(&i);
      if (buf[i] == temp) j++;
      else {
        fprintf(assembly, "\tdefb %d,%d\n", temp, j);
        temp = buf[i];
        j = 1;
      }
    }
    // do attributes now

    */
  }
  else {
    while (i < BUFFERSIZE) {
      temp = buf[i];
      j = 1;
      while(j < 255 && buf[++i] == temp) j++;
      fprintf(assembly, "\tdefb %d,%d\n", temp, j);
    }
  }
  fclose(assembly);
  return 0;
}

// Currently unused
unsigned int getIndexFromXY(unsigned int x, unsigned int y) {
  unsigned short ret = x;
  ret = ret & 31; // ret is 0b00000000000x7x6x5x4x3
  unsigned short temp = y;
  temp = temp & 7;
  temp = temp << 8; // isolate y2y1y0
  ret = ret | temp;
  temp = y;
  temp = temp & 56;
  temp = temp << 2; // isolate y5y4y3
  ret = ret | temp;
  temp = y;
  temp = temp & 192;
  temp = temp << 5; // isolate y7 y6
  ret = ret | temp;
  return ret;
}

// Currently unused
void getXYFromIndex(unsigned int * x, unsigned int * y, unsigned int i) {
  unsigned int temp;
  temp = i;
  temp = temp & 31;
  *x = temp;
  temp = i;
  temp = temp & 1792;
  temp = temp >> 8;
  *y = temp; // we have y2 y1 y0 in position
  temp = i;
  temp = temp & 224;
  temp = temp >> 2;
  *y = *y | temp;
  temp = i;
  temp = temp & 6144;
  temp = temp >> 5;
  *y = *y | temp;
}

// Currently unused
unsigned int incSpriteIndex(unsigned int * i) {
  unsigned int x;
  unsigned int y;
  getXYFromIndex(&x, &y, *i);
  if (x >= 5) {
    x = 0;
    y++;
  } else if (y >= 48) {
    return 0;
  } else {
    x++;
  }
  unsigned int ret = getIndexFromXY(x,y);
  *i = ret;
  return ret;
}
