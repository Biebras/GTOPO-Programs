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
  		printf("Usage: %s outputFile width height (row column inputFile width height)+", argv[0]);
  		return 0;
  	}

    //Check if usage is correct
    //-4 because first 4 arguments does not matter
    if ((argc - 4) % 5 != 0)
  	{
  		HandleErrors(NULL, NULL, "Bad Argument Count", NULL);
  		return EXIT_WRONG_ARG_COUNT;
  	}

    //Allocate array for to store arg data
    ArgAssembleData data[argc];

    //Get from args width and height
    int width = StringToPosInt(argv[2]);
    int height = StringToPosInt(argv[3]);

    //if can't read width and height return error
    if(width <= 0 || height <= 0)
    {
        HandleErrors(NULL, NULL, "Miscellaneous", "Width or Height arguments is incorect");
        return MISCELLANEOUS;
    }

    //variable to keep count of tile data
    int dataSize = 0;

    //Loop arguments and get data
    for (int i = 0; i < argc; i++)
    {
      //index of begining of tile arguments
      int argIndex = 5 * i + 4;

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

        int readReturn = ReadGtopoData(&gtopoDataTile, data[i].fileName);

        //If read is not successful exit program
        if(readReturn != 0)
            return readReturn;

        //copies image data and assigns to gtopoData
        CopyPartOfImageData(gtopoDataTile.imageData, 0, 0, gtopoData.imageData, data[i].column, data[i].row, gtopoDataTile.width, gtopoDataTile.height);
    }

    //writes information
    int writeReturn = WriteGtopoData(&gtopoData, argv[1]);

    //If write is not successful, then exit program
    if(writeReturn != 0)
      return writeReturn;

    //frees gtopo data
    FreeGtopoData(&gtopoData);
    printf("ASSEMBLED\n");
    return 0;
}
