
function! accel#create_package(name)
	let package = { "name" : a:name }
	function! package.__func__(func) dict
		let self[a:func] = function(self.name."#".a:func)
	endfunction
	function! package.__constant__(constant) dict
		let self[a:constant] = function(self.name."#".a:constant)
	endfunction
	return package
endfunction

let s:package = accel#create_package("accel")
call s:package.__func__("crete_func_table")

function! accel#assert(success, ...)
	if !a:success
		throw "assert: ".(len(a:000) >= 1 ? a:1 : "")
	endif
endfunction
call s:package.__func__("assert")

let accel#accel = s:package



