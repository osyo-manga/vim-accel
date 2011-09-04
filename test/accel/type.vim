
let test = accel#test#test()
let type = accel#type#type()

call test.check(type.is_int(10), "is_int1")
call test.check_not(type.is_int(""), "is_int2")
call test.check_equal(type.name(0), "int", "name(int)")

call test.check(type.is_float(0.0), "is_float1")
call test.check_not(type.is_float(""), "is_float2")
call test.check_equal(type.name(0.0), "float", "name(float)")

call test.check(type.is_string("string"), "is_string1")
call test.check_not(type.is_string(0), "is_string2")
call test.check_equal(type.name("string"), "string", "name(string)")

function! Func()
	
endfunction
call test.check(type.is_function(function("Func")), "is_function1")
call test.check_not(type.is_function(""), "is_function2")
call test.check_equal(type.name(function("Func")), "function", "name(function)")

call test.check(type.is_list([]), "is_list1")
call test.check_not(type.is_list(""), "is_list2")
call test.check_equal(type.name([]), "list", "name(list)")

call test.check(type.is_dictionary({}), "is_dictionary1")
call test.check_not(type.is_dictionary(""), "is_dictionary2")
call test.check_equal(type.name({}), "dictionary", "name(dictionary)")




