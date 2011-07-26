
let f    = accel#functional#functional
let test = accel#test#test

function! Plus(a, b)
	return a:a + a:b
endfunction

let minus = {}
function! minus.apply(a, b)
	return a:a - a:b
endfunction

function! s:multiplies(a, b)
	return a:a * a:b
endfunction

call test.check_equal(f.apply("Plus", 2, 5), 7, "apply1")
call test.check_equal(f.apply(function("Plus"), 2, 5), 7, "apply2")
call test.check_equal(f.apply(minus, 8, 3), 5, "apply3")
call test.check_exception_not(f.bind("accel#functional#apply", "s:multiplies", 2, 3), "apply4")

call test.check_equal(f.apply_args_list("Plus", [2, 5]), 7, "apply_args_list1")

call test.check_equal(f.bind("Plus", 2, 5).apply(), 7, "bind1")

call test.check_equal(f.lambda("a:1 + a:2").apply(3, 2), 5, "lambda1")

call test.check_equal(f.dict_func(minus.apply).apply(minus, 5, 2), 3, "dict_func1")

call test.check_equal(f.apply(f.var("100")), 100, "var1")

call test.check(f.not(f.lambda("1 == 0")).apply(), "not1")

let is_even = f.if(f.lambda("(a:1 % 2) == 0"), f.var("yes"), f.var("no"))
call test.check_equal(f.apply(is_even, 2), "yes", "if1")
call test.check_equal(f.apply(is_even, 1), "no" , "if2")

call test.check_equal(f.function("Plus").apply(2, 1), 3, "function1")

