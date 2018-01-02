#include once "fbcunit.bi"

SUITE( fbcunit )

	TEST( sanity_check )
	
		'' check some basic functions of the FBCU component

		CU_ASSERT( true )

		CU_ASSERT_EQUAL( true, true )
		CU_ASSERT_EQUAL( false, false )
		CU_ASSERT_EQUAL( "A", "A" )
		CU_ASSERT_EQUAL( -1, -1 )

		CU_ASSERT_NOT_EQUAL( false, true )
		CU_ASSERT_NOT_EQUAL( false, true )
		CU_ASSERT_NOT_EQUAL( "A", "B" )
		CU_ASSERT_NOT_EQUAL( -1, 1 )

		CU_ASSERT_DOUBLE_EQUAL( 5.00001, 5, 0.001 )
		CU_ASSERT_DOUBLE_EQUAL( 5, 5.00001, 0.001 )

		CU_ASSERT_TRUE( true )
		CU_ASSERT_FALSE( false )

	END_TEST

END_SUITE
