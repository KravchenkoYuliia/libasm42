#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdint.h>
#include <limits.h>
#include <errno.h>
#include "includes/libasm.h"
#include "includes/libasm_bonus.h"

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

	printf( UNDERLINE GREEN "Calling ft_strlen" RESET "\n\n" );
	printf( PURPLE "Real strlen" RESET " of [%s] is" PURPLE " [%zu]\n" RESET, av[0], strlen( av[0] ) );
	printf( CYAN "My ft_strlen" RESET " of [%s] is" CYAN " [%zu]\n" RESET, av[0], ft_strlen( av[0] ) );

}


void	test_strcpy( int ac, char** av ) {

	if ( ac != 2 )
		fatal_error( "./program ft_strcpy dest source\n" );
	if ( !av || !av[0] || !av[1] )
		fatal_error( "dest or source is NULL" );

	char*	dest = av[0];
	char*	src = av[1];

	printf( UNDERLINE GREEN "Calling ft_strcpy" RESET "\n\n" );
	printf( "dest before:" PURPLE " %s" RESET "\n", dest );
	ft_strcpy( dest, src );	
	printf( "dest after:" CYAN " %s" RESET "\n", dest );

}


void	test_strcmp( int ac, char** av ) {

	if ( ac != 2 )
		fatal_error( "./program ft_strcmp string1 string2\n" );
	if ( !av || !av[0] || !av[1] )
		fatal_error( "one or two strings are NULL" );

	printf( UNDERLINE GREEN "Calling ft_strcmp" RESET "\n\n" );
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

	printf( UNDERLINE GREEN "Calling ft_write" RESET "\n\n" );
	ssize_t		result_of_write = ft_write( fd, buffer, count );
	if ( result_of_write < 0 ) {
		printf( "errno = %d\n", errno );
		fatal_error( "Can't write in this fd, error occured\n" );
	}

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

	printf( UNDERLINE GREEN "Calling ft_read" RESET "\n\n" );
	ssize_t		result_of_read = ft_read( fd, buffer, count );
	if ( result_of_read < 0 ) {
		free( buffer );
		printf( "errno = %d\n", errno );
		fatal_error( "Can't read from this fd, error occured\n" );
	}
	printf( CYAN "[%zd]" RESET " bytes were read by" CYAN " ft_read" RESET "\n"\
			"Buffer is" CYAN " [%s]" RESET "\n", result_of_read, buffer );

	free( buffer );

}


void	test_strdup( int ac, char** av ) {

	if ( ac != 1 )
		fatal_error( "./program ft_strdup string\n" );
	if ( !av || !av[0] )
		fatal_error( "String is NULL\n" );

	printf( UNDERLINE GREEN "Calling ft_strdup" RESET "\n\n" );

	char*	init_string = av[0];
	char*	duplicate_string = ft_strdup( init_string );
	if ( !duplicate_string ) {
		printf( "errno = %d\n", errno );
		fatal_error( "Can't duplicate the string, error occured\n" );
	}

	printf( PURPLE "The initial" RESET " string is %s" PURPLE " [%p]" RESET "\n"\
			CYAN "Duplicated" RESET " string is %s" CYAN " [%p]" RESET "\n",\
			init_string, &init_string,\
			duplicate_string, &duplicate_string );

}


void	test_atoi_base( int ac, char** av ) {

	if ( ac != 2 )
		fatal_error( "./program ft_atoi_base string base\n" );
	if ( !av || !av[0] || !av[1] )
		fatal_error( "String or base is NULL\n" );

	printf( UNDERLINE GREEN "Calling ft_atoi_base" RESET "\n\n" );

	char*	string = av[0];
	char*	base = av[1];

	int		result = ft_atoi_base( string, base );
	if ( !result ) {
		fatal_error( "The result is 0. If your string is not 0 - there is an error in the arguments\n" );
	}
	printf( "The given string is" PURPLE " [%s]" RESET "\n"\
			"The return of ft_atoi_base is" CYAN " [%d]" RESET "\n",
			string, result );

}


t_list*		create_node_with_data_string( char* data ) {

	t_list*		node = calloc( 1, sizeof( t_list ) );
	if ( !node )
		return NULL;

	node->data = ft_strdup( data );
	node->next = NULL;

	return node;
}


void	print_list_with_data_string( t_list *list ) {

	if ( !list )
		printf( "0 nodes\n" );
	int	i = 1;
	while ( list )
	{
		printf( "Node[%d] has data:", i );
		if ( list->data )
			printf( " %s\n", ( char* )( list->data ) );
		else
			printf( "\n" );
		list = list->next;
		i++;
	}

}


void	test_list_push_front( int ac, char** av ) {

	if ( ac != 1 )
		fatal_error( "./program ft_list_push_front data\n" );
	if ( !av || !av[0] )
		fatal_error( "Data is NULL\n" );
	
	t_list*		list;
	//
	//Create first node
	//

	t_list*		first_node = create_node_with_data_string( "middle node" );
	if ( !first_node )
		fatal_error( "Calloc failed for first node of the list\n" );
	list = first_node;

	//
	//Create second node
	//

	t_list*		second_node = create_node_with_data_string( "last node" );
	if ( !second_node )
		fatal_error( "Calloc failed for second node of the list\n" );
	first_node->next = second_node;

	printf( UNDERLINE PURPLE "List before:" RESET "\n" );
	print_list_with_data_string( list );
	printf( "\n" );

	printf( UNDERLINE GREEN "Calling ft_list_push_front" RESET "\n" );
	ft_list_push_front( &list, av[0] );
	print_list_with_data_string( list );

	free( second_node->data );
	free( second_node );
	free( first_node->data );
	free( first_node );
	free( list );

}


void	free_list( t_list* list ) {

	while ( list )
	{
	    t_list	*next_node = list->next;

		if ( list->data )
	    	free( list->data );
	    free( list );

	    list = next_node;
	}

}


void	test_list_size( int ac, char** av ) {

	if ( ac != 1 )
		fatal_error( "./program ft_list_size nb_of_nodes\n" );
	if ( !av || !av[0] )
		fatal_error( "Nb of nodes is missing\n" );

	printf( UNDERLINE GREEN "Calling ft_list_size" RESET "\n\n" );

	int		nb_of_nodes = atoi( av[0] );
	if ( nb_of_nodes < 1 )
		fatal_error( "Give at least 1 node\n" );

	t_list*		list = create_node_with_data_string( "content" );

	t_list*		prev_node = list;
	for ( unsigned int i = 1; i <= ( unsigned int )nb_of_nodes; i++ ) {
		t_list*		node = create_node_with_data_string( "content" );
		if ( !node )
			fatal_error( "Calloc failed to create node\n" );
		prev_node->next = node;
		node->next = NULL;
		prev_node = node;
	}

	print_list_with_data_string( list );
	printf( "\n" );

	unsigned int	result = ft_list_size( list );
	printf( "List has" CYAN " [%d]" RESET " nodes\n", result );
	free_list( list );

}


t_list*		create_list_for_ft_list_sort() {

	t_list*		first_node =  create_node_with_data_string( "0" );

	t_list*		second_node = create_node_with_data_string( "6" );
	first_node->next = second_node;

	t_list*		third_node =  create_node_with_data_string( "1" );
	second_node->next = third_node;

	t_list*		fourth_node = create_node_with_data_string( "8" );
	third_node->next = fourth_node;

	t_list*		fifth_node =  create_node_with_data_string( "1" );
	fourth_node->next = fifth_node;

	return first_node;

}


void	test_list_sort() {

	t_list*		list = create_list_for_ft_list_sort();
	print_list_with_data_string( list );

	printf( UNDERLINE GREEN "Calling ft_list_sort" RESET "\n\n" );
	ft_list_sort( &list, ( int (*)() )ft_strcmp );
	print_list_with_data_string( list );

	free_list( list );

}


t_list*		create_list_for_ft_list_remove_if() {

	t_list*		first_node =  create_node_with_data_string( "remove_hello" );

	t_list*		second_node = create_node_with_data_string( "remove_hello" );
	first_node->next = second_node;

	t_list*		third_node =  create_node_with_data_string( "valid" );
	second_node->next = third_node;

	t_list*		fourth_node = create_node_with_data_string( "valid" );
	third_node->next = fourth_node;

	t_list*		fifth_node =  create_node_with_data_string( "valid" );
	fourth_node->next = fifth_node;

	return first_node;

}


void	free_fct( void*	data ) {

	if ( data )
		free( data );

}

void	test_list_remove_if() {

	t_list*		list = create_list_for_ft_list_remove_if();
	print_list_with_data_string( list );

	char*	data_ref = "remove_hello";
	printf( UNDERLINE GREEN "Calling ft_list_remove_if" RESET "\n\n" );
	if ( list )
		ft_list_remove_if( &list, ( void* )data_ref, ( int (*)() )ft_strcmp,  free_fct );

	print_list_with_data_string( list );
	free_list( list );

}


int	main( int ac, char** av ) {

	if ( ac < 2 ) {
		write( STDERR_FILENO, "./program FUNCTION ARGUMENT(S)\n", strlen( "./program FUNCTION ARGUMENT(S)\n" ) );
		return 1;
	}
	if ( !av[0] || !av[1] )
		fatal_error( "At least one arg is NULL\n" );

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
	else if ( strcmp( av[1], "ft_strdup" ) == 0 )
		test_strdup( ac-2, av+2 );
	else if ( strcmp( av[1], "ft_atoi_base" ) == 0 )
		test_atoi_base( ac-2, av+2 );
	else if ( strcmp( av[1], "ft_list_push_front" ) == 0 )
		test_list_push_front( ac-2, av+2 );
	else if ( strcmp( av[1], "ft_list_size" ) == 0 )
		test_list_size( ac-2, av+2 );
	else if ( strcmp( av[1], "ft_list_sort" ) == 0 )
		test_list_sort();
	else if ( strcmp( av[1], "ft_list_remove_if" ) == 0 )
		test_list_remove_if();
	else
		printf( "Invalid function\n" );

}