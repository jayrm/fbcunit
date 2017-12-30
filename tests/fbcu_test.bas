#define FBCU_ENABLE_TRACE 1

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

		CU_ASSERT_TRUE( true )
		CU_ASSERT_FALSE( false )

	END_TEST

	TEST( other_check )
	
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

		CU_ASSERT_TRUE( true )
		CU_ASSERT_FALSE( false )

	END_TEST

END_SUITE

SUITE( fbc_compiler )

	TEST( version )
		
		CU_ASSERT( __FB_VER_MAJOR__ >= 1 )

	END_TEST

END_SUITE
