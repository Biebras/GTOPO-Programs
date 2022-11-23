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
  		printf("Usage: %s firstFile width height secondFile", argv[0]);
  		return 0;
  	}

    //check if usage is correct
  	if (argc != 5)
  	{
  		HandleErrors(NULL, NULL, "Bad Argument Count", NULL);
  		return EXIT_WRONG_ARG_COUNT;
  	}

    GtopoData gtopoData1;
    GtopoData gtopoData2;

    //Changing string to integers
    int width = StringToPosInt(argv[2]);
    int height = StringToPosInt(argv[3]);

    gtopoData1.width = width;
    gtopoData1.height = height;

    gtopoData2.width = width;
    gtopoData2.height = height;

    //read files
    int readReturn1 = ReadGtopoData(&gtopoData1, argv[1]);

    //check if read return error
    if(readReturn1 != 0)
        return readReturn1;

    int readReturn2 = ReadGtopoData(&gtopoData2, argv[4]);

    //check if read return error
    if(readReturn2 != 0)
    {
        FreeGtopoData(&gtopoData1);
        return readReturn2;
    }

    //compare
    int equal = IsGtopoDataEqual(&gtopoData1, &gtopoData2);

    if(equal)
        printf("IDENTICAL\n");
    else
        printf("DIFFERENT\n");

    FreeGtopoData(&gtopoData1);
    FreeGtopoData(&gtopoData2);
    return IDENTICAL;
}
