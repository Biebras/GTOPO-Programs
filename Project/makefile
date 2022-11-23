CC = gcc
CCFLAGS = -g -std=c99 -Wall -U__STRICT_ANSI__

all: gtopoEcho gtopoComp gtopoReduce gtopoTile gtopoAssemble gtopoPrintLand gtopoAssembleReduce

gtopoEcho: gtopoEcho.o gtopo.o helpers.o
	${CC} ${CCFLAGS} -o gtopoEcho gtopoEcho.o gtopo.o helpers.o

gtopoComp: gtopoComp.o gtopo.o helpers.o
	${CC} ${CCFLAGS} -o gtopoComp gtopoComp.o gtopo.o helpers.o

gtopoReduce: gtopoReduce.o gtopo.o helpers.o
	${CC} ${CCFLAGS} -o gtopoReduce gtopoReduce.o gtopo.o helpers.o

gtopoTile: gtopoTile.o gtopo.o helpers.o
	${CC} ${CCFLAGS} -o gtopoTile gtopoTile.o gtopo.o helpers.o

gtopoAssemble: gtopoAssemble.o gtopo.o assemble.o helpers.o
	${CC} ${CCFLAGS} -o gtopoAssemble gtopoAssemble.o gtopo.o assemble.o helpers.o

gtopoPrintLand: gtopoPrintLand.o gtopo.o helpers.o
	${CC} ${CCFLAGS} -o gtopoPrintLand gtopoPrintLand.o gtopo.o helpers.o

gtopoAssembleReduce: gtopoAssembleReduce.o gtopo.o helpers.o assemble.o
	${CC} ${CCFLAGS} -o gtopoAssembleReduce gtopoAssembleReduce.o gtopo.o helpers.o assemble.o

.SUFFIXES:	.o .c
.c.o:
	${CC} ${CCFLAGS} -c -o $*.o $*.c

clean:
	rm -f gtopoEcho gtopoComp gtopoReduce gtopoTile gtopoAssemble gtopoPrintLand gtopoAssembleReduce *.o
