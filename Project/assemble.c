#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include "gtopo.h"
#include "helpers.h"
#include "assemble.h"
#include "exceptionTypes.h"

int SetAssembleArgData(ArgAssembleData *argData, int index, char **argv)
{
    //Store each tile indexes
    int rowIndex = index;
    int columnIndex = index + 1;
    int fileIndex = index + 2;
    int widthIndex = index + 3;
    int heightIndex = index + 4;

    //Converts args to int and store there endPtr to look for errors
    int row = StringToPosInt(argv[rowIndex]);
    int col = StringToPosInt(argv[columnIndex]);
    int width = StringToPosInt(argv[widthIndex]);
    int height = StringToPosInt(argv[heightIndex]);

    //allocates and assignes file name from args
    char *name = (char *)malloc(sizeof(char) * strlen(argv[fileIndex]));
    name = argv[fileIndex];

    //Check for errors in strtol
    if(row == -1 || col == -1)
      return BAD_LAYOUT;

    if (width == -1 || height == -1)
      return BAD_LAYOUT;

    //assignes row col and file name
    argData->row = row;
    argData->column = col;
    argData->fileName = name;
    argData->width = width;
    argData->height = height;

    return 0;
}
