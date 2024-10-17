_log_fn = "log"
function log(txt,overwrite)
  if(type(txt)=="table")txt=serialize(txt)
  printh(txt,_log_fn,overwrite)
end
function log2(txt,overwrite)log(serialize(txt),overwrite)end

function l(txt, ow, ...)log(txt,ow)log({...})end