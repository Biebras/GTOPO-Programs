#include <stdio.h>
#include <stdlib.h>
#include "gtopo.h"
#include "helpers.h"
#include "exceptionTypes.h"

int main(int argc, char **argv)
{
    //if no arguments, tell how to use
    if (argc == 1)
  	{
  		printf("Usage: %s input width height reduction_factor output", argv[0]);
  		return 0;
  	}

    //Check if usage is correct
    if (argc != 6)
  	{
  		HandleErrors(NULL, NULL, "Bad Argument Count", NULL);
  		return EXIT_WRONG_ARG_COUNT;
  	}

    GtopoData gtopoData;
    //convert width and height args to int
    int width = StringToPosInt(argv[2]);
    int height = StringToPosInt(argv[3]);

    gtopoData.width = width;
    gtopoData.height = height;

    //Read gtopo data
    int readReturn = ReadGtopoData(&gtopoData, argv[1]);

    //If can't read exit program
    if(readReturn != 0)
        return readReturn;

    //Convert factor from string to int
    int factor = StringToPosInt(argv[4]);

    //return error if factor was not number or <= 0
    if (factor <= 0)
    {
        FreeGtopoData(&gtopoData);
        HandleErrors(NULL, NULL, "Miscellaneous", "Factor was non-numeric or <= 0");
        return MISCELLANEOUS;
    }

    //reduce width and height for reduced image
    int reducedWidth = RoundUp((double)gtopoData.width / (double)factor);
    int reducedHeight = RoundUp((double)gtopoData.height / (double)factor);

    //if reduced width or height is <= 0, return error
    if(reducedHeight <= 0 || reducedHeight <= 0)
    {
      FreeGtopoData(&gtopoData);
      HandleErrors(&gtopoData, NULL, "Miscellaneous", "Reduced height or reduced with is 0");
      return MISCELLANEOUS;
    }

    //Create empty image data to store data from main image
    int16_t **buffer;
    int mallocRes = AllocateImageData(&buffer, reducedWidth, reducedHeight);

    //return error if malloc failed
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
        buffer[y / factor][x / factor] = gtopoData.imageData[y][x];
      }
    }

    //create new gtopoData structure with reduced imageData
    GtopoData reducedData;
    int createRez = CreateGtopoData(&reducedData, reducedWidth, reducedHeight, buffer);

    //return error if malloc Failed
    if(createRez == IMAGE_MALLOC_FAILED)
    {
      FreeGtopoData(&gtopoData);
      HandleErrors(NULL, NULL, "Image Malloc Failed", argv[1]);
      return IMAGE_MALLOC_FAILED;
    }

    //write data into file
    int writeRez = WriteGtopoData(&reducedData, argv[5]);

    if(writeRez != 0)
    {
      FreeGtopoData(&gtopoData);
      return writeRez;
    }

    //free alocated data
    FreeGtopoData(&gtopoData);
    FreeGtopoData(&reducedData);
    printf("REDUCED\n");
    return 0;
}
