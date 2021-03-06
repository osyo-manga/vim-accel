
function! accel#create_package(name)
	let package = { "__name__" : a:name }
	function! package.__func__(func) dict
		let self[a:func] = function(self.__name__."#".a:func)
	endfunction
	function! package.__constant__(constant) dict
		let self[a:constant] = function(self.__name__."#".a:constant)
	endfunction
	return package
endfunction

let s:package = accel#create_package("accel")
call s:package.__func__("create_package")

function! accel#assert(success, ...)
	if !a:success
		throw "assert: ".(len(a:000) >= 1 ? a:1 : "")
	endif
endfunction
call s:package.__func__("assert")


let accel#false = 0
call s:package.__constant__("false")



let accel#accel = s:package



