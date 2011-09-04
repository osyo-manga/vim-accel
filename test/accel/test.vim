
let test = accel#test#test()

call test.check    (1 == 1, "check")
call test.check_not(1 != 1, "check_not")
call test.check_equal    (2, 2, "check_equal")
call test.check_equal_not(2, 1, "check_equal_not")

function! True()
	return 1
endfunction

function! False()
	return 0
endfunction

call test.check_func    ("True",  "check_func")
call test.check_func_not("False", "check_func_not")

function! NoException()
	
endfunction

function! Exception()
	throw "Exception"
endfunction

call test.check_exception    ("NoException", "check_exception")
call test.check_exception_not("Exception",   "check_exception_not")


