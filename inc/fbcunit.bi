#ifndef __FBCUNIT_BI_INCLUDE__
#define __FBCUNIT_BI_INCLUDE__ 1

#inclib "fbcunit"

#ifndef FBCU_NULL
#define FBCU_NULL 0
#endif

#define FBCU_VER_MAJOR 0
#define FBCU_VER_MINOR 1

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
	#error FBCUNIT: test suites can not be nested or missing END_SUITE
	#endif
	#define TMP_FBCUNIT_SUITE_NAME suite_name
	#if FBCU_ENABLE_TRACE<>0
	#print start of suite suite_name
	#endif
	namespace tests.##suite_name
#endmacro

#macro END_SUITE_EMIT( suite_name )
	sub suite_name##_ctor cdecl () constructor 
		fbcu.add_suite( #suite_name )
	end sub
	end namespace
	#if FBCU_ENABLE_TRACE<>0
	#print end of suite suite_name
	#endif
#endmacro

#macro END_SUITE_()
	#if defined( TMP_FBCUNIT_TEST_NAME )
	#error FBCUNIT: missing END_TEST() before END_SUITE
	#endif
	#if defined( TMP_FBCUNIT_SUITE_NAME )
	END_SUITE_EMIT( TMP_FBCUNIT_SUITE_NAME )
	#undef TMP_FBCUNIT_SUITE_NAME
	#else
	#error FBCUNIT: mismatched END_SUITE()
	#endif
#endmacro

#define END_SUITE END_SUITE_()

#macro TEST( test_name )
	#if defined( TMP_FBCUNIT_TEST_NAME )
	#error FBCUNIT: tests can not be nested or missing END_TEST
	#endif
	#define TMP_FBCUNIT_TEST_NAME test_name
	#if FBCU_ENABLE_TRACE<>0
	#print start of test test_name
	#endif
	sub test_name cdecl ()
#endmacro

#macro END_TEST_EMIT( test_name )
	end sub
	sub test_name##_ctor cdecl () constructor
		fbcu.add_test( #test_name, @test_name )
	end sub
	#if FBCU_ENABLE_TRACE<>0
	#print end of test test_name
	#endif
#endmacro

#macro END_TEST_()
	#if defined( TMP_FBCUNIT_TEST_NAME )
	END_TEST_EMIT( TMP_FBCUNIT_TEST_NAME )
	#undef TMP_FBCUNIT_TEST_NAME
	#else
	#error FBCUNIT: mismatched END_TEST
	#endif
#endmacro

#define END_TEST END_TEST_()

namespace fbcu

	declare function find_suite _
		( _
			byval suite_name as zstring ptr = FBCU_NULL _
		) as integer

	declare sub add_suite _
		( _
			byval suite_name as zstring ptr = FBCU_NULL, _
			byval init_proc as function cdecl ( ) as long = FBCU_NULL, _
			byval term_proc as function cdecl ( ) as long = FBCU_NULL _
		)

	declare sub add_test _
		( _
			byval test_name as zstring ptr, _
			byval test_proc as sub cdecl ( ) _
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
