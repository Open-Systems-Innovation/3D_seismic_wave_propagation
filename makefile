#main: main.o
#	${CLINKER} -o $@ $^ ${PETSC_LIB}
#
include ${PETSC_DIR}/lib/petsc/conf/variables
include ${PETSC_DIR}/lib/petsc/conf/rules

CC = gcc
CFLAGS = -Wall -Wextra -std=c11
TARGET = main

main: main.o
	gcc main.o -o main

main.o:
	gcc -c main.c

clean: rm -f main
