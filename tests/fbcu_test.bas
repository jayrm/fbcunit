#include once "fbcunit.bi"

namespace tests.fbcunit

	sub sanity_check cdecl ()

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

	end sub

	sub ctor () constructor
		fbcu.add_suite( "tests.fbcunit" )
		fbcu.add_test( "sanity_check", @sanity_check )
	end sub

end namespace
