/*
PtsToPlyConverter Program
Converts a PTS or TXT based PTS file into a PLY file for use in Math
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *strrev(char *str)
{
    char *p1, *p2;

    if (! str || ! *str)
        return str;
    for (p1 = str, p2 = str + strlen(str) - 1; p2 > p1; ++p1, --p2)
    {
        *p1 ^= *p2;
        *p2 ^= *p1;
        *p1 ^= *p2;
    }
    return str;
}

void getExtension(char*, char*);

int main(int argc, const char* argv[])
{
    if (argc <= 1){
        printf("Please specify both PTS in and PLY out.");
        return 0;
    }

	unsigned int lineCount = 0;
	int byte, i;
	char filename[255];
	char newFilename[255];
	char ext[25];
	FILE *f_in;
	FILE *f_out;

	strcpy(filename, argv[1]);
	strcpy(newFilename, filename);
	getExtension(ext, filename);

	if (strcmp(ext, "pts") == 0 || strcmp(ext, "txt") == 0 )
	{


		newFilename[strlen(newFilename) - 4] = '\0';
		f_in = fopen(filename, "r");
		strcat(newFilename, ".ply");
		f_out = fopen(newFilename, "w");
/**************************************************************************/
printf("Conversion Started...\n\n");
/**************************************************************************/
//this will get a line count in the file.
//We will need this to figure out how many points are in the point cloud
		for (i = 0; (byte = getc(f_in)) != EOF; i++)
		{
			if(byte == '\n')
				lineCount++;
		}
/**************************************************************************/

/**************************************************************************/
//We can now write the header for the Ply file with the correct
//amount of vertex count

fprintf(f_out, "ply\n");
fprintf(f_out, "format ascii 1.0\n");
fprintf(f_out, "comment author: Miller Hooks\n");
fprintf(f_out, "comment object: Point Cloud\n");
//lineCount minus the header in the pts file gives us the vertex count
fprintf(f_out, "element vertex %d\n", lineCount-1);
fprintf(f_out, "property float x\n");
fprintf(f_out, "property float y\n");
fprintf(f_out, "property float z\n");
fprintf(f_out, "property float nx\n");
fprintf(f_out, "property float ny\n");
fprintf(f_out, "property float nz\n");
//fprintf(f_out, "property float size\n");
fprintf(f_out, "property uchar red\n");
fprintf(f_out, "property uchar green\n");
fprintf(f_out, "property uchar blue\n");
fprintf(f_out, "property uchar alpha\n");
fprintf(f_out, "element face 0\n");
fprintf(f_out, "property list uchar int vertex_indices\n");
fprintf(f_out, "end_header");


/**************************************************************************/
	lineCount = 0; //resets line counter
	rewind(f_in); //reset cursor pointer to the beginning
		for (i = 0; (byte = getc(f_in)) != EOF; i++)
		{
			if(byte == '\n') {
				lineCount++;
			}
			if(lineCount > 0) //starts writing the points after the cursor has passed the header
			{
				if(byte != ',') //This if else statement takes out the ',' deliminator
					fputc(byte, f_out);
				else
					fputc(' ', f_out);

			}
		}

/**************************************************************************/
printf("Conversion Completed.");//prompts the user that the process has completed
/**************************************************************************/
	}
	else
	{
		//file is not supported
		printf("Error: File is not a .txt or .pts point cloud file.");

	}
	fclose(f_in);
	fclose(f_out);
	return 0;
}

void getExtension(char* ext, char* file)
{
	int i, j = 0;
	for (i = strlen(file) - 1; i >= 0; i--)
	{
		if(file[i] == '.')
			break;
		ext[j] = file[i];
		j++;
	}
	ext[j] = '\x0';
	strrev(ext);
}