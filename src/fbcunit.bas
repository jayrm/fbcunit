#include once "fbcunit.bi"

type FBCU_SUITE
	name as string
	init_proc as function cdecl ( ) as long
	term_proc as function cdecl ( ) as long
	test_count as integer
	assert_count as integer
	pass_count as integer
	fail_count as integer
end type

type FBCU_TEST
	name as string
	test_proc as sub cdecl ( )
	suite_index as integer
	assert_count as integer
	pass_count as integer
	fail_count as integer
end type

redim shared fbcu_suites(1 to 16) as FBCU_SUITE
dim shared fbcu_suites_max as integer = 16
dim shared fbcu_suites_count as integer = 0
dim shared fbcu_suite_index as integer = 0

redim shared fbcu_tests(1 to 16) as FBCU_TEST
dim shared fbcu_tests_max as integer = 16
dim shared fbcu_tests_count as integer = 0

namespace fbcu

	''
	sub add_suite _
		( _
			byval n as zstring ptr = 0, _
			byval init as function cdecl ( ) as long = 0, _
			byval cleanup as function cdecl ( ) as long = 0 _
		)
		
		if( fbcu_suites_count >= fbcu_suites_max ) then
			fbcu_suites_max = fbcu_suites_max * 2
			redim preserve fbcu_suites( 1 to fbcu_suites_max )
		end if

		fbcu_suites_count += 1
		fbcu_suite_index = fbcu_suites_count

		with fbcu_suites( fbcu_suite_index )
			if( n ) then
				.name = *n
			else
				.name = "[global*" & fbcu_suite_index & "]"
			end if

			.init_proc = init
			.term_proc = cleanup
			.test_count = 0
			.assert_count = 0
			.pass_count = 0
			.fail_count = 0

		end with
		
	end sub

	''
	sub add_test _
		( _
			byval n as zstring ptr, _
			byval s as sub cdecl ( ) _
		)

		if( fbcu_suite_index = 0 ) then	
			add_suite( )
		end if

		if( fbcu_tests_count >= fbcu_tests_max ) then
			fbcu_tests_max = fbcu_tests_max * 2
			redim preserve fbcu_tests( 1 to fbcu_tests_max )
		end if
			
		fbcu_tests_count += 1

		with fbcu_suites( fbcu_suite_index )
			.test_count += 1
		end with

		with fbcu_tests( fbcu_tests_count )
			if( n ) then
				.name = *n
			else
				.name = "[test*" & fbcu_tests_count & "]"
			end if

			.test_proc = s
			.suite_index = fbcu_suite_index
			.assert_count = 0
			.pass_count = 0
			.fail_count = 0
		end with

	end sub

	''
	private function ljust( byref v as const string, byval w as const integer ) as string
		function = left( v & string( w, asc( " " )), w )
	end function

	''
	private function rjust( byref v as const string, byval w as const integer ) as string
		function = right( string( w, asc( " " )) & v, w )
	end function

	''
	sub run_tests _
		( _
		)

		print "--------------------------------------------------------------------------------"
		print date & " " & time
		print
		print "TESTS STARTED"
		print

		for fbcu_suite_index = 1 to fbcu_suites_count

			with fbcu_suites( fbcu_suite_index )

				print .name

				.assert_count = 0
				.pass_count = 0
				.fail_count = 0

				if( .init_proc ) then
					if( .init_proc() ) then
						'' !!! record success
					else
						'' !!! record failure
					end if
				end if

				for i as integer = 1 to fbcu_tests_count

					with fbcu_tests( i )
						if( .suite_index = fbcu_suite_index ) then

							print "  "; .name

							if( .test_proc ) then
								.test_proc()
							end if
						end if
					end with

				next

				if( .term_proc ) then
					.term_proc()
				end if
			end with

		next

		dim t_assert_count as integer = 0
		dim t_pass_count as integer = 0
		dim t_fail_count as integer = 0
		dim t_test_count as integer = 0
		dim x as string = ""

		print
		print "SUMMARY"
		print
		print " Asserts    Passed    Failed  Suite                                        Tests" 
		print "--------  --------  --------  ----------------------------------------  --------"

		for fbcu_suite_index = 1 to fbcu_suites_count

			with fbcu_suites( fbcu_suite_index )

				t_test_count += .test_count
				t_assert_count += .assert_count
				t_pass_count += .pass_count
				t_fail_count += .fail_count

				x = ""
				x &= rjust( "" & .assert_count, 8 )
				x &= "  "
				x &= rjust( "" & .pass_count, 8 )
				x &= "  "
				x &= rjust( "" & .fail_count, 8 )
				x &= "  "
				x &= ljust( "" & .name, 40 )
				x &= "  "
				x &= rjust( "" & .test_count, 8 )

				print x

			end with

		next 

		print "--------  --------  --------  ----------------------------------------  --------"

		x = ""
		x &= rjust( "" & t_assert_count, 8 )
		x &= "  "
		x &= rjust( "" & t_pass_count, 8 )
		x &= "  "
		x &= rjust( "" & t_fail_count, 8 )
		x &= "  "
		x &= ljust( "Total", 40 )
		x &= "  "
		x &= rjust( "" & t_test_count, 8 )

		print x
		print

	end sub

	''
	sub CU_ASSERT_ _
		( _
			byval value as integer, _
			byval fil as zstring ptr, _
			byval lin as integer, _
			byval fun as zstring ptr, _
			byval msg as zstring ptr _
		)

		if( fbcu_suite_index = 0 ) then	
			add_suite( )
		end if

		'' increment assertions for current suite
		fbcu_suites( fbcu_suite_index ).assert_count += 1

		'' pass
		if( value ) then
			'' increment pass for current suite
			fbcu_suites( fbcu_suite_index ).pass_count += 1

		'' fail
		else
			'' increment fail for current suite
			fbcu_suites( fbcu_suite_index ).fail_count += 1
			print "    "; *fil & "(" & lin & ") : error : " & *fun & " " & *msg

		end if

	end sub

	''
	sub CU_ASSERT_FATAL_ _
		( _
			byval value as integer, _
			byval fil as zstring ptr, _
			byval lin as integer, _
			byval fun as zstring ptr, _
			byval msg as zstring ptr _
		)

		CU_ASSERT_( value, fil, lin, fun, msg )

		end(1)

	end sub

end namespace
