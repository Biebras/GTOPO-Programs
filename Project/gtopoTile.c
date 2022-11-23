#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include "gtopo.h"
#include "exceptionTypes.h"
#include "helpers.h"

int main(int argc, char **argv)
{
    //if no arguments, tell how to use
    if (argc == 1)
  	{
  		printf("Usage: %s inputFile width height tiling_factor outputFile_<row>_<column>", argv[0]);
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

    //read file
    int readReturn = ReadGtopoData(&gtopoData, argv[1]);

    //if can't read exit program
    if(readReturn != 0)
        return readReturn;

    //read factor
    int factor = StringToPosInt(argv[4]);

    //If factor is not a number or <= zero, return error
    if(factor <= 0)
    {
      FreeGtopoData(&gtopoData);
      HandleErrors(NULL, NULL, "Miscellaneous", "Factor is not numeric or invalid");
      return MISCELLANEOUS;
    }

    //If width and height is not a number or <= zero, return error
    if(gtopoData.width % factor != 0 || gtopoData.height % factor != 0)
    {
      FreeGtopoData(&gtopoData);
      HandleErrors(NULL, NULL, "Miscellaneous", "Can't devide width or lenght with this factor");
      return MISCELLANEOUS;
    }

    //create array to store diffrent tiles
    GtopoData gtopoDatas[factor * factor];

    //Length and width of one image tile
    int widthImageLength = gtopoData.width / factor;
    int heightImageLength = gtopoData.height / factor;

    //Loop in certain boundries and store gtopoData to arrray
    for (int y = 0; y < factor; y++)
    {
      for (int x = 0; x < factor; x++)
      {
        //Needed variables for copy image data function
        GtopoData data;
        int startRow = y * heightImageLength;
        int startColumn = x * widthImageLength;
        int width = widthImageLength;
        int height = heightImageLength;

        //Get part of Image Data
        int16_t **imageData = NULL;
        AllocateImageData(&imageData, width, height);

        //CopyPartOfImageData(gtopoData.imageData, imageData, startColumn, startRow, width, height);
        CopyPartOfImageData(gtopoData.imageData, startColumn, startRow, imageData, 0, 0, width, height);

        //Create new gtopo data with certain boundries of image data
        CreateGtopoData(&data, width, height, imageData);
        //Add newlly created gtopoData into array
        gtopoDatas[x + factor * y] = data;
      }
    }

    //write extracted image data into seperate files
    for (int y = 0; y < factor; y++)
    {
      for (int x = 0; x < factor; x++)
      {
        //file name with row and column
        char *fileName = NULL;
        fileName = strdup(argv[5]);
        //Max 10 numbers for row and column, that should be enought
        char rowChar[10];
        char columnChar[10];

        //Read numbers
        snprintf(rowChar, 8, "%d", y);
        snprintf(columnChar, 8, "%d", x);

        //Replace row and column tags with numbers
        int replaceReturn = 0;

        //replace <row> tag with row number
        replaceReturn = ReplaceString(fileName, "<row>", rowChar);

        //return if tag was not found
        if(replaceReturn != 0)
        {
          FreeGtopoDatas(gtopoDatas, factor * factor);
          FreeGtopoData(&gtopoData);
          HandleErrors(NULL, NULL, "Miscellaneous", "No tags were found");
          return replaceReturn;
        }

        //replace <column> tag with column number
        replaceReturn =  ReplaceString(fileName, "<column>", columnChar);

        //return if tag was not found
        if(replaceReturn != 0)
        {
          FreeGtopoDatas(gtopoDatas, factor * factor);
          FreeGtopoData(&gtopoData);
          HandleErrors(NULL, NULL, "Miscellaneous", "No tags were found");
          return replaceReturn;
        }

        //Get gtopoData from array and write into file with custom name
        GtopoData data = gtopoDatas[x + factor * y];
        int writeReturn = WriteGtopoData(&data, fileName);

        //return error if can't write
        if(writeReturn != 0)
            return writeReturn;
      }
    }

    //free data
    FreeGtopoDatas(gtopoDatas, factor * factor);
    FreeGtopoData(&gtopoData);
    printf("TILED\n");
    return 0;
}
