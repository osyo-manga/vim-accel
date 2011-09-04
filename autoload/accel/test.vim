
let s:package = accel#create_package("accel#test")

function! accel#test#test()
	return deepcopy(s:package)
endfunction

let s:f = accel#functional#functional()

function! s:check_impl(is_success, msg, failed_msg)
	if a:is_success
		echo "***success***"
		echo a:msg
	else
		echo "****failed****"
		echo a:msg
		echo a:failed_msg
	endif
endfunction

function! accel#test#check(check, msg)
	call s:check_impl(a:check, "check:".a:msg, "")
endfunction
let s:package.__func__("check")


function! accel#test#check_not(check, msg)
	call s:check_impl(!a:check, "check_not:".a:msg, "")
endfunction
let s:package.__func__("check_not")


function! accel#test#check_equal(a, b, msg)
	call s:check_impl(a:a == a:b, "check_equal:".a:msg, a:a." == ".a:b)
endfunction
let s:package.__func__("check_equal")


function! accel#test#check_equal_not(a, b, msg)
	call s:check_impl(a:a != a:b, "check_equal_not:".a:msg, a:a." != ".a:b)
endfunction
let s:package.__func__("check_equal_not")


function! accel#test#check_func(func, msg)
	call s:check_impl(s:f.apply(a:func), "check_func:".a:msg, a:func)
endfunction
let s:package.__func__("check_func")


function! accel#test#check_func_not(func, msg)
	call s:check_impl(!s:f.apply(a:func), "check_func_not:".a:msg, a:func)
endfunction
let s:package.__func__("check_func_not")


function! accel#test#check_exception(func, msg)
	let is_success = 0
	let failed_msg = ""
	try
		call s:f.apply(a:func)
		let is_success = 1
		let failed_msg = ""
	catch /.*/
		let is_success = 0
		let failed_msg = v:exception
	endtry
	call s:check_impl(is_success, "check_exception:".a:msg, a:func)
endfunction
let s:package.__func__("check_exception")


function! accel#test#check_exception_not(func, msg)
	let is_success = 0
	let failed_msg = ""
	try
		call s:f.apply(a:func)
		let is_success = 0
		let failed_msg = ""
	catch /.*/
		let is_success = 1
		let failed_msg = v:exception
	endtry
	call s:check_impl(is_success, "check_exception:".failed_msg.":".a:msg, a:func)
endfunction
let s:package.__func__("check_exception_not")


