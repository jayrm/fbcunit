'$lang: "qb"

option explicit
'$include: "fbcunit.bi"

const false = 0, true = not false

SUITE( ex )

	TEST( first )
		CU_ASSERT( true )
	END_TEST

END_SUITE

fbcu.run_tests
