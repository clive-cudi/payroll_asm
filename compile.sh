#!/bin/bash

if [ $# -ne 1 ]; then
    echo $0 usage is: $0 \<filename\>
    echo "filename must end in a .asm"
    exit 1
fi
#get the filename in a nicer named variable
fileName=$1
# echo $fileName

#get last 4 characters of filename to make sure they match
endChar=${fileName:$[${#fileName}-4]}
ext=".asm"

# echo $endChar

#if ["$endChar" -ne "$ext"]; then
#	echo "not equal"
#fi
#It takes the filename, and returns a substring 
#starting from index 0, and pulls in the length 
#of the filename -4 number of characters
#to strip off the ".asm" at the end of the filename
# echo "in loop"
truncFileName=${fileName:0:$[${#fileName}-4]}
nasm -f elf $fileName -o ./out/$truncFileName.o
ld -m elf_i386 ./out/$truncFileName.o -o ./out/$truncFileName

cd ./out && ./$truncFileName
