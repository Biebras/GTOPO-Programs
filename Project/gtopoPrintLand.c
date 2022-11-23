#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include "gtopo.h"
#include "helpers.h"
#include "exceptionTypes.h"

int main(int argc, char **argv)
{
  //if no arguments, tell how to use
  if (argc == 1)
  {
    printf("Usage: %s inputFile width height outputFile sea hill mountain", argv[0]);
    return 0;
  }

  //Check if usage is correct
  if (argc != 8)
  {
    HandleErrors(NULL, NULL, "Bad Argument Count", NULL);
    return EXIT_WRONG_ARG_COUNT;
  }

  GtopoData gtopoData;

  //restart erno to detect errors`
  errno = 0;

  //convert all string integers to int
  int width = StringToPosInt(argv[2]);
  int height = StringToPosInt(argv[3]);
  int seaLevel = StringToPosInt(argv[5]);
  int hillLevel = StringToPosInt(argv[6]);
  int mountainLevel = StringToPosInt(argv[7]);

  //if some of the reads failed return error
  if(errno != 0)
  {
    HandleErrors(NULL, NULL, "Miscellaneous", "Width, Height, Sea Level, Hill Level or Mountain Level is incorect");
    return MISCELLANEOUS;
  }

  gtopoData.width = width;
  gtopoData.height = height;

  //Read file
  int readReturn = ReadGtopoData(&gtopoData, argv[1]);

  //Return if read throws error
  if(readReturn != 0)
    return readReturn;

  //Draw map symbols
  int writeOutput = DrawMap(&gtopoData, seaLevel, hillLevel, mountainLevel, argv[4]);

  //Return if write returns error
  if(writeOutput != 0)
    return writeOutput;

  //free data
  FreeGtopoData(&gtopoData);
  return 0;
}
