/'
	fbcunit example #5 -- ex05.bas

		- disable the helper macros
		- add the suite and tests directly using
		  fbcu interface
'/

#define FBCU_ENABLE_MACROS 0

#include once "fbcunit.bi"

namespace ex05

	function init cdecl () as long 
		function = true
	end function

	function cleanup cdecl () as long 
		function = true
	end function

	sub test1 cdecl ()
		CU_ASSERT( true )
	end sub

	sub test2 cdecl ()
		CU_ASSERT( true )
	end sub

	sub ctor cdecl () constructor
		fbcu.add_suite( "ex05", @init, @cleanup )
		fbcu.add_test( "test1", @test1 )
		fbcu.add_test( "test2", @test2 )
	end sub

end namespace

fbcu.run_tests
