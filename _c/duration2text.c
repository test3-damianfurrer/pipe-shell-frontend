#include <stdio.h>
//#include <stdlib.h>
#define MAX_INT_DECIMALS 10
char * sbuf;

void printint(int number){
	if(number == 0 ){
		putc('0',stdout);
		putc('0',stdout);
	} else if(number < 10){
		putc('0',stdout);
		putc(number+48,stdout);
	} else{
		int i = MAX_INT_DECIMALS;
		do {
			sbuf[--i] = (number % 10) + 48;
			number /= 10;
		} while(number > 0 && i > 0);
		//i = 0;
		while (i < MAX_INT_DECIMALS){
			if(sbuf[i] >= 48){
				putc(sbuf[i],stdout);
			}
//			sbuf[i] = 0;
			i++;
		}
	}
}

int main(int argc, char **argv){
	char sbufo[MAX_INT_DECIMALS];
	sbuf = &sbufo[0];	//(char *) calloc (MAX_INT_DECIMALS, sizeof(char));
	int number = 0;
	int charnum = 0;
	if(argc != 2)
		return 1; //wrong arg count
	for(int i = 0; argv[1][i] != '\0';i++){
		if(argv[1][i]>=48 && argv[1][i] <= 57){
			charnum = argv[1][i]-48;
		} else {
			return 1; //not a number
		}
		number *= 10;
		number += charnum;
	}
	int seconds=0;
	int minutes=0;
	int hours=0;
	seconds = number % 60;
	hours = number / 60;
	minutes = hours % 60;
	hours = hours / 60;

	printint(hours);
	putc(':',stdout);
	printint(minutes);
	putc(':',stdout);
	printint(seconds);
//	free(sbuf);
}
