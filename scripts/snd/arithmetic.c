#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int op;

float get_op_val(float a, float b)
{
	switch(op)
	{
		case '+':
		return a+b;
		case '-':
		return a-b;
		case '*':
		return a*b;
		case '/':
		return b==0.0f?0.0f:a/b;
	}
	return 0.0f;
}

int main(int argc, char **argv)
{
	(void)argc;
	(void)argv;
	if(argc < 2)
	{
		fprintf(stdout, "0");
		return 0;
	}
	float o = atof(argv[2]);
	op = argv[1][0];
	
	int as_int = (argc > 3);
	
	char s[1024]={0};
	fgets(s, sizeof(s), stdin);
	float f = atof(s);
	if(as_int)
		fprintf(stdout, "%d", (int)get_op_val(f, o));
	else
		fprintf(stdout, "%f", get_op_val(f, o));
	return 0;
}
