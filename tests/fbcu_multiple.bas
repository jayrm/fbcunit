#include once "fbcunit.bi"

SUITE( multiple1 )

	TEST( first )
		CU_ASSERT( true )
	END_TEST

	TEST( second )
		CU_ASSERT( true )
	END_TEST

END_SUITE

SUITE( multiple2 )

	TEST( first )
		CU_ASSERT( true )
	END_TEST

	TEST( second )
		CU_ASSERT( true )
	END_TEST

END_SUITE
