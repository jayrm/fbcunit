#ifndef __FBCUNIT_BI_INCLUDE__
#define __FBCUNIT_BI_INCLUDE__ 1

#inclib "fbcunit"

#define FBCU_VER_MAJOR 0
#define FBCU_VER_MINOR 1

#ifndef FBCU_NULL
#define FBCU_NULL 0
#endif

#define CU_ASSERT( a )               fbcu.CU_ASSERT_( (a), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT(" #a ")" )
#define CU_ASSERT_EQUAL( a, b )      fbcu.CU_ASSERT_( ((a)=(b)), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_EQUAL(" #a "," #b ")" )
#define CU_ASSERT_NOT_EQUAL( a, b )  fbcu.CU_ASSERT_( ((a)<>(b)), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_NOT_EQUAL(" #a "," #b ")" )
#define CU_ASSERT_TRUE( a )          fbcu.CU_ASSERT_( (a)=true, __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_TRUE(" #a ")" )
#define CU_ASSERT_FALSE( a )         fbcu.CU_ASSERT_( (a)=false, __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_FALSE(" #a ")" )
#define CU_FAIL( msg )               fbcu.CU_ASSERT_( false, __FILE__, __LINE__, __FUNCTION__, "CU_FAIL(" #a ")" )
#define CU_FAIL_FATAL( a )           fbcu.CU_ASSERT_FATAL_( false, __FILE__, __LINE__, __FUNCTION__, "CU_FAIL_FATAL(" #a ")" )
#define CU_PASS( msg )               fbcu.CU_ASSERT_( true , __FILE__, __LINE__, __FUNCTION__, "CU_PASS(" #a ")" )

#if not defined(FBCU_ENABLE_MACROS)
	/'
	Enable the helper macros by default.  To disable the
	helper macros, FBCU_ENABLE_MACROS must be defined to
	0 before including this file.
	'/
	#define FBCU_ENABLE_MACROS 1
#endif

#if not defined(FBCU_ENABLE_CHECKS)
	/'
	Enable the name collision checks by default.  To disable
	the checks, FBCU_ENABLE_CHECKS must be defined to 0
	before including this file.
	'/
	#define FBCU_ENABLE_CHECKS 1
#endif

#if not defined(FBCU_ENABLE_TRACE)
	/'
	Disable helper macro tracing by default.  To enable
	tracing, FBCU_ENABLE_TRACE must be defined to any
	integer other than 0 before including this file.
	'/
	#define FBCU_ENABLE_TRACE 0
#endif


''
#if ((FBCU_ENABLE_MACROS<>0) and (FBCU_ENABLE_CHECKS<>0))

#if defined(TMP_FBCUNIT_SUITE_NAME)
	#error "TMP_FBCUNIT_SUITE_NAME" symbol is reserved for fbcunit
#endif
#if defined(TMP_FBCUNIT_TEST_NAME)
	#error "TMP_FBCUNIT_TEST_NAME" symbol is reserved for fbcunit
#endif
#if defined(TMP_FBCUNIT_SUITE_IN_INIT)
	#error "TMP_FBCUNIT_SUITE_IN_INIT" symbol is reserved for fbcunit
#endif
#if defined(TMP_FBCUNIT_SUITE_HAVE_INIT)
	#error "TMP_FBCUNIT_SUITE_HAVE_INIT" symbol is reserved for fbcunit
#endif
#if defined(TMP_FBCUNIT_SUITE_IN_CLEANUP)
	#error "TMP_FBCUNIT_SUITE_IN_CLEANUP" symbol is reserved for fbcunit
#endif
#if defined(TMP_FBCUNIT_SUITE_HAVE_CLEANUP)
	#error "TMP_FBCUNIT_SUITE_HAVE_CLEANUP" symbol is reserved for fbcunit
#endif
#if defined(SUITE)
	#error "SUITE" symbol is reserved for fbcunit
#endif
#if defined(END_SUITE)
	#error "END_SUITE" symbol is reserved for fbcunit
#endif
#if defined(END_SUITE_EMIT)
	#error "END_SUITE_EMIT" symbol is reserved for fbcunit
#endif
#if defined(TEST)
	#error "TEST" symbol is reserved for fbcunit
#endif
#if defined(END_TEST)
	#error "END_TEST" symbol is reserved for fbcunit
#endif
#if defined(END_TEST_EMIT)
	#error "END_TEST_EMIT" symbol is reserved for fbcunit
#endif

#endif '' ((FBCU_ENABLE_MACROS<>0) and (FBCU_ENABLE_CHECKS<>0))


''
#if (FBCU_ENABLE_MACROS<>0)

#macro SUITE( suite_name )
	#if defined( TMP_FBCUNIT_SUITE_NAME )
		#error FBCUNIT: test suites can not be nested, or missing "END_SUITE" before "SUITE"
	#endif
	#define TMP_FBCUNIT_SUITE_NAME suite_name
	#if (FBCU_ENABLE_TRACE<>0)
	#print FBCU_TRACE: "SUITE" suite_name
	#endif
	namespace tests.##suite_name
#endmacro

#macro END_SUITE_EMIT( suite_name )
		sub suite_name##_ctor cdecl () constructor 
			#if (defined( TMP_FBCUNIT_SUITE_HAVE_INIT ) andalso defined( TMP_FBCUNIT_SUITE_HAVE_CLEANUP ))
				fbcu.add_suite( #suite_name, procptr(init), procptr(cleanup) )
			#elseif defined( TMP_FBCUNIT_SUITE_HAVE_INIT )
				fbcu.add_suite( #suite_name, procptr(init), FBCU_NULL )
			#elseif defined( TMP_FBCUNIT_SUITE_HAVE_CLEANUP )
				fbcu.add_suite( #suite_name, FBCU_NULL, procptr(cleanup) )
			#else
				fbcu.add_suite( #suite_name )
			#endif
		end sub
	end namespace
	#if (FBCU_ENABLE_TRACE<>0)
		#print FBCU_TRACE: "END_SUITE" suite_name
	#endif
#endmacro

#macro END_SUITE
	#if not defined( TMP_FBCUNIT_SUITE_NAME )
		#error FBCUNIT: unexpected "END_SUITE"
	#elseif defined( TMP_FBCUNIT_TEST_NAME )
		#error FBCUNIT: missing "END_TEST" before "END_SUITE"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_INIT )
		#error FBCUNIT: missing "END_SUITE_INIT" before "END_SUITE"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_CLEANUP )
		#error FBCUNIT: missing "END_SUITE_CLEANUP" before "END_SUITE"
	#endif

	#if defined( TMP_FBCUNIT_SUITE_NAME )
		END_SUITE_EMIT( TMP_FBCUNIT_SUITE_NAME )
	#else
		#error FBCUNIT: mismatched "END_SUITE"
	#endif

	#undef TMP_FBCUNIT_SUITE_NAME
	#undef TMP_FBCUNIT_SUITE_IN_INIT
	#undef TMP_FBCUNIT_SUITE_HAVE_INIT
	#undef TMP_FBCUNIT_SUITE_IN_CLEANUP
	#undef TMP_FBCUNIT_SUITE_HAVE_CLEANUP

#endmacro

#macro SUITE_INIT
	#if not defined( TMP_FBCUNIT_SUITE_NAME )
		#error FBCUNIT: unexpected "SUITE_INIT"
	#elseif defined( TMP_FBCUNIT_TEST_NAME )
		#error FBCUNIT: missing "END_TEST" before "SUITE_INIT"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_CLEANUP )
		#error FBCUNIT: missing "END_SUITE_CLEANUP" before "SUITE_INIT"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_INIT )
		#error FBCUNIT: "SUITE_INIT" can only be used once per "SUITE"
	#elseif defined( TMP_FBCUNIT_SUITE_HAVE_INIT )
		#error FBCUNIT: "SUITE_INIT" can only be used once per "SUITE"
	#endif
	#define TMP_FBCUNIT_SUITE_HAVE_INIT
	#define TMP_FBCUNIT_SUITE_IN_INIT
	function init cdecl () as long
	#if (FBCU_ENABLE_TRACE<>0)
	#print FBCU_TRACE:     "SUITE_INIT"
	#endif
#endmacro

#macro END_SUITE_INIT
	#if not defined( TMP_FBCUNIT_SUITE_NAME )
		#error FBCUNIT: unexpected "END_SUITE_INIT"
	#elseif defined( TMP_FBCUNIT_TEST_NAME )
		#error FBCUNIT: missing "END_TEST" before "END_SUITE_INIT"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_CLEANUP )
		#error FBCUNIT: mismatched END_SUITE_INIT
	#endif
	end function
	#undef TMP_FBCUNIT_SUITE_IN_INIT
	#if (FBCU_ENABLE_TRACE<>0)
	#print FBCU_TRACE:     "END_SUITE_INIT"
	#endif
#endmacro

#macro SUITE_CLEANUP
	#if not defined( TMP_FBCUNIT_SUITE_NAME )
		#error FBCUNIT: unexpected "SUITE_CLEANUP"
	#elseif defined( TMP_FBCUNIT_TEST_NAME )
		#error FBCUNIT: missing "END_TEST" before "SUITE_CLEANUP"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_INIT )
		#error FBCUNIT: missing "END_SUITE_INIT" before "SUITE_CLEANUP"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_CLEANUP )
		#error FBCUNIT: "SUITE_CLEANUP" can only be used once per "SUITE"
	#elseif defined( TMP_FBCUNIT_SUITE_HAVE_CLEANUP )
		#error FBCUNIT: "SUITE_CLEANUP" can only be used once per "SUITE"
	#endif
	#define TMP_FBCUNIT_SUITE_HAVE_CLEANUP
	#define TMP_FBCUNIT_SUITE_IN_CLEANUP
	function cleanup cdecl () as long
	#if (FBCU_ENABLE_TRACE<>0)
	#print FBCU_TRACE:    "SUITE_EXIT"
	#endif
#endmacro

#macro END_SUITE_CLEANUP
	#if not defined( TMP_FBCUNIT_SUITE_NAME )
		#error FBCUNIT: unexpected "END_SUITE_CLEANUP"
	#elseif defined( TMP_FBCUNIT_TEST_NAME )
		#error FBCUNIT: missing "END_TEST" before "END_SUITE_CLEANUP"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_INIT )
		#error FBCUNIT: mismatched "END_SUITE_CLEANUP"
	#endif
	end function
	#undef TMP_FBCUNIT_SUITE_IN_CLEANUP
	#if (FBCU_ENABLE_TRACE<>0)
	#print FBCU_TRACE:     "END_SUITE_EXIT"
	#endif
#endmacro

#macro TEST( test_name )
	#if defined( TMP_FBCUNIT_TEST_NAME )
		#error FBCUNIT: tests can not be nested or missing "END_TEST"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_INIT )
		#error FBCUNIT: missing "END_SUITE_INIT" before "TEST"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_CLEANUP )
		#error FBCUNIT: missing "END_SUITE_CLEANUP" before "TEST"
	#endif
	#define TMP_FBCUNIT_TEST_NAME test_name
	#if (FBCU_ENABLE_TRACE<>0)
	#print FBCU_TRACE:     "TEST" test_name
	#endif
	sub test_name cdecl ()
#endmacro

#macro END_TEST_EMIT( test_name )
	end sub
	sub test_name##_ctor cdecl () constructor
	#if defined( TMP_FBCUNIT_SUITE_NAME )
		fbcu.add_test( #test_name, @test_name, false )
	#else
		fbcu.add_test( #test_name, @test_name, true )
	#endif
	end sub
	#if (FBCU_ENABLE_TRACE<>0)
	#print FBCU_TRACE:     "END_TEST" test_name
	#endif
#endmacro

#macro END_TEST
	#if defined( TMP_FBCUNIT_TEST_NAME )
		END_TEST_EMIT( TMP_FBCUNIT_TEST_NAME )
	#else
		#error FBCUNIT: mismatched "END_TEST"
	#endif
	#undef TMP_FBCUNIT_TEST_NAME
#endmacro

#endif '' (FBCU_ENABLE_MACROS<>0)

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

	declare function get_suite_name _
		( _
		) as const zstring ptr

	declare sub add_test _
		( _
			byval test_name as zstring ptr = FBCU_NULL, _
			byval test_proc as sub cdecl ( ) = FBCU_NULL, _
			byval is_global as boolean = false _
		)

	declare sub run_tests _
		( _
			byval show_summary as boolean = true _
		)

	declare sub show_results _
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
