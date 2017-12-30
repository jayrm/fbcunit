fbcunit version 0.1
-------------------

	Unit testing component for fbc compiler.  Provides macros 
	and common code for unit testing fbc compiled sources. 


Compiling
---------

	To compile fbcunit library, from top level directory:

		$ make


Testing
-------

	To test the library (with itself), from top level directory:

		$ make tests && ./tests/tests.exe


Installing
----------

	Copy the following files to the appropriate include and 
	library directories:

		./inc/fbcunit.bi
		./lib/libfbcunit.a
	

Usage
-----

	Minimal example program:

		'' tests.bas

		#include "fbcunit.bi"

		SUITE( fbcunit )
			TEST( sanity_check )
				CU_ASSERT( true )
			END_TEST
		END_SUITE

		fbcu.run_tests

	See Also './tests' directory for example of usage


Files
-----

	./readme.txt         this file

	./changelog.txt      changelog for this library

	./makefile           simple makefile for the library and tests

	./inc/fbcunit.bi     header file: include this file in any source
						 modules that define unit test procedures

	./src/tests.bas      main module for this library's tests
						 this module runs the tests

	./src/fbcu_test.bas  a few tests that test the unit test library
						 itself

	./lib/libfbcunit.a   binary of the library
