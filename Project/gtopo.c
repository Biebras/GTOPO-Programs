#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include "gtopo.h"
#include "helpers.h"
#include "exceptionTypes.h"

//Swaps whole image data from big to small endian and reverse
void SwapImageData(int16_t **imageData, int width, int height)
{
  //itirates through image data
  for (int y = 0; y < height; y++)
  {
    for (int x = 0; x < width; x++)
    {
      int16_t grayValue = imageData[y][x];
      //changes endian
      imageData[y][x] = Swap16bit(grayValue);
    }
  }
}

//frees data from imageData
void FreeGtopoData(GtopoData *gtopoData)
{
    if(gtopoData->imageData != NULL)
	    free(gtopoData->imageData);
}

//frees array of image datas
void FreeGtopoDatas(GtopoData *gtopoDatas, int length)
{
	for (int i = 0; i < length; i++)
	{
		//free data if it was alocated
		if(gtopoDatas[i].imageData != NULL)
	    	free(gtopoDatas[i].imageData);
	}
}

//handles errors (AKA. frees alocated data, prints message and closes file)
void HandleErrors(GtopoData *gtopoData, FILE *file, char *errorMessage, char *fileName)
{
	//Free gtopo data
	if(gtopoData != NULL)
    	FreeGtopoData(gtopoData);

	//Close file
	if(file != NULL)
    	fclose(file);

  //depending if file name is provided print certan message
	if(fileName != NULL)
    	printf("ERROR: %s (%s)\n", errorMessage, fileName);
	else
		printf("ERROR: %s\n", errorMessage);
}

void SetUpGtopoDataVariables(GtopoData *gtopoData)
{
  //Set up values to null to later check if we alocated memory
  gtopoData->imageData = NULL;
}

int ReadGtopoData(GtopoData *gtopoData, char *fileName)
{
  //Read Binary
  FILE *inputFile = fopen(fileName, "rb");

	//Set variables to null to later detect if the memory was allocated
	SetUpGtopoDataVariables(gtopoData);

  //If incorect file name return error
  if (inputFile == NULL)
  {
    HandleErrors(gtopoData, inputFile, "Bad File Name", fileName);
    return BAD_FILE_NAME;
  }

  //assigning width and height for easier use
  int width = gtopoData->width;
  int height = gtopoData->height;

  //Check for bad dementions
  if(width <= 0 || height <= 0)
  {
    HandleErrors(gtopoData, inputFile, "Bad Dimensions", fileName);
    return BAD_DIMENSIONS;
  }

	int mallocRes = AllocateImageData(&(gtopoData->imageData), width, height);

  //if malloc failed return error
	if(mallocRes == -1)
	{
		HandleErrors(gtopoData, inputFile, "Image Malloc Failed", fileName);
		return IMAGE_MALLOC_FAILED;
	}

  //declear scanCount to check if reading files works correctlly
  int scanCount = -1;

  //Read binary
  for (int y = 0; y < height; y++)
  {
    int16_t buffer[width];
    scanCount = fread(buffer, sizeof(int16_t), width, inputFile);

    //Check if there is too little data
    if(scanCount != gtopoData->width)
    {
      HandleErrors(gtopoData, inputFile, "Bad Data", fileName);
      return BAD_DATA;
    }

    for (int x = 0; x < width; x++)
    {
      //Swap endian from big to little
      int grayValue = Swap16bit(buffer[x]);

      //Assign value
      gtopoData->imageData[y][x] = grayValue;
    }
  }

  //Try reading it, if it reads without any error, there is too much data
  int16_t buffer[width];
  scanCount = fread(buffer, sizeof(int16_t), width, inputFile);

  //Check if there is too much data
  if(scanCount != 0)
  {
    HandleErrors(gtopoData, inputFile, "Bad Data", fileName);
    return BAD_DATA;
  }

	//close files and return 0
  fclose(inputFile);
  return EXIT_NO_ERRORS;
}

int WriteGtopoData(GtopoData *gtopoData, char *fileName)
{
  //read in binary mode
	FILE *outputFile = fopen(fileName, "wb");
  int width = gtopoData->width;
  int height = gtopoData->height;

  //if couldn't open file return error
	if (outputFile == NULL)
	{
    HandleErrors(gtopoData, outputFile, "Bad File Name", fileName);
    return BAD_FILE_NAME;
	}

  //Swap to orignal endian. AKA Big Endian
  SwapImageData(gtopoData->imageData, width, height);

  for (int y = 0; y < height; y++)
  {
    //Write image data as bytes
    long nBytesWritten = fwrite(gtopoData->imageData[y], sizeof(int16_t), width, outputFile);

    //Error with output
    if(nBytesWritten == 0)
    {
        HandleErrors(gtopoData, outputFile, "Output failed", fileName);
        return OUTPUT_FAILED;
    }
  }

	//Close file and return 0
	fclose(outputFile);
  return EXIT_NO_ERRORS;
}

//Return char based on hight level, if error return NULL
char GetMapSymbol(int y, int seaLevel, int hillLevel, int mountainLevel)
{
  //symbols for diffrent height level
  char sea = ' ';
  char ground = '.';
  char hill = '^';
  char mountain = 'A';

  //assign symbol depending by height level
  if(y < seaLevel)
    return sea;
  else if(seaLevel <= y && y < hillLevel)
    return ground;
  else if(hillLevel <= y && y < mountainLevel)
    return hill;
  else if(mountainLevel <= y)
    return mountain;

  //return null if error
  return 0;
}

//Writes 10 base number values with little endian into file
int DrawMap(GtopoData *gtopoData, int seaLevel, int hillLevel, int mountainLevel, char *fileName)
{
  //open file in ASCII mode
	FILE *outputFile = fopen(fileName, "w");
  int width = gtopoData->width;
  int height = gtopoData->height;

  //if can't open file retun error
	if (outputFile == NULL)
	{
    HandleErrors(gtopoData, outputFile, "Bad File Name", fileName);
    return BAD_FILE_NAME;
	}

  //iterate image data
  for (int y = 0; y < height; y++)
  {
    for (int x = 0; x < width; x++)
    {
      //based on height level get symbol
      char mapSymbol = GetMapSymbol(gtopoData->imageData[y][x], seaLevel, hillLevel, mountainLevel);
      long nBytesWritten = 0;

      //If something wronng return error
      if(mapSymbol == 0)
      {
        HandleErrors(gtopoData, outputFile, "Output failed", fileName);
        return OUTPUT_FAILED;
      }

      //Break line if current symbol is the last symbol in that line
      if(x == width - 1)
        nBytesWritten = fprintf(outputFile, "%c%c", mapSymbol, '\n');
      else
        nBytesWritten = fprintf(outputFile, "%c", mapSymbol);

      //Error with output
      if (nBytesWritten < 0)
      {
        HandleErrors(gtopoData, outputFile, "Output failed", fileName);
        return OUTPUT_FAILED;
      }
    }
  }

	//Close file and return 0
	fclose(outputFile);
  return EXIT_NO_ERRORS;
}

//Return bool. False = 0 and True = 1
int IsGtopoDataEqual(GtopoData *data1, GtopoData *data2)
{
	//Compare height, width
	if(data1->height != data2->height)
		return 0;

	if(data1->width != data2->width)
		return 0;

	//Compare imageData
	for (int y = 0; y < data1->height; y++)
	{
		for (int x = 0; x < data1->width; x++)
		{
			if(data1->imageData[y][x] != data2->imageData[y][x])
				return 0;
		}
	}

	//return true
	return 1;
}

//initialises gtopo data
int CreateGtopoData(GtopoData *gtopoData, int width, int height, int16_t **imageData)
{
  //Set  up pgmdata variables
	gtopoData->width = width;
	gtopoData->height = height;

	//Alocate imageData
	int mallocRes = AllocateImageData(&(gtopoData->imageData), width, height);

  //return error if malloc failed
	if (mallocRes == -1)
	{
		return IMAGE_MALLOC_FAILED;
	}

	//Set imageData with given one
	for (int y = 0; y < height; y++)
	{
		for (int x = 0; x < width; x++)
		{
			gtopoData->imageData[y][x] = imageData[y][x];
		}
	}

	return 0;
}

// F - from | T - to | S - Start
void CopyPartOfImageData(int16_t **imageDataFrom, int fSColumn, int fSRow, int16_t **imageDataTo, int tSColumn, int tSRow, int width, int height)
{
  // from row and column length
  int fRowLength = height + fSRow;
	int fColumnLength = width + fSColumn;

  //Alocate buffer to store values
  int16_t **buffer;
  AllocateImageData(&buffer, width, height);

  //Get Data and store to buffer
  for (int y = fSRow; y < fRowLength; y++)
  {
    for (int x = fSColumn; x < fColumnLength; x++)
    {
      buffer[y - fSRow][x - fSColumn] = imageDataFrom[y][x];
    }
  }

  //to row and column length
  int tRowLength = height + tSRow;
  int tColumnLength = width + tSColumn;

  //Set Data to imageDataTo
  for (int y = tSRow; y < tRowLength; y++)
  {
    for (int x = tSColumn; x < tColumnLength; x++)
    {
      imageDataTo[y][x] = buffer[y - tSRow][x - tSColumn];
    }
  }
}

//Allocating for 2D array
int AllocateImageData(int16_t ***buffer, int width, int height)
{
  //alocate buffer
  *buffer = (int16_t**) malloc(height * sizeof(int16_t*));

  for (int i = 0; i < height; i++)
  {
    //alocate space to each element
    (*buffer)[i] = (int16_t*)malloc(width * sizeof(int16_t));

    //if something wrong with malloc return
		if ((*buffer)[i] == NULL)
		{
			return -1;
		}
  }

	return 0;
}
