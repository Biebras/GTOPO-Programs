#include <stdio.h>
#include <stdlib.h>
#include "gtopo.h"
#include "helpers.h"
#include "exceptionTypes.h"

int main(int argc, char **argv)
{
	//if no arguments, tell how to use
	if(argc == 1)
	{
		printf("Usage: %s inputFile width height outputFile", argv[0]);
		return 0;
	}

	//There should always be 3 arguments, otherwise throw error
	if (argc != 5)
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

	//Read file
	int readReturn = ReadGtopoData(&gtopoData, argv[1]);

	//Return if read throws error
	if(readReturn != 0)
		return readReturn;

	//Write file
	int writeOutput = WriteGtopoData(&gtopoData, argv[4]);

	//Return if write returns error
	if(writeOutput != 0)
		return writeOutput;

	FreeGtopoData(&gtopoData);
	printf("ECHOED\n");
	return ECHOED;
}
