#include once "fbcunit.bi"

'' tests added to global suite

TEST( default1 )
	CU_ASSERT( true )
END_TEST

TEST( default2 )
	CU_ASSERT( true )
END_TEST

TEST( default3 )
	CU_ASSERT( true )
END_TEST

SUITE( some_other_suite )

	TEST( first )
		CU_ASSERT( true )
	END_TEST

	TEST( second )
		CU_ASSERT( true )
	END_TEST

END_SUITE

'' tests added to global suite

TEST( default4 )
	CU_ASSERT( true )
END_TEST

TEST( default5 )
	CU_ASSERT( true )
END_TEST
