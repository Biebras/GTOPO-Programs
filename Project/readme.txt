How to start:
1. Compile programs by writing in terminal "make all" or if you want to compaile ceperate file "make "program name""
2. Run program in terminal with commands. For example: "./gtopoEcho inputFile width height outputFile"
3. If for some reason you want to clean compile, enter "make clean" in terminal

gtopoEcho:
Purpose: Dublicates GTOPO image.
Usage: ./gtopoEcho inputFile width height outputFile
Input file: gtopo image.
Width: width of image
Height: height of image
Output file: new gtopo image name.

gtopoComp:
Purpose: Compares if two gtopo files are logicaly indentical.
Usage: ./gtopoComp firstFile width height secondFile
Input: gtopo image
Width: width of image
Height: height of image
Output: new gtopo image name

gtopoReduce:
Purpose: Reduce gtopo image by a factor. For example, if the invocation is: gtopoReduce inputFile 5 outputFile and inputFile is a 13x17 image, then outputFile should be a 2x3 image in which only the pixels with row and column of 0 modulo 5 in the inputFile exist.
Usage: ./gtopoReduce input width height reduction_factor output
Input: gtopo image
Width: width of image
Height: height of image
reduction Factor: some positive integer
Output: new gtopo image

gtopoTile:
Purpose: Divides the input file into nxn smaller images corresponding to parts of the image.
Usage: ./gtopoTile inputFile width height tiling_factor outputFile_<row>_<column>
Input: gtopo image, tiling factor
Width: width of image
Height: height of image
Tiling factor: some positive integer
Output: nxn new smaller gtopo images

gtopoAssemble:
Purpose: Assemble a large image from smaller ones.
Usage: ./gtopoAssemble outputFile width height (row column inputFile width height)+
Input: width, height, (row column gtopo image) * n
Width: width of image
Height: height of image
Output: new gtopo image

gtopoPrintLand:
Purpose: Draw map from height values.
Usage:  ./gtopoPrintLand inputFile width height outputFile sea hill mountain
Input: gtopo image
Width: width of image
Height: height of image
Output: new gtopo image
Sea: enter sea level
Hill: enter hill level
Mountain: enter mountain level

gtopoAssembleReduce:
Purpose: Assemble a large image from smaller ones, reduce it and write reduced version to new file
Usage: ./gtopoAssembleReduce outputArray.gtopo width height reduction_factor (row column inputArray.gtopo width height)+
Input: width, height, (row column gtopo image) * n
Width: width of image
Height: height of image
Output: new gtopo image
