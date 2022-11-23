#!/bin/bash

#Color Macros
NC='\033[0m' #No color
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

#Path Macros
GTOPO30='/vol/scratch/SoC/COMP1921/GTOPO30'
PROJECTFILES='/vol/scratch/SoC/COMP1921/COMP1921A2_handout'

echo "Cleaning and generating new files for compiling"
make all

testsPassed=0
totalTests=0

echo
echo "**********************************************************"
echo gtopoPrintLand
echo "**********************************************************"
echo
echo "=========================================================="
echo "Step 1: Tile image with factor 20"
((totalTests=totalTests+1))
./gtopoTile $GTOPO30/gt30w020n90_dem/gt30w020n90.dem 4800 6000 20 "_Pictures/atlantic/uk_<row>_<column>.dem"

./gtopoTile ./_Pictures/atlantic/uk_11_12.dem 240 300 2 "_Pictures/atlantic/11_12_uk_<row>_<column>.dem"
./gtopoTile ./_Pictures/atlantic/uk_12_12.dem 240 300 2 "_Pictures/atlantic/12_12_uk_<row>_<column>.dem"
./gtopoTile ./_Pictures/atlantic/uk_13_12.dem 240 300 2 "_Pictures/atlantic/13_12_uk_<row>_<column>.dem"
./gtopoTile ./_Pictures/atlantic/uk_14_12.dem 240 300 2 "_Pictures/atlantic/14_12_uk_<row>_<column>.dem"
./gtopoTile ./_Pictures/atlantic/uk_15_12.dem 240 300 2 "_Pictures/atlantic/15_12_uk_<row>_<column>.dem"
./gtopoTile ./_Pictures/atlantic/uk_16_12.dem 240 300 2 "_Pictures/atlantic/16_12_uk_<row>_<column>.dem"
out=$?
echo
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoTile returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoTile returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "Step 2: Assemble needed tiles and reduce"
((totalTests=totalTests+1))
./gtopoAssemble ./_Pictures/atlantic/uk_11_12.dem 120 300 0 0 _Pictures/atlantic/11_12_uk_0_0.dem 120 150 150 0 _Pictures/atlantic/11_12_uk_1_0.dem 120 150
./gtopoAssemble ./_Pictures/atlantic/uk_12_12.dem 120 300 0 0 _Pictures/atlantic/12_12_uk_0_0.dem 120 150 150 0 _Pictures/atlantic/12_12_uk_1_0.dem 120 150
./gtopoAssemble ./_Pictures/atlantic/uk_13_12.dem 120 300 0 0 _Pictures/atlantic/13_12_uk_0_0.dem 120 150 150 0 _Pictures/atlantic/13_12_uk_1_0.dem 120 150
./gtopoAssemble ./_Pictures/atlantic/uk_14_12.dem 120 300 0 0 _Pictures/atlantic/14_12_uk_0_0.dem 120 150 150 0 _Pictures/atlantic/14_12_uk_1_0.dem 120 150
./gtopoAssemble ./_Pictures/atlantic/uk_15_12.dem 120 300 0 0 _Pictures/atlantic/15_12_uk_0_0.dem 120 150 150 0 _Pictures/atlantic/15_12_uk_1_0.dem 120 150
./gtopoAssemble ./_Pictures/atlantic/uk_16_12.dem 120 300 0 0 _Pictures/atlantic/16_12_uk_0_0.dem 120 150 150 0 _Pictures/atlantic/16_12_uk_1_0.dem 120 150

./gtopoAssembleReduce _Pictures/atlantic/_uk_assembled.dem 1800 1800 25 0 0 _Pictures/atlantic/uk_11_5.dem 240 300 0 240 _Pictures/atlantic/uk_11_6.dem 240 300 0 480 _Pictures/atlantic/uk_11_7.dem 240 300 0 720 _Pictures/atlantic/uk_11_8.dem 240 300 0 960 _Pictures/atlantic/uk_11_9.dem 240 300 0 1200 _Pictures/atlantic/uk_11_10.dem 240 300 0 1440 _Pictures/atlantic/uk_11_11.dem 240 300 0 1680 _Pictures/atlantic/uk_11_12.dem 120 300 300 0 _Pictures/atlantic/uk_12_5.dem 240 300 300 240 _Pictures/atlantic/uk_12_6.dem 240 300 300 480 _Pictures/atlantic/uk_12_7.dem 240 300 300 720 _Pictures/atlantic/uk_12_8.dem 240 300 300 960 _Pictures/atlantic/uk_12_9.dem 240 300 300 1200 _Pictures/atlantic/uk_12_10.dem 240 300 300 1440 _Pictures/atlantic/uk_12_11.dem 240 300 300 1680 _Pictures/atlantic/uk_12_12.dem 120 300 600 0 _Pictures/atlantic/uk_13_5.dem 240 300 600 240 _Pictures/atlantic/uk_13_6.dem 240 300 600 480 _Pictures/atlantic/uk_13_7.dem 240 300 600 720 _Pictures/atlantic/uk_13_8.dem 240 300 600 960 _Pictures/atlantic/uk_13_9.dem 240 300 600 1200 _Pictures/atlantic/uk_13_10.dem 240 300 600 1440 _Pictures/atlantic/uk_13_11.dem 240 300 600 1680 _Pictures/atlantic/uk_13_12.dem 120 300 900 0 _Pictures/atlantic/uk_14_5.dem 240 300 900 240 _Pictures/atlantic/uk_14_6.dem 240 300 900 480 _Pictures/atlantic/uk_14_7.dem 240 300 900 720 _Pictures/atlantic/uk_14_8.dem 240 300 900 960 _Pictures/atlantic/uk_14_9.dem 240 300 900 1200 _Pictures/atlantic/uk_14_10.dem 240 300 900 1440 _Pictures/atlantic/uk_14_11.dem 240 300 900 1680 _Pictures/atlantic/uk_14_12.dem 120 300 1200 0 _Pictures/atlantic/uk_15_5.dem 240 300 1200 240 _Pictures/atlantic/uk_15_6.dem 240 300 1200 480 _Pictures/atlantic/uk_15_7.dem 240 300 1200 720 _Pictures/atlantic/uk_15_8.dem 240 300 1200 960 _Pictures/atlantic/uk_15_9.dem 240 300 1200 1200 _Pictures/atlantic/uk_15_10.dem 240 300 1200 1440 _Pictures/atlantic/uk_15_11.dem 240 300 1200 1680 _Pictures/atlantic/uk_15_12.dem 120 300 1500 0 _Pictures/atlantic/uk_16_5.dem 240 300 1500 240 _Pictures/atlantic/uk_16_6.dem 240 300 1500 480 _Pictures/atlantic/uk_16_7.dem 240 300 1500 720 _Pictures/atlantic/uk_16_8.dem 240 300 1500 960 _Pictures/atlantic/uk_16_9.dem 240 300 1500 1200 _Pictures/atlantic/uk_16_10.dem 240 300 1500 1440 _Pictures/atlantic/uk_16_11.dem 240 300 1500 1680 _Pictures/atlantic/uk_16_12.dem 120 300
echo
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoAssemble returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoAssemble returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "Step 3: Draw map YAY"
((totalTests=totalTests+1))
./gtopoPrintLand _Pictures/atlantic/_uk_assembled.dem 72 72 _Pictures/atlantic/map.dem 64 121 886
out=$?
echo
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoPrintLand returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoPrintLand returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "Step 4: Draw map compare with result"
((totalTests=totalTests+1))
diff $PROJECTFILES/atlantic_isles_target.txt _Pictures/atlantic/map.dem
out=$?
echo
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => diff returned $out"
else
    echo -e "${RED}FAILED${NC} => diff returned $out"
fi
echo "=========================================================="

echo
echo "${testsPassed}/$totalTests tests passed"
echo
make clean
find ./_Pictures/atlantic ! -name 'map.dem' -type f -exec rm -f {} +
