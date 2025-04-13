#include <string.h>
#include <unistd.h>
#include <stddef.h>

int main(int argc, char **argv) {
	char *str = "Hello World\nI am writing this using syscalls... from C\n";
	size_t len = strlen(str);

	write(0, str, len);

	return 0;
}