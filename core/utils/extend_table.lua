--[[
  Copy All Key-Value Pairs: The function copies all 
    key-value pairs from the extension table to the 
    base table. 
    When 'include_non_function' is true, the function 
    copies functions, numbers, strings,
    tables, etc. Otherwise, only functions are copied
]]
function extend_table(base, extension, include_non_functions)
  include_non_functions = include_non_functions or false
  for k, v in pairs(extension) do
      if type(v) == "function" or include_non_functions then
          base[k] = v
      end
  end
  return base
end