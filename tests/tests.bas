/'
	tests -- run the unit tests for libfbcunit.a


	compile all with:

		$ fbc tests.bas fbcu_sanity.bas fbcu_multiple.bas fbcu_global.bas -i ./inc -p ./lib


	or compile just one with:

		$ fbc tests.bas fbcu_sanity.bas -i ./inc -p ./lib


	and run with
		
		$ tests
'/

#include once "fbcunit.bi"

fbcu.run_tests()
