#!/bin/bash
infile=$1
filename=${infile%.*}
ext=${infile##*.}

sed 's/SaanichInlet_120m./MAG/g' $infile > $filename.$ext

