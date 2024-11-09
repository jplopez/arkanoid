_log_fn = "log"
function log(txt,overwrite)
  if(type(txt)=="table")txt=serialize(txt)
  printh(txt,_log_fn,overwrite)
end