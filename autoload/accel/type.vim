

let s:package = accel#create_package("accel#type")

function! accel#type#type()
	return deepcopy(s:package)
endfunction


function! accel#type#name(value)
	let s:typenames = {
		\ type(0)              : "int",
		\ type(0.0)            : "float",
		\ type("")             : "string",
		\ type(function("tr")) : "function",
		\ type([])             : "list",
		\ type({})             : "dictionary"
	\ }
	return s:typenames[type(a:value)]
endfunction
call s:package.__func__("name")


function! accel#type#is_int(value)
	return type(0) == type(a:value)
endfunction
call s:package.__func__("is_int")


function! accel#type#is_float(value)
	return type(0.0) == type(a:value)
endfunction
call s:package.__func__("is_float")


function! accel#type#is_string(value)
	return type("") == type(a:value)
endfunction
call s:package.__func__("is_string")


function! accel#type#is_function(value)
	return type(function("tr")) == type(a:value)
endfunction
call s:package.__func__("is_function")


function! accel#type#is_list(value)
	return type([]) == type(a:value)
endfunction
call s:package.__func__("is_list")


function! accel#type#is_dictionary(value)
	return type({}) == type(a:value)
endfunction
call s:package.__func__("is_dictionary")


