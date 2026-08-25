# int	atoi( const char *str );

## str is NULL
	atoi segfault

## str is -0
	atoi: 0

## only 1 sign is allowed

	+9 -> 9
	-9 -> 9

	--9 -> 0 (error)

## overflow
	-1 error
	unpredictable behaviour
	can be any number

## can have any chars after number

	a123 -> error
	123a -> 123
	ignores all that is after the number