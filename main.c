#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "includes/libasm.h"

#define UNDERLINE "\033[4m"
#define GREEN "\033[1;92m"
#define PURPLE "\033[1;95m"
#define CYAN "\033[1;96m"
#define RESET "\033[0m"


void	fatal_error( char* msg ) {
	
	write( STDERR_FILENO, msg, strlen( msg ) );
	exit( EXIT_FAILURE );

}


void	test_strlen( int ac, char** av ) {

	if ( ac != 2 )
		fatal_error( "./program ft_strlen string\n" );
	if ( av == NULL || av[1] == NULL )
		fatal_error( "string is NULL" );
	printf( UNDERLINE GREEN "Calling ft_strlen\n" RESET );
	printf( PURPLE "Real strlen" RESET " of [%s] is" PURPLE " [%zu]\n" RESET, av[1], strlen( av[1] ) );
	printf( CYAN "My ft_strlen" RESET " of [%s] is" CYAN " [%zu]\n" RESET, av[1], ft_strlen( av[1] ) );

}


void	test_strcpy( int ac, char** av ) {

	if ( ac != 3 )
		fatal_error( "./program ft_strcpy dest source\n" );
	if ( !av || !av[1] || !av[2] )
		fatal_error( "dest or source is NULL" );

	printf( UNDERLINE GREEN "Calling ft_strcpy\n" RESET );
	printf( "dest before:" PURPLE " %s" RESET ", source before:" CYAN " %s" RESET "\n", av[1], av[2]);
	ft_strcpy( av[1], av[2] );
	printf( "dest after:" CYAN " %s" RESET ", source after:" CYAN " %s" RESET "\n", av[1], av[2]);

}


void	test_strcmp( int ac, char** av ) {

	if ( ac != 3 )
		fatal_error( "./program ft_strcmp string1 string2\n" );
	if ( !av || !av[1] || !av[2] )
		fatal_error( "one or two strings are NULL" );

	printf( PURPLE "Real strcmp: [%d]\n" RESET, strcmp( av[1], av[2] ) );
	int	result_of_comparison = ft_strcmp( av[1], av[2] );
	if ( result_of_comparison == 0 )
		printf( "The strings are equal\n[%s]\n[%s]\n",  av[1], av[2] );
	else if ( result_of_comparison > 0 )
		printf( "[%s] is greater than [%s]\n", av[1], av[2] );
	else if ( result_of_comparison < 0 )
		printf( "[%s] is less than [%s]\n", av[1], av[2] );

}


int	main( int ac, char** av ) {

	if ( ac < 3 ) {
		write( STDERR_FILENO, "./program FUNCTION ARGUMENT(S)\n", strlen( "./program FUNCTION ARGUMENT(S)\n" ) );
		return 1;
	}
	if ( !av[1] )
		fatal_error( "function name is NULL\n" );

	if ( strcmp( av[1], "ft_strlen" ) == 0 )
		test_strlen( ac-1, av+1 );
	else if ( strcmp( av[1], "ft_strcpy" ) == 0 )
		test_strcpy( ac-1, av+1 );
	else if ( strcmp( av[1], "ft_strcmp" ) == 0 )
		test_strcmp( ac-1, av+1 );

}