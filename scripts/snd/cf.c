#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//use common c funcs in bash

int as_int=0;

void retval(float f)
{
	if(!as_int)
		fprintf(stdout, "%f", f);
	else
		fprintf(stdout,"%d",(int)f);
}

int main(int argc, char **argv)
{
	if(argc < 3)
		return 0;
	
	char s[1024]={0};
	fgets(s, sizeof(s), stdin);
	float b = atof(s);
	
	for(int i = 1; i < argc; ++i)
	{
		if(!strcmp(argv[i], "-int"))
			as_int=1;
	}
	
	float a = atof(argv[2]);
	
	#define MAX(a,b) ((a) > (b) ? (a) : (b))
	#define MIN(a,b) ((a) < (b) ? (a) : (b))
	const char *cmd = argv[1];
	
	if(!strcmp(cmd,"max"))
		retval(MAX(a,b));
	else if(!strcmp(cmd, "min"))
		retval(MIN(a,b));
	return 0;
}
