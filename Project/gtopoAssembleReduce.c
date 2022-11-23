#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "gtopo.h"
#include "helpers.h"
#include "assemble.h"
#include "exceptionTypes.h"

int main(int argc, char **argv)
{
  //if no arguments, tell how to use
  if (argc == 1)
  {
    printf("Usage: %s outputArray.gtopo width height reduction_factor (row column inputArray.gtopo width height)+", argv[0]);
    return 0;
  }

  //Check if usage is correct
  //-5 because first 5 arguments does not matter
  if ((argc - 5) % 5 != 0)
  {
    HandleErrors(NULL, NULL, "Bad Argument Count", NULL);
    return EXIT_WRONG_ARG_COUNT;
  }

  //Allocate array for to store arg data
  ArgAssembleData data[argc];

  //Get from args width, height and factor
  int width = StringToPosInt(argv[2]);
  int height = StringToPosInt(argv[3]);
  int factor = StringToPosInt(argv[4]);

  //if incorect width or height return error
  if(width <= 0 || height <= 0)
  {
      HandleErrors(NULL, NULL, "Miscellaneous", "Width or Height arguments is incorect");
      return MISCELLANEOUS;
  }

  //if factor is incorect return error
  if (factor <= 0)
  {
      HandleErrors(NULL, NULL, "Miscellaneous", "Factor was non-numeric or <= 0");
      return MISCELLANEOUS;
  }

  //variable to count how many datas we will manipulate
  int dataSize = 0;

  //Loop arguments and get data
  for (int i = 0; i < argc; i++)
  {
      //index of begining of tile arguments
      int argIndex = 5 * i + 5;

      if(argv[argIndex] == NULL)
        break;

      //Store data to struct
      int rezData = SetAssembleArgData(&data[i], argIndex, argv);

      //return if argument layout is bad
      if(rezData == BAD_LAYOUT)
      {
          HandleErrors(NULL, NULL, "Bad Layout", NULL);
          return BAD_LAYOUT;
      }

      dataSize = i + 1;
  }

  GtopoData gtopoData;
  //SET values to deffault
  SetUpGtopoDataVariables(&gtopoData);

  //Char to save all the files to one imageData
  int16_t **buffer;

  //Allocate some memory for buffer
  AllocateImageData(&buffer, width, height);
  //Create gtopoData with empty imageBuffer
  CreateGtopoData(&gtopoData, width, height, buffer);

  //Loop file data array and fill gtopoData with imageData with certain boundries
  for (int i = 0; i < dataSize; i++)
  {
    //gtopo data to store tile data
    GtopoData gtopoDataTile;
    gtopoDataTile.width = data[i].width;
    gtopoDataTile.height = data[i].height;

    //Setups to deffault values
    SetUpGtopoDataVariables(&gtopoDataTile);

    //read tile and store it to local gtopoData structure
    int readReturn = ReadGtopoData(&gtopoDataTile, data[i].fileName);

    //If read is not successful exit program
    if(readReturn != 0)
        return readReturn;

    //copies image data and assigns to gtopoData
    CopyPartOfImageData(gtopoDataTile.imageData, 0, 0, gtopoData.imageData, data[i].column, data[i].row, gtopoDataTile.width, gtopoDataTile.height);
  }

  //reduce height for reduce image
  int reducedWidth = RoundUp((double)gtopoData.width / (double)factor);
  int reducedHeight = RoundUp((double)gtopoData.height / (double)factor);

  //if something wrong with round up, return error
  if(reducedHeight <= 0 || reducedHeight <= 0)
  {
    FreeGtopoData(&gtopoData);
    HandleErrors(&gtopoData, NULL, "Miscellaneous", "Reduced height or reduced with is 0");
    return MISCELLANEOUS;
  }

  //Create empty image data to store data from main image
  int16_t **reduceBuffer;
  int mallocRes = AllocateImageData(&reduceBuffer, reducedWidth, reducedHeight);

  //return error if there was issues in allocating
  if(mallocRes == -1)
  {
    FreeGtopoData(&gtopoData);
    HandleErrors(NULL, NULL, "Image Malloc Failed", argv[1]);
    return IMAGE_MALLOC_FAILED;
  }

  //Store reduced data
  for (int y = 0; y < gtopoData.height; y += factor)
  {
      for (int x = 0; x < gtopoData.width; x += factor)
      {
          reduceBuffer[y / factor][x / factor] = gtopoData.imageData[y][x];
      }
  }

  //create new gtopoData structure with reduced imageData
  GtopoData reducedData;
  int createRez = CreateGtopoData(&reducedData, reducedWidth, reducedHeight, reduceBuffer);

  //return error if Malloc Failed
  if(createRez == IMAGE_MALLOC_FAILED)
  {
    FreeGtopoData(&gtopoData);
    HandleErrors(NULL, NULL, "Image Malloc Failed", argv[1]);
    return IMAGE_MALLOC_FAILED;
  }

  //write data into file
  int writeRez = WriteGtopoData(&reducedData, argv[1]);

  if(writeRez != 0)
  {
    FreeGtopoData(&gtopoData);
    return writeRez;
  }

  //free used data
  FreeGtopoData(&gtopoData);
  FreeGtopoData(&reducedData);
  printf("REDUCED\n");
  return 0;
}
