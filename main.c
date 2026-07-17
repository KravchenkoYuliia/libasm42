#include <stdio.h>
#include "includes/libasm.h"

#define GREEN "\033[1;92m"
#define RESET "\033[0m"

int	main() {

	printf( GREEN "Calling ft_strlen\n" RESET );
	char	string[1000] = "Hello";
	printf( "len of [%s] is [%zu]\n", string, ft_strlen( string ) );
}