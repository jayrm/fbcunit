#include once "fbcunit.bi"

'' FBCU_SUITE_COUNT_START is a compile time option that can
'' set the starting size of the suite and test tables

#ifndef FBCU_SUITE_COUNT_START
#define FBCU_SUITE_COUNT_START 16
#elseif (FBCU_SUITE_COUNT_START <= 0)
#undef FBCU_SUITE_COUNT_START 16
#define FBCU_SUITE_COUNT_START 16
#endif

'' ------------------
'' module level stuff
'' ------------------

type FBCU_SUITE
	name as string
	name_nocase as string
	init_proc as function cdecl ( ) as long
	term_proc as function cdecl ( ) as long
	test_count as integer
	assert_count as integer
	pass_count as integer
	fail_count as integer
	test_index_head as integer
	test_index_tail as integer
end type

type FBCU_TEST
	name as string
	name_nocase as string
	test_proc as sub cdecl ( )
	suite_index as integer
	assert_count as integer
	pass_count as integer
	fail_count as integer
	test_index_next as integer
end type

redim shared fbcu_suites(1 to FBCU_SUITE_COUNT_START) as FBCU_SUITE
dim shared fbcu_suites_max as integer = FBCU_SUITE_COUNT_START
dim shared fbcu_suites_count as integer = 0

redim shared fbcu_tests(1 to FBCU_SUITE_COUNT_START) as FBCU_TEST
dim shared fbcu_tests_max as integer = FBCU_SUITE_COUNT_START
dim shared fbcu_tests_count as integer = 0

#define INVALID_INDEX 0

dim shared fbcu_suite_default_index as integer = INVALID_INDEX
dim shared fbcu_suite_index as integer = INVALID_INDEX
dim shared fbcu_test_index as integer = INVALID_INDEX

'' --------------------
'' hash for suite names
'' --------------------

declare function hash_compute ( byval s as const zstring ptr ) as uinteger
declare sub hash_grow()
declare function hash_find ( byval s as const zstring ptr ) as integer
declare function hash_add ( byval s as const zstring ptr, byval suite_index as const integer ) as integer

'' NB: hash() table is zero based

#define INVALID_HASH_INDEX -1

redim shared hash( 0 to FBCU_SUITE_COUNT_START*2 - 1) as integer
dim shared hash_size as integer = FBCU_SUITE_COUNT_START*2
dim shared hash_count as integer

private function hash_compute ( byval s as const zstring ptr ) as uinteger
	dim index as uinteger = 0, n as integer = len( *s )
	for i as integer = 0 to n-1
		index += s[i] + ( index shl 3 )
	next i
	function = index shl 4
end function

private sub hash_grow()
	hash_size *= 2
	redim hash(0 to hash_size-1) as integer
	for index as integer = 0 to hash_size-1
		hash(index) = 0
	next
	for index as integer = 1 to fbcu_suites_count
		hash_add( strptr(fbcu_suites(index).name_nocase), index )
	next 
end sub

'' returns index in to hash()
private function hash_find ( byval s as const zstring ptr ) as integer
	dim index as integer = hash_compute( s ) mod hash_size
	dim start as integer = index
	while( hash(index) )
		if( *s = fbcu_suites(hash(index)).name_nocase ) then
			exit while
		end if
		index += 1
		index mod= hash_size
		if( index = start ) then
			return INVALID_HASH_INDEX
		end if
	wend
	function = index
end function

'' returns index in to hash()
private function hash_add ( byval s as const zstring ptr, byval suite_index as const integer ) as integer
	dim index as integer = hash_find( s )
	if( index ) then
		if( hash(index) = INVALID_INDEX ) then
			hash(index) = suite_index
			hash_count += 1
			if( hash_count > (hash_size \ 2) ) then
				hash_grow()
				index = hash_find( s )
			end if
		end if
		function = index
	else
		function = INVALID_HASH_INDEX
	end if
end function


'' ----------------------
'' fbcunit implementation
'' ----------------------

namespace fbcu

	''
	function find_suite _
		( _
			byval suite_name as zstring ptr = FBCU_NULL _
		) as long

		if( suite_name = FBCU_NULL ) then
			return INVALID_INDEX
		end if

		dim s as string = lcase( *suite_name )

		dim index as integer = hash_find(strptr(s))
		if( index ) then
			function = hash(index)
		else
			function = INVALID_INDEX
		end if

		return INVALID_INDEX

	end function

	''
	sub add_suite _
		( _
			byval suite_name as zstring ptr = FBCU_NULL, _
			byval init_proc as function cdecl ( ) as long = FBCU_NULL, _
			byval term_proc as function cdecl ( ) as long = FBCU_NULL _
		)
		
		fbcu_suite_index = find_suite( suite_name )

		if( fbcu_suite_index <> INVALID_INDEX ) then
			exit sub
		end if

		if( fbcu_suites_count >= fbcu_suites_max ) then
			fbcu_suites_max = fbcu_suites_max * 2
			redim preserve fbcu_suites( 1 to fbcu_suites_max )
		end if

		fbcu_suites_count += 1
		fbcu_suite_index = fbcu_suites_count

		with fbcu_suites( fbcu_suite_index )
			if( suite_name ) then
				.name = *suite_name
			else
				.name = "[global]"
			end if

			.name_nocase = lcase(.name)

			hash_add( strptr(.name_nocase), fbcu_suite_index )

			.init_proc = init_proc
			.term_proc = term_proc
			.test_count = 0
			.assert_count = 0
			.pass_count = 0
			.fail_count = 0
			.test_index_head = INVALID_INDEX
			.test_index_tail = INVALID_INDEX

		end with

	end sub

	''
	function get_suite_name _
		( _
		) as const zstring ptr

		if( fbcu_suite_index > 0 ) then
			function = strptr( fbcu_suites( fbcu_suite_index ).name )
		else
			function = FBCU_NULL
		end if

	end function

	''
	sub add_test _
		( _
			byval test_name as zstring ptr, _
			byval test_proc as sub cdecl ( ), _
			byval is_global as boolean = false _
		)
		
		if( is_global ) then
			fbcu_suite_index = fbcu_suite_default_index
		end if
		
		if( fbcu_suite_index = INVALID_INDEX ) then
			add_suite( )
		end if

		if( fbcu_tests_count >= fbcu_tests_max ) then
			fbcu_tests_max = fbcu_tests_max * 2
			redim preserve fbcu_tests( 1 to fbcu_tests_max )
		end if
			
		fbcu_tests_count += 1
		fbcu_test_index = fbcu_tests_count

		with fbcu_suites( fbcu_suite_index )
			.test_count += 1
		end with

		with fbcu_tests( fbcu_test_index )
			if( test_name ) then
				.name = *test_name
			else
				.name = "[test*" & fbcu_test_index & "]"
			end if

			.test_proc = test_proc
			.suite_index = fbcu_suite_index
			.assert_count = 0
			.pass_count = 0
			.fail_count = 0
			.test_index_next = INVALID_INDEX

		end with

		if( fbcu_suites( fbcu_suite_index ).test_index_head = INVALID_INDEX ) then
			fbcu_suites( fbcu_suite_index ).test_index_head = fbcu_test_index
		else
			fbcu_tests( fbcu_suites( fbcu_suite_index ).test_index_tail ).test_index_next = fbcu_test_index
		end if
		fbcu_suites( fbcu_suite_index ).test_index_tail = fbcu_test_index
		
		

		if( is_global ) then
			fbcu_suite_default_index = fbcu_suite_index
		end if

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
			byval show_summary as boolean = true _
		)

		print "--------------------------------------------------------------------------------"
		print date & " " & time
		print
		print "TESTS"
		print

		for fbcu_suite_index = 1 to fbcu_suites_count

			with fbcu_suites( fbcu_suite_index )

				print "  "; .name

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

				fbcu_test_index = .test_index_head

				while( fbcu_test_index <> INVALID_INDEX )

					with fbcu_tests( fbcu_test_index )
						if( .suite_index = fbcu_suite_index ) then

							print "    "; .name

							if( .test_proc ) then
								.test_proc()
							end if
						end if

						fbcu_test_index = .test_index_next

					end with

				wend

				if( .term_proc ) then
					.term_proc()
				end if
			end with

		next

		if( show_summary ) then
			show_results()
		end if

	end sub

	''
	sub show_results _
		( _
		)

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

		for fbcu_suite_index as integer = 1 to fbcu_suites_count

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
			byval value as long, _
			byval fil as zstring ptr, _
			byval lin as long, _
			byval fun as zstring ptr, _
			byval msg as zstring ptr _
		)

		if( fbcu_suite_index = INVALID_INDEX ) then	
			add_suite( )
		end if

		if( fbcu_test_index = INVALID_INDEX ) then	
			add_test( )
		end if

		'' increment assertions for current suite
		fbcu_suites( fbcu_suite_index ).assert_count += 1

		'' increment assertions for current test
		fbcu_tests( fbcu_test_index ).assert_count += 1

		'' pass
		if( value ) then
			'' increment pass for current suite
			fbcu_suites( fbcu_suite_index ).pass_count += 1
			fbcu_tests( fbcu_test_index ).pass_count += 1

		'' fail
		else
			'' increment fail for current suite
			fbcu_suites( fbcu_suite_index ).fail_count += 1
			fbcu_tests( fbcu_test_index ).fail_count += 1
			print "      "; *fil & "(" & lin & ") : error : " & *fun & " " & *msg

		end if

	end sub

	''
	sub CU_ASSERT_FATAL_ _
		( _
			byval value as long, _
			byval fil as zstring ptr, _
			byval lin as long, _
			byval fun as zstring ptr, _
			byval msg as zstring ptr _
		)

		CU_ASSERT_( value, fil, lin, fun, msg )

		end(1)

	end sub

end namespace
