#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv)
{
	(void)argc;
	(void)argv;

	char s[1024]={0};
	fgets(s, sizeof(s), stdin);
	float desiredVolume = atof(s); //given in float from 0 - 1
	float maxVolume = 65535.f;
	float newVolume;
	int is_flt=0;
	if(desiredVolume > 1.f)
	{
			is_flt=1;
			newVolume = desiredVolume / maxVolume;
	}
	else
			newVolume = maxVolume * desiredVolume;
	int asInt = (int)newVolume;
	//fprintf(stdout, "Message was %s\n", s);
	if(is_flt)
		fprintf(stdout, "%f", newVolume);
	else
		fprintf(stdout, "%d", asInt);
	return 0;
}
