#!/bin/bash
chr() {
  printf \\$(printf '%03o' $1)
}
letter=0;
n=0;
for i in `seq 0 127`; 
do
	letter=$(chr "$i")
	for i in `seq 0 25`;
	do
		
		num=$((4*$i + 3))
		

	~/pa1/pa1 $num $letter
	#~/../public/pa1test $num $letter
	done;

done;
