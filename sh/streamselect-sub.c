#include <stdio.h>

typedef struct {
  char qual[10];
  char bitrate[10];
  char format[10];
} presel_t;

void preselprc(presel_t *p,char * arg){
  int argi=0;int pi=0;
  char * chr;
  chr=&p->qual[0];
  while (arg[argi] != '\0'){
    chr[pi] = arg[argi];
    if(chr[pi]=='p'){
      chr[pi]='\0';
      chr=&p->bitrate[0];
      pi=-1;
    }else if((chr[pi]=='_')&&(chr!=&p->format[0])){
      chr[pi]='\0';
      chr=&p->format[0];
      pi=-1;
    }
    argi++;
    pi++;
  }
}


int lineprc(char *c, int len,presel_t* comp, char *out){
  c[len] = '\0';
/*  presel_t splt;
  preselprc(&splt,c);
  printf("%s-",&splt.qual[0]);
  printf("%s-",&splt.bitrate[0]);
  printf("%s\n",&splt.format[0]);
*/
  len--;
  int lencomp;
  for(lencomp=0;comp->format[lencomp]!='\0';lencomp++);
  lencomp--;
  while (lencomp>=0){
    if (!(c[len] == comp->format[lencomp]))
      return -1;
    len--;lencomp--;
  }
//  fputs(c,stdout); //tst ; later write back to total array. if passed. maybe have case with check level 1-3
//  fputs("\n",stdout);
  len=0;
  while (c[len]!='\0'){
    out[len]=c[len];
    len++;
  }
  out[len]='\n';
  return len+1;
}
void prepprint(char * prep,char * txt){
  for(int i=0;prep[i]!='\0';i++)
    putc(prep[i],stderr);
  for(int i=0;txt[i]!='\0';i++)
    putc(txt[i],stderr);
  putc('\n',stderr);
}

int main(int argc, char **argv)
{
  presel_t inpt;
  char line[100];
  int usdochrs=0;
  char olines[1024];
  char * preselect;
  if((argc-1)){
    fputs("one\n",stderr);
    preselect=argv[1];
    preselprc(&inpt,preselect);
    prepprint("qual: ",&inpt.qual[0]);
    prepprint("bitrate: ",&inpt.bitrate[0]);
    prepprint("format: ",&inpt.format[0]);

    int len=0;
    line[len] = getc(stdin);
    while (line[len] != -1){
      len+=1;
      if(len==1)
	putc(line[len],stdout);
      line[len]=getc(stdin);
      if (line[len] == '\n'){
	putc(line[len],stdout);
	line[len]='\0';
        int ret=lineprc(&line[0],len,&inpt,&olines[usdochrs]);
	if(ret>0)
	  usdochrs+=ret;
//	return 0;
	len=0;
        line[len] = getc(stdin);
      }else{
	putc(line[len],stdout);
      }
    }

//    for(int i=0;i<=100;i++)
//	putc(line[i],stdout);

//    int i=0;
/*    while(olines[i]!='\0'){
	putc(olines[i],stdout);
        i++;
      }
*/

//    for(int i=0;i<=usdochrs;i++)
//	putc(olines[i],stdout);
  }else{
    char c=getc(stdin);
    while (c != -1){
	putc(c,stdout);
	c=getc(stdin);
    }
/*    line[len] = getc(stdin);
    while (line[len] != -1){
      putc(line[len],stdout);
      len+=1;
      line[len]=getc(stdin);
      if (line[len] == '\n'){
	lineprc(&line[0],len);
	return 0;
	len=1;
      }
    }
*/
  }
//  fputs("\nEOF\n",stdout);
}
