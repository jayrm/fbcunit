/'
	fbcunit example #6 -- ex06.bas

		- usage in -lang qb
'/

'$lang: "qb"

option explicit
'$include: "fbcunit.bi"

SUITE( qb )

	TEST( qb )
		CU_ASSERT( 1 )
	END_TEST

END_SUITE

fbcu.run_tests
