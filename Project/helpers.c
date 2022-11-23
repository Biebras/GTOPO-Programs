#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include "exceptionTypes.h"

// Swaps bytes between big endian and little endian
int16_t Swap16bit(int16_t val)
{
    return (val << 8) | ((val >> 8) & 0xFF);
}

//Rounds up number to upper bounds
int RoundUp(double value)
{
    //rounds value to lower bounds
    int roundValue = (int)value;
    //takes diffrence from rounded and original value
    double diff = value - (double)roundValue;

    // if no diffrence return original value
    if(diff == 0)
        return roundValue;

    //add 1 to return upper bounds
    return roundValue + 1;
}

//Replace strings substring wit given replacement
int ReplaceString(char *str, char *find, char *replace)
{
  //get substring
	char *subStr = strstr(str, find);

  //return if substring does not exit
	if(subStr == NULL)
			return MISCELLANEOUS;

	//Move memory to have some space for replacement
	memmove(subStr + strlen(replace), subStr + strlen(find), strlen(subStr) - strlen(find) + 1);
	//Copy string
	memcpy(subStr, replace, strlen(replace));

	return 0;
}

//Takes int and returns pos integer.
//Negative integers represent errors.
//If string can't be converted return -1
int StringToPosInt(char * text)
{
  // ptr to catch errors
  char *numberPtr;
  // convert string to int
  int number = strtol(text, &numberPtr, 10);

  //if error return -1 and set errno
  if(numberPtr == text)
  {
    errno = -1;
    return -1;
  }

  return number;
}
