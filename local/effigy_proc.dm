/*
This file is for jamming single-line procs into /tg/ procs.
It will prevent runtimes and allow their code to run if Effigy's fails.
It will also log when we mess up our code rather than making it vague.

Call it at the top of a stock proc with...

if(effigy_proc(object,proc to call,args)) return

...if you are replacing an entire proc.

The proc you're attemping should return nonzero values on success.
*/

/proc/effigy_proc(callon, procname, list/args=null)
	try
		if(!callon || !procname)
			warning("effigy_proc: Invalid obj/proc: [callon]/[procname]")
			return FALSE

		var/result = call(callon,procname)(arglist(args))

		return result

	catch(var/exception/effigy_exception)
		warning("effigy_proc runtimed when calling [procname] on [callon].")
		warning("effigy_proc catch: [effigy_exception] on [effigy_exception.file]:[effigy_exception.line]")
		log_runtime(effigy_exception)
		return FALSE
