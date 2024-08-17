
_log_filename = "log"

function log(text, overwrite)
	printh(text, _log_filename, overwrite)
end

function log2(text, formatter, overwrite)
	log(serialize(text), overwrite)
end
