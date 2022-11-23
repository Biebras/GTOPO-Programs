#!/bin/bash

#Color Macros
NC='\033[0m' #No color
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

#Path Macros
GTOPO30='/vol/scratch/SoC/COMP1921/GTOPO30'
TESTDEMS='/vol/scratch/SoC/COMP1921/COMP1921A2_handout/dems'

echo "Cleaning and generating new files for compiling"
make all

testsPassed=0
totalTests=0

echo
echo "**********************************************************"
echo gtopoEcho
echo "**********************************************************"
echo
echo "=========================================================="
echo "gtopoEcho usage"
((totalTests=totalTests+1))
./gtopoEcho
out=$?
echo
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoEcho returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoEcho returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoEcho wrong # of parameters"
((totalTests=totalTests+1))
./gtopoEcho asdasd asdasda
out=$?
echo
expected=1
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoEcho returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoEcho returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoEcho bad file name"
((totalTests=totalTests+1))
./gtopoEcho $TESTDEMS/gtdem 20 10 _Pictures/echo/result.dem
out=$?
echo
expected=2
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoEcho returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoEcho returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoEcho bad dimensions (-1)"
((totalTests=totalTests+1))
./gtopoEcho $TESTDEMS/gtopo_reduced_0_0.dem -1 10 _Pictures/echo/result.dem
out=$?
echo
expected=5
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoEcho returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoEcho returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoEcho too much data"
((totalTests=totalTests+1))
./gtopoEcho $TESTDEMS/gtopo_reduced_0_0.dem 100 10 _Pictures/echo/result.dem
out=$?
echo
expected=8
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoEcho returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoEcho returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoEcho too little data"
((totalTests=totalTests+1))
./gtopoEcho $TESTDEMS/gtopo_reduced_0_0.dem 5 10 _Pictures/echo/result.dem
out=$?
echo
expected=8
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoEcho returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoEcho returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoEcho bad width"
((totalTests=totalTests+1))
./gtopoEcho $TESTDEMS/gtopo_reduced_9_9.dem 2a0 10 _Pictures/echo/result.dem
out=$?
echo
expected=8
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoEcho returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoEcho returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoEcho succsses"
((totalTests=totalTests+1))
./gtopoEcho $TESTDEMS/gtopo_reduced_9_9.dem 20 10 _Pictures/echo/result.dem
out=$?
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoEcho returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoEcho returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoEcho succsses compare"
((totalTests=totalTests+1))
./gtopoComp $TESTDEMS/gtopo_reduced_9_9.dem 20 10 _Pictures/echo/result.dem
out=$?
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoEcho returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoEcho returned $out"
fi
echo
echo "=========================================================="
echo
echo "**********************************************************"
echo gtopoComp
echo "**********************************************************"
echo
echo "=========================================================="
echo "gtopoComp usage"
((totalTests=totalTests+1))
./gtopoComp
out=$?
echo
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoComp returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoComp returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoComp wrong # of parameters"
((totalTests=totalTests+1))
./gtopoComp asdasd asdasda
out=$?
echo
expected=1
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoComp returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoComp returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoComp bad file name"
((totalTests=totalTests+1))
./gtopoComp $TESTDEMS/gtdem 20 10 _Pictures/echo/result.dem
out=$?
echo
expected=2
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoComp returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoComp returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoComp bad dimensions (-1)"
((totalTests=totalTests+1))
./gtopoComp $TESTDEMS/gtopo_reduced_0_0.dem -1 10 _Pictures/echo/result.dem
out=$?
echo
expected=5
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoComp returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoComp returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoComp too much data"
((totalTests=totalTests+1))
./gtopoComp $TESTDEMS/gtopo_reduced_0_0.dem 100 10 _Pictures/echo/result.dem
out=$?
echo
expected=8
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoComp returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoComp returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoComp too little data"
((totalTests=totalTests+1))
./gtopoComp $TESTDEMS/gtopo_reduced_0_0.dem 5 10 _Pictures/echo/result.dem
out=$?
echo
expected=8
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoComp returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoComp returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoEcho bad width"
((totalTests=totalTests+1))
./gtopoComp $TESTDEMS/gtopo_reduced_9_9.dem 2a0 10 _Pictures/echo/result.dem
out=$?
echo
expected=8
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoComp returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoComp returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoComp succsses"
((totalTests=totalTests+1))
./gtopoComp $TESTDEMS/gtopo_reduced_9_9.dem 20 10 $TESTDEMS/gtopo_reduced_9_9.dem
out=$?
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoComp returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoComp returned $out"
fi
echo
echo "=========================================================="
echo
echo "**********************************************************"
echo gtopoReduce
echo "**********************************************************"
echo
echo "=========================================================="
echo "gtopoReduce usage"
((totalTests=totalTests+1))
./gtopoReduce
out=$?
echo
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoReduce wrong # of parameters"
((totalTests=totalTests+1))
./gtopoReduce asdasd asdasda
out=$?
echo
expected=1
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoReduce bad file name"
((totalTests=totalTests+1))
./gtopoReduce $TESTDEMS/gtdem 20 10 6 _Pictures/reduce/result.dem
out=$?
echo
expected=2
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoReduce bad dimensions (-1)"
((totalTests=totalTests+1))
./gtopoReduce $TESTDEMS/gtopo_reduced_0_0.dem -1 10 6 _Pictures/echo/result.dem
out=$?
echo
expected=5
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoReduce too much data"
((totalTests=totalTests+1))
./gtopoReduce $TESTDEMS/gtopo_reduced_0_0.dem 100 10 5 _Pictures/echo/result.dem
out=$?
echo
expected=8
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoReduce too little data"
((totalTests=totalTests+1))
./gtopoReduce $TESTDEMS/gtopo_reduced_0_0.dem 5 10 8 _Pictures/echo/result.dem
out=$?
echo
expected=8
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoReduce bad width"
((totalTests=totalTests+1))
./gtopoReduce $TESTDEMS/gtopo_reduced_9_9.dem 2a0 10 8 _Pictures/echo/result.dem
out=$?
echo
expected=8
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoReduce bad factor"
((totalTests=totalTests+1))
./gtopoReduce $TESTDEMS/gtopo_reduced_9_9.dem 20 10 0 _Pictures/reduce/result.dem
out=$?
echo
expected=100
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoReduce succsses"
((totalTests=totalTests+1))
./gtopoReduce $TESTDEMS/gtopo_reduced_9_9.dem 20 10 5 _Pictures/reduce/result.dem
out=$?
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "**********************************************************"
echo gtopoTile
echo "**********************************************************"
echo
echo "=========================================================="
echo "gtopoTile usage"
((totalTests=totalTests+1))
./gtopoTile
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
echo "gtopoTile wrong # of parameters"
((totalTests=totalTests+1))
./gtopoTile asdasd asdasda
out=$?
echo
expected=1
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
echo "gtopoTile bad file name"
((totalTests=totalTests+1))
./gtopoTile $TESTDEMS/gtdem 20 10 2 _Pictures/echo/result.dem
out=$?
echo
expected=2
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
echo "gtopoTile bad dimensions (-1)"
((totalTests=totalTests+1))
./gtopoTile $TESTDEMS/gtopo_reduced_0_0.dem -1 10 10 _Pictures/echo/result.dem
out=$?
echo
expected=5
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
echo "gtopoTile too much data"
((totalTests=totalTests+1))
./gtopoTile $TESTDEMS/gtopo_reduced_0_0.dem 100 10 2 _Pictures/echo/result.dem
out=$?
echo
expected=8
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
echo "gtopoTile too little data"
((totalTests=totalTests+1))
./gtopoTile $TESTDEMS/gtopo_reduced_0_0.dem 5 10 2 _Pictures/echo/result.dem
out=$?
echo
expected=8
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
echo "gtopoTile bad width"
((totalTests=totalTests+1))
./gtopoTile $TESTDEMS/gtopo_reduced_9_9.dem 2a0 10 2 _Pictures/echo/result.dem
out=$?
echo
expected=8
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
echo "gtopoTile succsses"
((totalTests=totalTests+1))
./gtopoTile $TESTDEMS/gtopo30full_reduced_216.dem 200 100 2 "_Pictures/tile/2result_<row>_<column>.dem"
out=$?
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
echo "gtopoTile succsses"
((totalTests=totalTests+1))
./gtopoTile $TESTDEMS/gtopo30full_reduced_216.dem 200 100 10 "_Pictures/tile/10result_<row>_<column>.dem"
out=$?
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
echo "gtopoTile compare (0_0)"
((totalTests=totalTests+1))
./gtopoComp $TESTDEMS/gtopo_reduced_0_0.dem 20 10 _Pictures/tile/10result_0_0.dem
out=$?
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
echo "gtopoTile compare (1_2)"
((totalTests=totalTests+1))
./gtopoComp $TESTDEMS/gtopo_reduced_1_2.dem 20 10 _Pictures/tile/10result_1_2.dem
out=$?
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
echo "**********************************************************"
echo gtopoAssemble
echo "**********************************************************"
echo
echo "=========================================================="
echo "gtopoAssemble usage"
((totalTests=totalTests+1))
./gtopoAssemble
out=$?
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
echo "gtopoAssemble wrong # of parameters"
((totalTests=totalTests+1))
./gtopoAssemble asdasd asdasda
out=$?
echo
expected=1
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
echo "gtopoAssemble bad file name"
((totalTests=totalTests+1))
./gtopoAssemble _Pictures/assemble/2result.dem 200 100 0 0 _Pictures/tile/2result_0_0.dem 100 50 0 100 _Pictures/tile/2result_0_1.dem 100 50 50 0 _Pi/tile/2result_1_0.dem 100 50 50 100 _Pictures/tile/2result_1_1.dem 100 50
out=$?
echo
expected=2
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
echo "gtopoAssemble bad dimensions (-1)"
((totalTests=totalTests+1))
./gtopoAssemble _Pictures/assemble/2result.dem 200 100 0 0 _Pictures/tile/2result_0_0.dem 100 50 0 100 _Pictures/tile/2result_0_1.dem -1 50 50 0 _Pictures/tile/2result_1_0.dem 100 50 50 100 _Pictures/tile/2result_1_1.dem 100 50
out=$?
echo
expected=10
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
echo "gtopoAssemble too much data"
((totalTests=totalTests+1))
./gtopoAssemble _Pictures/assemble/2result.dem 200 100 0 0 _Pictures/tile/2result_0_0.dem 100 50 0 100 _Pictures/tile/2result_0_1.dem 400 50 50 0 _Pictures/tile/2result_1_0.dem 100 50 50 100 _Pictures/tile/2result_1_1.dem 100 50
out=$?
echo
expected=8
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
echo "gtopoAssemble too little data"
((totalTests=totalTests+1))
./gtopoAssemble _Pictures/assemble/2result.dem 200 100 0 0 _Pictures/tile/2result_0_0.dem 100 50 0 100 _Pictures/tile/2result_0_1.dem 3 50 50 0 _Pictures/tile/2result_1_0.dem 100 50 50 100 _Pictures/tile/2result_1_1.dem 100 50
out=$?
echo
expected=8
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
echo "gtopoAssemble bad width"
((totalTests=totalTests+1))
./gtopoAssemble _Pictures/assemble/2result.dem 200 100 0 0 _Pictures/tile/2result_0_0.dem 100 50 0 100 _Pictures/tile/2result_0_1.dem 33a 50 50 0 _Pictures/tile/2result_1_0.dem 100 50 50 100 _Pictures/tile/2result_1_1.dem 100 50
out=$?
echo
expected=8
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
echo "gtopoAssemble succsses"
((totalTests=totalTests+1))
./gtopoAssemble _Pictures/assemble/2result.dem 200 100 0 0 _Pictures/tile/2result_0_0.dem 100 50 0 100 _Pictures/tile/2result_0_1.dem 100 50 50 0 _Pictures/tile/2result_1_0.dem 100 50 50 100 _Pictures/tile/2result_1_1.dem 100 50
out=$?
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
echo "gtopoAssemble compare"
((totalTests=totalTests+1))
./gtopoComp _Pictures/assemble/2result.dem 200 100 $TESTDEMS/gtopo30full_reduced_216.dem
out=$?
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
echo "**********************************************************"
echo gtopoPrintLand
echo "**********************************************************"
echo
echo "=========================================================="
echo "gtopoPrintLand usage"
((totalTests=totalTests+1))
./gtopoPrintLand
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
echo "gtopoPrintLand wrong # of parameters"
((totalTests=totalTests+1))
./gtopoPrintLand asdasd asdasda
out=$?
echo
expected=1
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
echo "gtopoPrintLand bad file name"
((totalTests=totalTests+1))
./gtopoPrintLand $TESTDEMS/gtopo_reducd_2_5.em 20 10 ./_Pictures/print/result.dem 50 300 600
out=$?
echo
expected=2
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
echo "gtopoPrintLand bad dimensions (-1)"
((totalTests=totalTests+1))
./gtopoPrintLand $TESTDEMS/gtopo_reduced_2_5.dem -1 10 ./_Pictures/print/result.dem 50 300 600
out=$?
echo
expected=5
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
echo "gtopoPrintLand too much data"
((totalTests=totalTests+1))
./gtopoPrintLand $TESTDEMS/gtopo_reduced_2_5.dem 200 100 ./_Pictures/print/result.dem 50 300 600
out=$?
echo
expected=8
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
echo "gtopoPrintLand too little data"
((totalTests=totalTests+1))
./gtopoPrintLand $TESTDEMS/gtopo_reduced_2_5.dem 5 10 ./_Pictures/print/result.dem 50 300 600
out=$?
echo
expected=8
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
echo "gtopoPrintLand bad width"
((totalTests=totalTests+1))
./gtopoPrintLand $TESTDEMS/gtopo_reduced_2_5.dem 2sd0ss 10 ./_Pictures/print/result.dem 50 300 600
out=$?
echo
expected=8
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
echo "gtopoPrintLand bad sea Level"
((totalTests=totalTests+1))
./gtopoPrintLand $TESTDEMS/gtopo_reduced_2_5.dem 20 10 ./_Pictures/print/result.dem asdasd50 300 600
out=$?
echo
expected=100
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
echo "gtopoPrintLand succsses"
((totalTests=totalTests+1))
./gtopoPrintLand $TESTDEMS/gtopo_reduced_2_5.dem 20 10 ./_Pictures/print/result.dem 50 300 600
out=$?
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
echo "gtopoPrintLand succsses compare"
((totalTests=totalTests+1))
diff ./_Pictures/print/comp.dem ./_Pictures/print/result.dem
out=$?
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => diff returned $out"
else
    echo -e "${RED}FAILED${NC} => diff returned $out"
fi
echo
echo "**********************************************************"
echo gtopoAssembleReduce
echo "**********************************************************"
echo
echo "=========================================================="
echo "gtopoAssembleReduce usage"
((totalTests=totalTests+1))
./gtopoAssembleReduce
out=$?
echo
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoAssembleReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoAssembleReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoAssembleReduce wrong # of parameters"
((totalTests=totalTests+1))
./gtopoAssembleReduce asdasd asdasda
out=$?
echo
expected=1
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoAssembleReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoAssembleReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoAssembleReduce bad file name"
((totalTests=totalTests+1))
./gtopoAssembleReduce	./_Pictures/assembleReduce/gtopo30full_reduced_400.dem	43200	21600	400		0		0		$GTOPO30/gt30w180n90_de0n90.dem	4800	6000	0		4800	$GTOPO30/gt30w140n90_dem/gt30w140n90.dem	4800	6000	0		9600	$GTOPO30/gt30w100n90_dem/gt30w100n90.dem	4800	6000	0		14400	$GTOPO30/gt30w060n90_dem/gt30w060n90.dem	4800	6000	0		19200	$GTOPO30/gt30w020n90_dem/gt30w020n90.dem	4800	6000	0		24000	$GTOPO30/gt30e020n90_dem/gt30e020n90.dem	4800	6000	0		28800	$GTOPO30/gt30e060n90_dem/gt30e060n90.dem	4800	6000	0		33600	$GTOPO30/gt30e100n90_dem/gt30e100n90.dem	4800	6000	0		38400	$GTOPO30/gt30e140n90_dem/gt30e140n90.dem	4800	6000	6000	0		$GTOPO30/gt30w180n40_dem/gt30w180n40.dem	4800	6000	6000	4800	$GTOPO30/gt30w140n40_dem/gt30w140n40.dem	4800	6000	6000	9600	$GTOPO30/gt30w100n40_dem/gt30w100n40.dem	4800	6000	6000	14400	$GTOPO30/gt30w060n40_dem/gt30w060n40.dem	4800	6000	6000	19200	$GTOPO30/gt30w020n40_dem/gt30w020n40.dem	4800	6000	6000	24000	$GTOPO30/gt30e020n40_dem/gt30e020n40.dem	4800	6000	6000	28800	$GTOPO30/gt30e060n40_dem/gt30e060n40.dem	4800	6000	6000	33600	$GTOPO30/gt30e100n40_dem/gt30e100n40.dem	4800	6000	6000	38400	$GTOPO30/gt30e140n40_dem/gt30e140n40.dem	4800	6000	12000	0		$GTOPO30/gt30w180s10_dem/gt30w180s10.dem	4800	6000	12000	4800	$GTOPO30/gt30w140s10_dem/gt30w140s10.dem	4800	6000	12000	9600	$GTOPO30/gt30w100s10_dem/gt30w100s10.dem	4800	6000	12000	14400	$GTOPO30/gt30w060s10_dem/gt30w060s10.dem	4800	6000	12000	19200	$GTOPO30/gt30w020s10_dem/gt30w020s10.dem	4800	6000	12000	24000	$GTOPO30/gt30e020s10_dem/gt30e020s10.dem	4800	6000	12000	28800	$GTOPO30/gt30e060s10_dem/gt30e060s10.dem	4800	6000	12000	33600	$GTOPO30/gt30e100s10_dem/gt30e100s10.dem	4800	6000	12000	38400	$GTOPO30/gt30e140s10_dem/gt30e140s10.dem	4800	6000	18000	0		$GTOPO30/gt30w180s60_dem/gt30w180s60.dem	7200	3600	18000	7200	$GTOPO30/gt30w120s60_dem/gt30w120s60.dem	7200	3600	18000	14400	$GTOPO30/gt30w060s60_dem/gt30w060s60.dem	7200	3600	18000	21600	$GTOPO30/gt30w000s60_dem/gt30w000s60.dem	7200	3600	18000	28800	$GTOPO30/gt30e060s60_dem/gt30e060s60.dem	7200	3600	18000	36000	$GTOPO30/gt30e120s60_dem/gt30e120s60.dem	7200	3600
out=$?
echo
expected=2
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoAssembleReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoAssembleReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoAssembleReduce bad dimensions (-1)"
((totalTests=totalTests+1))
./gtopoAssembleReduce	./_Pictures/assembleReduce/gtopo30full_reduced_400.dem	43200	21600	400		0		0		$GTOPO30/gt30w180n90_dem/gt30w180n90.dem	4800	6000	0		4800	$GTOPO30/gt30w140n90_dem/gt30w140n90.dem	4800	6000	0		9600	$GTOPO30/gt30w100n90_dem/gt30w100n90.dem	-1	6000	0		14400	$GTOPO30/gt30w060n90_dem/gt30w060n90.dem	4800	6000	0		19200	$GTOPO30/gt30w020n90_dem/gt30w020n90.dem	4800	6000	0		24000	$GTOPO30/gt30e020n90_dem/gt30e020n90.dem	4800	6000	0		28800	$GTOPO30/gt30e060n90_dem/gt30e060n90.dem	4800	6000	0		33600	$GTOPO30/gt30e100n90_dem/gt30e100n90.dem	4800	6000	0		38400	$GTOPO30/gt30e140n90_dem/gt30e140n90.dem	4800	6000	6000	0		$GTOPO30/gt30w180n40_dem/gt30w180n40.dem	4800	6000	6000	4800	$GTOPO30/gt30w140n40_dem/gt30w140n40.dem	4800	6000	6000	9600	$GTOPO30/gt30w100n40_dem/gt30w100n40.dem	4800	6000	6000	14400	$GTOPO30/gt30w060n40_dem/gt30w060n40.dem	4800	6000	6000	19200	$GTOPO30/gt30w020n40_dem/gt30w020n40.dem	4800	6000	6000	24000	$GTOPO30/gt30e020n40_dem/gt30e020n40.dem	4800	6000	6000	28800	$GTOPO30/gt30e060n40_dem/gt30e060n40.dem	4800	6000	6000	33600	$GTOPO30/gt30e100n40_dem/gt30e100n40.dem	4800	6000	6000	38400	$GTOPO30/gt30e140n40_dem/gt30e140n40.dem	4800	6000	12000	0		$GTOPO30/gt30w180s10_dem/gt30w180s10.dem	4800	6000	12000	4800	$GTOPO30/gt30w140s10_dem/gt30w140s10.dem	4800	6000	12000	9600	$GTOPO30/gt30w100s10_dem/gt30w100s10.dem	4800	6000	12000	14400	$GTOPO30/gt30w060s10_dem/gt30w060s10.dem	4800	6000	12000	19200	$GTOPO30/gt30w020s10_dem/gt30w020s10.dem	4800	6000	12000	24000	$GTOPO30/gt30e020s10_dem/gt30e020s10.dem	4800	6000	12000	28800	$GTOPO30/gt30e060s10_dem/gt30e060s10.dem	4800	6000	12000	33600	$GTOPO30/gt30e100s10_dem/gt30e100s10.dem	4800	6000	12000	38400	$GTOPO30/gt30e140s10_dem/gt30e140s10.dem	4800	6000	18000	0		$GTOPO30/gt30w180s60_dem/gt30w180s60.dem	7200	3600	18000	7200	$GTOPO30/gt30w120s60_dem/gt30w120s60.dem	7200	3600	18000	14400	$GTOPO30/gt30w060s60_dem/gt30w060s60.dem	7200	3600	18000	21600	$GTOPO30/gt30w000s60_dem/gt30w000s60.dem	7200	3600	18000	28800	$GTOPO30/gt30e060s60_dem/gt30e060s60.dem	7200	3600	18000	36000	$GTOPO30/gt30e120s60_dem/gt30e120s60.dem	7200	3600
out=$?
echo
expected=10
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoAssembleReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoAssembleReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoAssembleReduce too much data"
((totalTests=totalTests+1))
./gtopoAssembleReduce	./_Pictures/assembleReduce/gtopo30full_reduced_400.dem	43200	21600	400		0		0		$GTOPO30/gt30w180n90_dem/gt30w180n90.dem	48000	6000	0		4800	$GTOPO30/gt30w140n90_dem/gt30w140n90.dem	4800	6000	0		9600	$GTOPO30/gt30w100n90_dem/gt30w100n90.dem	4800	6000	0		14400	$GTOPO30/gt30w060n90_dem/gt30w060n90.dem	4800	6000	0		19200	$GTOPO30/gt30w020n90_dem/gt30w020n90.dem	4800	6000	0		24000	$GTOPO30/gt30e020n90_dem/gt30e020n90.dem	4800	6000	0		28800	$GTOPO30/gt30e060n90_dem/gt30e060n90.dem	4800	6000	0		33600	$GTOPO30/gt30e100n90_dem/gt30e100n90.dem	4800	6000	0		38400	$GTOPO30/gt30e140n90_dem/gt30e140n90.dem	4800	6000	6000	0		$GTOPO30/gt30w180n40_dem/gt30w180n40.dem	4800	6000	6000	4800	$GTOPO30/gt30w140n40_dem/gt30w140n40.dem	4800	6000	6000	9600	$GTOPO30/gt30w100n40_dem/gt30w100n40.dem	4800	6000	6000	14400	$GTOPO30/gt30w060n40_dem/gt30w060n40.dem	4800	6000	6000	19200	$GTOPO30/gt30w020n40_dem/gt30w020n40.dem	4800	6000	6000	24000	$GTOPO30/gt30e020n40_dem/gt30e020n40.dem	4800	6000	6000	28800	$GTOPO30/gt30e060n40_dem/gt30e060n40.dem	4800	6000	6000	33600	$GTOPO30/gt30e100n40_dem/gt30e100n40.dem	4800	6000	6000	38400	$GTOPO30/gt30e140n40_dem/gt30e140n40.dem	4800	6000	12000	0		$GTOPO30/gt30w180s10_dem/gt30w180s10.dem	4800	6000	12000	4800	$GTOPO30/gt30w140s10_dem/gt30w140s10.dem	4800	6000	12000	9600	$GTOPO30/gt30w100s10_dem/gt30w100s10.dem	4800	6000	12000	14400	$GTOPO30/gt30w060s10_dem/gt30w060s10.dem	4800	6000	12000	19200	$GTOPO30/gt30w020s10_dem/gt30w020s10.dem	4800	6000	12000	24000	$GTOPO30/gt30e020s10_dem/gt30e020s10.dem	4800	6000	12000	28800	$GTOPO30/gt30e060s10_dem/gt30e060s10.dem	4800	6000	12000	33600	$GTOPO30/gt30e100s10_dem/gt30e100s10.dem	4800	6000	12000	38400	$GTOPO30/gt30e140s10_dem/gt30e140s10.dem	4800	6000	18000	0		$GTOPO30/gt30w180s60_dem/gt30w180s60.dem	7200	3600	18000	7200	$GTOPO30/gt30w120s60_dem/gt30w120s60.dem	7200	3600	18000	14400	$GTOPO30/gt30w060s60_dem/gt30w060s60.dem	7200	3600	18000	21600	$GTOPO30/gt30w000s60_dem/gt30w000s60.dem	7200	3600	18000	28800	$GTOPO30/gt30e060s60_dem/gt30e060s60.dem	7200	3600	18000	36000	$GTOPO30/gt30e120s60_dem/gt30e120s60.dem	7200	3600
out=$?
echo
expected=8
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoAssembleReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoAssembleReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoAssembleReduce too little data"
((totalTests=totalTests+1))
./gtopoAssembleReduce	./_Pictures/assembleReduce/gtopo30full_reduced_400.dem	43200	21600	400		0		0		$GTOPO30/gt30w180n90_dem/gt30w180n90.dem	3	6000	0		4800	$GTOPO30/gt30w140n90_dem/gt30w140n90.dem	4800	6000	0		9600	$GTOPO30/gt30w100n90_dem/gt30w100n90.dem	4800	6000	0		14400	$GTOPO30/gt30w060n90_dem/gt30w060n90.dem	4800	6000	0		19200	$GTOPO30/gt30w020n90_dem/gt30w020n90.dem	4800	6000	0		24000	$GTOPO30/gt30e020n90_dem/gt30e020n90.dem	4800	6000	0		28800	$GTOPO30/gt30e060n90_dem/gt30e060n90.dem	4800	6000	0		33600	$GTOPO30/gt30e100n90_dem/gt30e100n90.dem	4800	6000	0		38400	$GTOPO30/gt30e140n90_dem/gt30e140n90.dem	4800	6000	6000	0		$GTOPO30/gt30w180n40_dem/gt30w180n40.dem	4800	6000	6000	4800	$GTOPO30/gt30w140n40_dem/gt30w140n40.dem	4800	6000	6000	9600	$GTOPO30/gt30w100n40_dem/gt30w100n40.dem	4800	6000	6000	14400	$GTOPO30/gt30w060n40_dem/gt30w060n40.dem	4800	6000	6000	19200	$GTOPO30/gt30w020n40_dem/gt30w020n40.dem	4800	6000	6000	24000	$GTOPO30/gt30e020n40_dem/gt30e020n40.dem	4800	6000	6000	28800	$GTOPO30/gt30e060n40_dem/gt30e060n40.dem	4800	6000	6000	33600	$GTOPO30/gt30e100n40_dem/gt30e100n40.dem	4800	6000	6000	38400	$GTOPO30/gt30e140n40_dem/gt30e140n40.dem	4800	6000	12000	0		$GTOPO30/gt30w180s10_dem/gt30w180s10.dem	4800	6000	12000	4800	$GTOPO30/gt30w140s10_dem/gt30w140s10.dem	4800	6000	12000	9600	$GTOPO30/gt30w100s10_dem/gt30w100s10.dem	4800	6000	12000	14400	$GTOPO30/gt30w060s10_dem/gt30w060s10.dem	4800	6000	12000	19200	$GTOPO30/gt30w020s10_dem/gt30w020s10.dem	4800	6000	12000	24000	$GTOPO30/gt30e020s10_dem/gt30e020s10.dem	4800	6000	12000	28800	$GTOPO30/gt30e060s10_dem/gt30e060s10.dem	4800	6000	12000	33600	$GTOPO30/gt30e100s10_dem/gt30e100s10.dem	4800	6000	12000	38400	$GTOPO30/gt30e140s10_dem/gt30e140s10.dem	4800	6000	18000	0		$GTOPO30/gt30w180s60_dem/gt30w180s60.dem	7200	3600	18000	7200	$GTOPO30/gt30w120s60_dem/gt30w120s60.dem	7200	3600	18000	14400	$GTOPO30/gt30w060s60_dem/gt30w060s60.dem	7200	3600	18000	21600	$GTOPO30/gt30w000s60_dem/gt30w000s60.dem	7200	3600	18000	28800	$GTOPO30/gt30e060s60_dem/gt30e060s60.dem	7200	3600	18000	36000	$GTOPO30/gt30e120s60_dem/gt30e120s60.dem	7200	3600
out=$?
echo
expected=8
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoAssembleReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoAssembleReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoAssembleReduce bad width"
((totalTests=totalTests+1))
./gtopoAssembleReduce	./_Pictures/assembleReduce/gtopo30full_reduced_400.dem	43200	21600	400		0		0		$GTOPO30/gt30w180n90_dem/gt30w180n90.dem	48av00	6000	0		4800	$GTOPO30/gt30w140n90_dem/gt30w140n90.dem	4800	6000	0		9600	$GTOPO30/gt30w100n90_dem/gt30w100n90.dem	4800	6000	0		14400	$GTOPO30/gt30w060n90_dem/gt30w060n90.dem	4800	6000	0		19200	$GTOPO30/gt30w020n90_dem/gt30w020n90.dem	4800	6000	0		24000	$GTOPO30/gt30e020n90_dem/gt30e020n90.dem	4800	6000	0		28800	$GTOPO30/gt30e060n90_dem/gt30e060n90.dem	4800	6000	0		33600	$GTOPO30/gt30e100n90_dem/gt30e100n90.dem	4800	6000	0		38400	$GTOPO30/gt30e140n90_dem/gt30e140n90.dem	4800	6000	6000	0		$GTOPO30/gt30w180n40_dem/gt30w180n40.dem	4800	6000	6000	4800	$GTOPO30/gt30w140n40_dem/gt30w140n40.dem	4800	6000	6000	9600	$GTOPO30/gt30w100n40_dem/gt30w100n40.dem	4800	6000	6000	14400	$GTOPO30/gt30w060n40_dem/gt30w060n40.dem	4800	6000	6000	19200	$GTOPO30/gt30w020n40_dem/gt30w020n40.dem	4800	6000	6000	24000	$GTOPO30/gt30e020n40_dem/gt30e020n40.dem	4800	6000	6000	28800	$GTOPO30/gt30e060n40_dem/gt30e060n40.dem	4800	6000	6000	33600	$GTOPO30/gt30e100n40_dem/gt30e100n40.dem	4800	6000	6000	38400	$GTOPO30/gt30e140n40_dem/gt30e140n40.dem	4800	6000	12000	0		$GTOPO30/gt30w180s10_dem/gt30w180s10.dem	4800	6000	12000	4800	$GTOPO30/gt30w140s10_dem/gt30w140s10.dem	4800	6000	12000	9600	$GTOPO30/gt30w100s10_dem/gt30w100s10.dem	4800	6000	12000	14400	$GTOPO30/gt30w060s10_dem/gt30w060s10.dem	4800	6000	12000	19200	$GTOPO30/gt30w020s10_dem/gt30w020s10.dem	4800	6000	12000	24000	$GTOPO30/gt30e020s10_dem/gt30e020s10.dem	4800	6000	12000	28800	$GTOPO30/gt30e060s10_dem/gt30e060s10.dem	4800	6000	12000	33600	$GTOPO30/gt30e100s10_dem/gt30e100s10.dem	4800	6000	12000	38400	$GTOPO30/gt30e140s10_dem/gt30e140s10.dem	4800	6000	18000	0		$GTOPO30/gt30w180s60_dem/gt30w180s60.dem	7200	3600	18000	7200	$GTOPO30/gt30w120s60_dem/gt30w120s60.dem	7200	3600	18000	14400	$GTOPO30/gt30w060s60_dem/gt30w060s60.dem	7200	3600	18000	21600	$GTOPO30/gt30w000s60_dem/gt30w000s60.dem	7200	3600	18000	28800	$GTOPO30/gt30e060s60_dem/gt30e060s60.dem	7200	3600	18000	36000	$GTOPO30/gt30e120s60_dem/gt30e120s60.dem	7200	3600
out=$?
echo
expected=8
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoAssembleReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoAssembleReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoAssembleReduce succsses"
((totalTests=totalTests+1))
./gtopoAssembleReduce	./_Pictures/assembleReduce/result.dem 43200 21600 216 0 0 $GTOPO30/gt30w180n90_dem/gt30w180n90.dem 4800	6000 0 4800	$GTOPO30/gt30w140n90_dem/gt30w140n90.dem	4800 6000	0	9600 $GTOPO30/gt30w100n90_dem/gt30w100n90.dem 4800	6000 0 14400 $GTOPO30/gt30w060n90_dem/gt30w060n90.dem 4800 6000 0 19200 $GTOPO30/gt30w020n90_dem/gt30w020n90.dem 4800	6000 0 24000 $GTOPO30/gt30e020n90_dem/gt30e020n90.dem 4800	6000 0 28800 $GTOPO30/gt30e060n90_dem/gt30e060n90.dem 4800 6000	0	33600	$GTOPO30/gt30e100n90_dem/gt30e100n90.dem	4800 6000	0 38400	$GTOPO30/gt30e140n90_dem/gt30e140n90.dem	4800 6000 6000 0 $GTOPO30/gt30w180n40_dem/gt30w180n40.dem 4800	6000 6000	4800 $GTOPO30/gt30w140n40_dem/gt30w140n40.dem 4800	6000 6000	9600 $GTOPO30/gt30w100n40_dem/gt30w100n40.dem 4800	6000 6000	14400	$GTOPO30/gt30w060n40_dem/gt30w060n40.dem	4800 6000	6000 19200 $GTOPO30/gt30w020n40_dem/gt30w020n40.dem 4800	6000 6000	24000	$GTOPO30/gt30e020n40_dem/gt30e020n40.dem	4800	6000 6000	28800	$GTOPO30/gt30e060n40_dem/gt30e060n40.dem	4800 6000	6000 33600 $GTOPO30/gt30e100n40_dem/gt30e100n40.dem 4800	6000 6000	38400	$GTOPO30/gt30e140n40_dem/gt30e140n40.dem	4800 6000	12000	0 $GTOPO30/gt30w180s10_dem/gt30w180s10.dem	4800 6000	12000	4800 $GTOPO30/gt30w140s10_dem/gt30w140s10.dem 4800 6000 12000 9600 $GTOPO30/gt30w100s10_dem/gt30w100s10.dem	4800 6000	12000	14400	$GTOPO30/gt30w060s10_dem/gt30w060s10.dem	4800 6000	12000	19200	$GTOPO30/gt30w020s10_dem/gt30w020s10.dem	4800 6000	12000	24000	$GTOPO30/gt30e020s10_dem/gt30e020s10.dem	4800 6000	12000	28800	$GTOPO30/gt30e060s10_dem/gt30e060s10.dem	4800 6000	12000	33600	$GTOPO30/gt30e100s10_dem/gt30e100s10.dem	4800 6000	12000	38400	$GTOPO30/gt30e140s10_dem/gt30e140s10.dem	4800 6000	18000	0 $GTOPO30/gt30w180s60_dem/gt30w180s60.dem	7200 3600	18000	7200 $GTOPO30/gt30w120s60_dem/gt30w120s60.dem 7200	3600 18000 14400 $GTOPO30/gt30w060s60_dem/gt30w060s60.dem 7200	3600 18000 21600 $GTOPO30/gt30w000s60_dem/gt30w000s60.dem	7200 3600	18000	28800	$GTOPO30/gt30e060s60_dem/gt30e060s60.dem	7200 3600	18000	36000	$GTOPO30/gt30e120s60_dem/gt30e120s60.dem	7200 3600
out=$?
echo
expected=0
echo -e "${BLUE}Expected${NC}: $expected"
if [ $out -eq $expected ]; then
    ((testsPassed=testsPassed+1))
    echo -e "${GREEN}PASSED${NC} => gtopoAssembleReduce returned $out"
else
    echo -e "${RED}FAILED${NC} => gtopoAssembleReduce returned $out"
fi
echo
echo "=========================================================="
echo
echo "=========================================================="
echo "gtopoPrintLand succsses"
((totalTests=totalTests+1))
./gtopoPrintLand ./_Pictures/assembleReduce/result.dem 200 100 ./_Pictures/assembleReduce/map.dem 0 300 1000
out=$?
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
echo "gtopoAssemble compare"
((totalTests=totalTests+1))
./gtopoComp ./_Pictures/assembleReduce/result.dem 200 100 $TESTDEMS/gtopo30full_reduced_216.dem
out=$?
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
echo "${testsPassed}/$totalTests tests passed"
echo
make clean
