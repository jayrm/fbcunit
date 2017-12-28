#ifndef __FBCUNIT_BI_INCLUDE__
#define __FBCUNIT_BI_INCLUDE__ 1

#inclib "fbcunit"

#ifndef NULL
#define NULL 0
#endif

#define CU_ASSERT( a )               fbcu.CU_ASSERT_( (a), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT(" #a ")" )
#define CU_ASSERT_EQUAL( a, b )      fbcu.CU_ASSERT_( ((a)=(b)), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_EQUAL(" #a "," #b ")" )
#define CU_ASSERT_NOT_EQUAL( a, b )  fbcu.CU_ASSERT_( ((a)<>(b)), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_NOT_EQUAL(" #a "," #b ")" )
#define CU_ASSERT_TRUE( a )          fbcu.CU_ASSERT_( (a)=true, __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_TRUE(" #a ")" )
#define CU_ASSERT_FALSE( a )         fbcu.CU_ASSERT_( (a)=false, __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_FALSE(" #a ")" )
#define CU_FAIL( msg )               fbcu.CU_ASSERT_( false, __FILE__, __LINE__, __FUNCTION__, "CU_FAIL(" #a ")" )
#define CU_FAIL_FATAL( a )           fbcu.CU_ASSERT_FATAL_( false, __FILE__, __LINE__, __FUNCTION__, "CU_FAIL_FATAL(" #a ")" )
#define CU_PASS( msg )               fbcu.CU_ASSERT_( true , __FILE__, __LINE__, __FUNCTION__, "CU_PASS(" #a ")" )

#ifndef FBCU_ENABLE_TRACE
#define FBCU_ENABLE_TRACE 0
#endif

#macro SUITE( suite_name )
	#if defined( TMP_FBCUNIT_SUITE_NAME )
	#error FBCUNIT: test suites can not be nested or missing END_SUITE() 
	#endif
	#define TMP_FBCUNIT_SUITE_NAME suite_name
	#if FBCU_ENABLE_TRACE<>0
	#print start of suite suite_name
	#endif
	namespace tests. ## suite_name
#endmacro

#macro END_SUITE_EMIT( suite_name )
	sub suite_ctor () constructor
		fbcu.add_suite( #suite_name )
	end sub
	end namespace
	#if FBCU_ENABLE_TRACE<>0
	#print end of suite suite_name
	#endif
#endmacro

#macro END_SUITE()
	#if defined( TMP_FBCUNIT_TEST_NAME )
	#error FBCUNIT: missing END_TEST() before END_SUITE()
	#endif
	#if defined( TMP_FBCUNIT_SUITE_NAME )
	END_SUITE_EMIT( TMP_FBCUNIT_SUITE_NAME )
	#undef TMP_FBCUNIT_SUITE_NAME
	#else
	#error FBCUNIT: mismatched END_SUITE()
	#endif
#endmacro

#macro TEST( test_name )
	#if defined( TMP_FBCUNIT_TEST_NAME )
	#error FBCUNIT: tests can not be nested or missing END_TEST()
	#endif
	#define TMP_FBCUNIT_TEST_NAME test_name
	#if FBCU_ENABLE_TRACE<>0
	#print start of test test_name
	#endif
	sub sanity_check cdecl ()
#endmacro

#macro END_TEST_EMIT( test_name )
	end sub
	sub ctor () constructor
		fbcu.add_test( #test_name, @test_name )
	end sub
	#if FBCU_ENABLE_TRACE<>0
	#print end of test test_name
	#endif
#endmacro

#macro END_TEST()
	#if defined( TMP_FBCUNIT_TEST_NAME )
	END_TEST_EMIT( TMP_FBCUNIT_TEST_NAME )
	#undef TMP_FBCUNIT_TEST_NAME
	#else
	#error FBCUNIT: mismatched END_TEST()
	#endif
#endmacro

namespace fbcu

	declare sub add_suite _
		( _
			byval n as zstring ptr = 0, _
			byval init as function cdecl ( ) as long = 0, _
			byval cleanup as function cdecl ( ) as long = 0 _
		)

	declare sub add_test _
		( _
			byval n as zstring ptr, _
			byval s as sub cdecl ( ) _
		)

	declare sub run_tests _
		( _
		)

	declare sub CU_ASSERT_ _
		( _
			byval value as integer, _
			byval fil as zstring ptr, _
			byval lin as integer, _
			byval fun as zstring ptr, _
			byval msg as zstring ptr _
		)

	declare sub CU_ASSERT_FATAL_ _
		( _
			byval value as integer, _
			byval fil as zstring ptr, _
			byval lin as integer, _
			byval fun as zstring ptr, _
			byval msg as zstring ptr _
		)

end namespace

#endif
