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
