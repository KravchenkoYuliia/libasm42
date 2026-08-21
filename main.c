#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdint.h>
#include <limits.h>
#include <errno.h>
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

	if ( ac != 1 )
		fatal_error( "./program ft_strlen string\n" );
	if ( av == NULL || av[0] == NULL )
		fatal_error( "string is NULL" );
	printf( UNDERLINE GREEN "Calling ft_strlen\n" RESET );
	printf( PURPLE "Real strlen" RESET " of [%s] is" PURPLE " [%zu]\n" RESET, av[0], strlen( av[0] ) );
	printf( CYAN "My ft_strlen" RESET " of [%s] is" CYAN " [%zu]\n" RESET, av[0], ft_strlen( av[0] ) );

}


void	test_strcpy( int ac, char** av ) {

	if ( ac != 2 )
		fatal_error( "./program ft_strcpy dest source\n" );
	if ( !av || !av[0] || !av[1] )
		fatal_error( "dest or source is NULL" );

	printf( UNDERLINE GREEN "Calling ft_strcpy\n" RESET );
	printf( "dest before:" PURPLE " %s" RESET ", source before:" CYAN " %s" RESET "\n", av[0], av[1]);
	ft_strcpy( av[0], av[1] );
	printf( "dest after:" CYAN " %s" RESET ", source after:" CYAN " %s" RESET "\n", av[0], av[1]);

}


void	test_strcmp( int ac, char** av ) {

	if ( ac != 2 )
		fatal_error( "./program ft_strcmp string1 string2\n" );
	if ( !av || !av[0] || !av[1] )
		fatal_error( "one or two strings are NULL" );

	printf( PURPLE "Real strcmp: [%d]\n" RESET, strcmp( av[0], av[1] ) );
	printf( CYAN "My ft_strcmp: [%d]\n" RESET, ft_strcmp( av[0], av[1] ) );
	
	int	result_of_comparison = ft_strcmp( av[0], av[1] );
	if ( result_of_comparison == 0 )
		printf( "The strings are equal\n[%s]\n[%s]\n",  av[0], av[1] );
	else if ( result_of_comparison > 0 )
		printf( "[%s] is greater than [%s]\n", av[0], av[1] );
	else if ( result_of_comparison < 0 )
		printf( "[%s] is less than [%s]\n", av[0], av[1] );

}


int		int_is_valid( const char *str, int *result )
{
	char	*end;
	long	n;

	errno = 0;
	n = strtol( str, &end, 10 );
	if ( str == end || *end != '\0'
		|| errno == ERANGE || n > INT_MAX || n < INT_MIN )
		return (0);
	*result = ( int )n;
	return 1;

}

int		size_t_is_valid( const char *str, size_t *result )
{
	char				*end;
	unsigned long long	n;

	if ( *str == '-' )
		return 0;
	errno = 0;
	n = strtoull( str, &end, 10 );
	if ( str == end || *end != '\0'
		|| errno == ERANGE || n > SIZE_MAX )
		return 0;
	*result = ( size_t )n;
	return 1;

}

void	test_write( int ac, char** av ) {

	if ( ac != 3 )
		fatal_error( "./program ft_write fd text count\n" );
	if ( !av || !av[0] || !av[1] || !av[2])
		fatal_error( "One of the arguments is NULL\n" );
	
	int		fd;
	if ( !int_is_valid( av[0], &fd ) )
		fatal_error( "fd must be an int" );

	char*	buffer = av[1];

	size_t	count;
	if ( !size_t_is_valid( av[2], &count ) )
		fatal_error( "count must be a size_t" );

	if ( strlen( buffer ) < count ) {
		printf( "Not enough characters in buffer[%s]\nMust be %zu\n", buffer, count );
		exit( EXIT_FAILURE );
	}

	ssize_t		result_of_write = ft_write( fd, buffer, count );
	if ( result_of_write < 0 )
		fatal_error( "Can't write in this fd, error occured\n" );

	printf( "\n" CYAN "%zd" RESET " bytes were written\n", result_of_write );

}


void	test_read( int ac, char** av ) {

	if ( ac != 2 )
		fatal_error( "./program ft_read fd count\n" );
	if ( !av || !av[0] || !av[1] )
		fatal_error( "One of the arguments is NULL\n" );

	int		fd;
	if ( !int_is_valid( av[0], &fd ) )
		fatal_error( "fd must be an int" );

	size_t	count;
	if ( !size_t_is_valid( av[1], &count ) )
		fatal_error( "count must be a size_t" );

	char*	buffer = calloc( count + 1, 1 );
	if ( !buffer )
		fatal_error( "Malloc for buffer failed\n" );

	//ssize_t		result_of_read = read( fd, buffer, count );
	//printf( PURPLE "[%zd]" RESET " bytes were read by" PURPLE " real read" RESET "\nBuffer is" PURPLE " [%s]" RESET "\n\n", result_of_read, buffer );

	ssize_t		result_of_read = ft_read( fd, buffer, count );
	printf( CYAN "[%zd]" RESET " bytes were read by" CYAN " ft_read" RESET "\nBuffer is" CYAN " [%s]" RESET "\n\n", result_of_read, buffer );

	free( buffer );

}


int	main( int ac, char** av ) {

	if ( ac < 3 ) {
		write( STDERR_FILENO, "./program FUNCTION ARGUMENT(S)\n", strlen( "./program FUNCTION ARGUMENT(S)\n" ) );
		return 1;
	}
	if ( !av[1] )
		fatal_error( "function name is NULL\n" );

	if ( strcmp( av[1], "ft_strlen" ) == 0 )
		test_strlen( ac-2, av+2 );
	else if ( strcmp( av[1], "ft_strcpy" ) == 0 )
		test_strcpy( ac-2, av+2 );
	else if ( strcmp( av[1], "ft_strcmp" ) == 0 )
		test_strcmp( ac-2, av+2 );
	else if ( strcmp( av[1], "ft_write" ) == 0 )
		test_write( ac-2, av+2 );
	else if ( strcmp( av[1], "ft_read" ) == 0 )
		test_read( ac-2, av+2 );
	else
		printf( "Invalid function\n" );

}