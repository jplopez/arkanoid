_log_fn = "log"
function log(txt, overwrite)
	printh(txt, _log_fn, overwrite)
end
function log2(txt, overwrite)
	log(serialize(txt), overwrite)
end
