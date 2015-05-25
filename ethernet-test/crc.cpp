#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <string.h>

using std::cout;
using std::endl;
using std::hex;

// Reverses (reflects) bits in a 32-bit word.
unsigned reverse(unsigned x) {
   x = ((x & 0x55555555) <<  1) | ((x >>  1) & 0x55555555);
   x = ((x & 0x33333333) <<  2) | ((x >>  2) & 0x33333333);
   x = ((x & 0x0F0F0F0F) <<  4) | ((x >>  4) & 0x0F0F0F0F);
   x = (x << 24) | ((x & 0xFF00) << 8) |
       ((x >> 8) & 0xFF00) | (x >> 24);
   return x;
}

void printBits(unsigned x){
  for(short a = 0; a < 32; a++){
    if(x & (0x80000000 >> a)){
      printf("1");
    }else{
      printf("0");
    }
  }
  printf("\n");
}

// ----------------------------- crc32a --------------------------------

/* This is the basic CRC algorithm with no optimizations. It follows the
logic circuit as closely as possible. */

unsigned int crc32a(unsigned char *message) {
   int i, j;
   unsigned int byte, crc;

   i = 0;
   crc = 0xFFFFFFFF;
   while (message[i] != 0) {
      cout << "Currently working on index " << i << endl;
      byte = message[i];            // Get next byte.
      cout << "Byte equals ";
      printf("%02x ", byte);
      byte = reverse(byte);         // 32-bit reversal.
      cout << "reversed ";
      printBits(byte);
      
      for (j = 0; j <= 7; j++) {    // Do eight times.
         cout << "Round number " << j << endl;
         printf("running %08x ^ %08x < 0\n", crc, byte);
         if ((int)(crc ^ byte) < 0){
              printf("CRC came back negative.  Running (%08x << 1) ^ 0x04C11DB7\n", crc);
              crc = (crc << 1) ^ 0x04C11DB7;
              printf("CRC now equals %08x\n", crc);
         }else{
              crc = crc << 1;
              printf("CRC was not < 0, so it now equals %08x\n", crc);
         }
         byte = byte << 1;          // Ready next msg bit.
         printf("Byte now equals %08x\n", byte);
         printf("crc now equals %08x\n", crc);
         printf("ROUND %d COMPLETE\n\n", j);
      }
      i = i + 1;
   }

   printf("prior to reversal, crc equals %08x\n", crc);
   return reverse(~crc);
}

int main(int argc, char ** argv){
  char * buffer = new char[strlen(argv[1])];
  
  for(int a = 0; a < strlen(argv[1]); a++){
    buffer[a] = itoa(argv[1][a], buffer[a], 16);
  }
  printf("%08x\n", crc32a(buffer[1]));

  return 0;
}
