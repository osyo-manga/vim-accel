
let s:type = accel#type#type()

let s:package = accel#create_package("accel#functional")

function! accel#functional#functional()
	return deepcopy(s:package)
endfunction


function! s:applicable(func)
	return s:type.is_dictionary(a:func) && has_key(a:func, "apply")
endfunction


function! accel#functional#apply(func,...)
	if s:applicable(a:func)
		return call(a:func.apply, a:000, a:func)
	elseif s:type.is_function(a:func)
		return call(a:func, a:000)
	else
		return call(function(a:func), a:000)
	endif
endfunction
call s:package.__func__("apply")


function! accel#functional#apply_args_list(func, args)
	return call("accel#functional#apply", [a:func] + a:args)
endfunction
call s:package.__func__("apply_args_list")


function! accel#functional#placeholders(args_no)
	let func = {"args_no" : a:args_no}
	function! func.apply(...) dict
		return a:000[self.args_no]
	endfunction
	return func
endfunction
let accel#functional#_1 = accel#functional#placeholders(0)
let accel#functional#_2 = accel#functional#placeholders(1)
let accel#functional#_3 = accel#functional#placeholders(2)
call s:package.__func__("placeholders")
call s:package.__constant__("_1")
call s:package.__constant__("_2")
call s:package.__constant__("_3")


function! accel#functional#bind(func, ...)
	let func = {"func" : a:func, "args" : a:000}
	function! func.apply(...) dict
		let args=[]
		for var in self.args
			if s:applicable(var)
				call add(args, call(var.apply, a:000, var))
			else
				call add(args, var)
			endif
			unlet var
		endfor
		return accel#functional#apply_args_list(self.func, args)
	endfunction
	return func
endfunction
call s:package.__func__("bind")


function! accel#functional#lambda(lambda)
	let func = { "lambda" : a:lambda }
	function! func.apply(...) dict
		return eval(self.lambda)
	endfunction
	return func
endfunction
call s:package.__func__("lambda")


function! accel#functional#dict_func(func)
	let dict = { "func" : a:func }
	function! dict.apply(...) dict
		return call(self.func, a:000[1:-1], a:1)
	endfunction
	return dict
endfunction
call s:package.__func__("dict_func")


function! accel#functional#var(var)
	let func = { "var" : a:var }
	function! func.apply(...) dict
		return self.var
	endfunction
	retur func
endfunction
call s:package.__func__("var")


function! accel#functional#not(func)
	let func = { "func" : a:func }
	function! func.apply(...) dict
		return !accel#functional#apply_args_list(self.func, a:000)
	endfunction
	return func
endfunction
call s:package.__func__("not")


function! accel#functional#if(pred, then, else)
	let func = { 
		\ "pred" : a:pred,
		\ "then" : a:then,
		\ "else" : a:else
	\}
	function! func.apply(...) dict
		if accel#functional#apply_args_list(self.pred, a:000)
			return accel#functional#apply_args_list(self.then, a:000)
		else
			return accel#functional#apply_args_list(self.else, a:000)
		endif
	endfunction
	return func
endfunction
call s:package.__func__("if")


function! accel#functional#function(func)
	let func = { "func" : a:func }
	function! func.apply(...) dict
		return call(self.func, a:000)
	endfunction
	return func
endfunction
call s:package.__func__("function")



