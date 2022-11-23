//Struct to store arg data for files
typedef struct _ArgAssembleData
{
    unsigned int row;
    unsigned int column;
    unsigned int width;
    unsigned int height;
    char *fileName;
} ArgAssembleData;

int SetAssembleArgData(ArgAssembleData *argData, int index, char **argv);
