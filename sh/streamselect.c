#include <stdio.h>
typedef enum {
  MAIN_OBJ,
  MAIN_PROP,
  MAIN_VAL,
  EXPCT_COLON_VAL,
  PROP_ISVAL
} readsta_t;

typedef enum {
  URL,
  FORMAT,
  BITRATE,
  QUAL
} valtype_t;

void enterobj(readsta_t *state){
	if(*state==-1){
		fputs("Enter Obj\n",stderr);
		*state=MAIN_OBJ;
	}
}
void exitobj(readsta_t *state){
	if(*state==MAIN_OBJ){
		fputs("Exit Obj\n",stderr);
		*state=-1;
	}
}
void prop(readsta_t *state){
	if(*state==MAIN_OBJ){
		fputs("enter proptxt\n",stderr);
		*state=MAIN_PROP;
		return;
	}
	if(*state==MAIN_PROP){
		fputs("exit proptxt\n",stderr);
		*state=EXPCT_COLON_VAL;
		return;
	}
	if(*state==PROP_ISVAL){
		fputs("start value\n",stderr);
		*state=MAIN_VAL;
		return;
	}
	if(*state==MAIN_VAL){
		fputs("exit value\n",stderr);
		*state=MAIN_OBJ;
		return;
	}
}

void colon(readsta_t *state){
	if(*state==EXPCT_COLON_VAL){
		fputs("colon\n",stderr);
		*state=PROP_ISVAL;
	}
}

void iftrackit(char c,readsta_t *s,readsta_t *b,readsta_t comp,char *ostr){
	if((*s==comp)&&(*b==comp)){
		//putc(c,stdout);
		*ostr=c;
	} else if(*b==comp){
		//putc('\n',stdout);
		*ostr='\0';
	} else if(*s==comp)
		*ostr=-1;
}

void ifprintit(char c,readsta_t *s,readsta_t *b,readsta_t comp){
	if((*s==comp)&&(*b==comp)){
		putc(c,stdout);
	} else if(*b==comp){
		putc('\n',stdout);
	}
}
void ifprintval(char c,readsta_t *s,readsta_t *b){
	ifprintit(c,s,b,MAIN_VAL);
//	if((*s==MAIN_VAL)&&(*b==MAIN_VAL))
//		putc(c,stdout);

}
void iftrackprop(char c,readsta_t *s,readsta_t *b,char *ostr){
		iftrackit(c,s,b,MAIN_PROP,ostr);
}
void ifprintprop(char c,readsta_t *s,readsta_t *b){
		ifprintit(c,s,b,MAIN_PROP);
}

void prcin(char c,readsta_t *state,readsta_t *bakstate,char* ostr){
		if(c=='{')
			enterobj(state);
		if(c=='}')
			exitobj(state);
		if(c=='"')
			prop(state);
		if(c==':')
			colon(state);
//		ifprintval(c,state,bakstate);
		ifprintprop(c,state,bakstate);
		iftrackprop(c,state,bakstate,ostr);
		*bakstate=*state;
}

int main(int argc, char **argv)
{
	char ostr[100];
	int stri=0;
	readsta_t state=-1;
	readsta_t bakstate=-1;
	char c=getc(stdin);
	while(c!=-1){
/*		if(c=='{')
			enterobj(&state);
		if(c=='}')
			exitobj(&state);
		if(c=='"')
			prop(&state);
		if(c==':')
			colon(&state);
//		ifprintval(c,&state,&bakstate);
		ifprintprop(c,&state,&bakstate);
		bakstate=state;
*/
		prcin(c,&state,&bakstate,&ostr[stri]);
		if(ostr[stri]!='\0'){
			stri++;
			if (ostr[stri-1]==-1)
				stri=0;
		} /*else {
			stri=0;
		}
*/		c=getc(stdin);
	}
	ostr[stri]='\0';
	printf("ostr: %s\n",&ostr[0]);
}
