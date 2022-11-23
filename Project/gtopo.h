#define ECHOED 0
#define IDENTICAL 0
#define DIFFERENT 0
#define CONVERTED 0
#define REDUCED 0
#define TILED 0
#define ASSEMBLED 0
#define EXIT_NO_ERRORS 0
#define MAGIC_NUMBER_RAW_PGM 0x3550
#define MAGIC_NUMBER_ASCII_PGM 0x3250
#define MIN_IMAGE_DIMENSION 1
#define MAX_IMAGE_DIMENSION 65536
#define MAX_COMMENT_LINE_LENGTH 128

//struct to store dem data
typedef struct _GtopoData
{
    unsigned int width;
	  unsigned int height;
    int16_t **imageData;
} GtopoData;

//Declare functions
int ReadGtopoData(GtopoData *pgmData, char *fileName);
int WriteGtopoData(GtopoData *pgmData, char *fileName);
int DrawMap(GtopoData *pgmData, int seaLevel, int hillLevel, int mountainLevel, char *fileName);
void HandleErrors(GtopoData *pgmData, FILE *file, char *errorMessage, char *fileName);
void FreeGtopoData(GtopoData *pgmData);
void FreeGtopoDatas(GtopoData *pgmDatas, int length);
void SetUpGtopoDataVariables(GtopoData *pgmData);
int IsGtopoDataEqual(GtopoData *data1, GtopoData *data2);
int AllocateImageData(int16_t ***buffer, int width, int height);
int CreateGtopoData(GtopoData *pgmData, int width, int height, int16_t **imageData);
void CopyPartOfImageData(int16_t **imageDataFrom, int fSColumn, int fSRow, int16_t **imageDataTo, int tSColumn, int tSRow, int width, int height);
