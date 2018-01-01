/'
	fbcunit example #7 -- ex07.bas

		- usage in -lang qb
		- SUITE_INIT & SUITE_CLEANUP need to set
		  the return value
'/

'$lang: "qb"

option explicit
'$include: "fbcunit.bi"

const false = 0, true = not false

SUITE( qb_example )

	SUITE_INIT
		qb_example.init = true
	END_SUITE_INIT

	SUITE_CLEANUP
		qb_example.cleanup = true
	END_SUITE_CLEANUP

	TEST( always_true )
		CU_ASSERT( true )
	END_TEST

END_SUITE

fbcu.run_tests