#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "includes/libasm.h"

#define GREEN "\033[1;92m"
#define RESET "\033[0m"

void	test_strlen( int ac, char** av ) {

	(void)av;
	if ( ac != 2 ) {
		write( STDERR_FILENO, "./program ft_strlen string\n", strlen( "./program ft_strlen string\n" ) );
		exit( EXIT_FAILURE );
	}
	printf( GREEN "Calling ft_strlen\n" RESET );
	printf( "Real strlen of [%s] is [%zu]\n", av[1], strlen( av[1] ) );
	printf( "ft_strlen of [%s] is [%zu]\n", av[1], ft_strlen( av[1] ) );

}

int	main( int ac, char** av ) {

	if ( ac < 3 ) {
		write( STDERR_FILENO, "./program FUNCTION ARGUMENT(S)\n", strlen( "./program FUNCTION ARGUMENT(S)\n" ) );
		return 1;
	}
	if ( strcmp( av[1], "ft_strlen" ) == 0 )
		test_strlen( ac-1, av+1 );

}