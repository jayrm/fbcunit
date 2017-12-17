fbcunit
-------

Basic unit testing


Compiling
---------

Invoke 'make' in the top level directory to build the library


Installing
----------

copy './lib/win32/libfbcunit.a' to 'fbc-path/lib/win32/'
copy './inc/fbcunit.bi' to 'fbc-path/inc/'


Usage
-----

See './tests' directory for example of usage


Directories
-----------

./src       source file
./inc       header file 'fbcunit.bi' include this file in any source
            modules that define unit test procedures
./tests     a test module for the fbcunit itself.  Also provides
            a template to create a tests directory for a project
./lib/win32 output directory for library
