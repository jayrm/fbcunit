''  fbcunit - FreeBASIC Unit Testing Component
''	Copyright (C) 2017 Jeffery R. Marshall (coder[at]execulink[dot]com)

#include once "crt/stdio.bi"
#include once "fbcunit_console.bi"

'' chng: written [jeffm]

''
sub crt_print_output _
	( _
		byref s as const string _
	) 

	fprintf( stdout, "%s", strptr(s) )

end sub
