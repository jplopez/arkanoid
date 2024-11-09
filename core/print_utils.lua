-- print centered
function printc(str,y,clr)local x=(64-(#str*4)/2)print(str,x,y,clr)end
-- print shadow
function prints(str,x,y,clr)print(str,x+1,y+1,7)print(str,x,y,clr)end
-- print shadow centered
function printsc(str,y,c)prints(str,(64-(#str*4)/2),y,c)end
-- print outlined
function printo(s,x,y,c,o) -- 34 tokens, 5.7 seconds
  color(o)
  ?'\-f'..s..'\^g\-h'..s..'\^g\|f'..s..'\^g\|h'..s,x,y
  ?s,x,y,c
end
-- print outlined centered
function printoc(s,y,c,o)printo(s,64-(#s*4)/2,y,c,o)end

-- left pad
function lpad(str,len,char)
  str=tostr(str)
  char=char or "0"
  if(#str==len)return str
  return char..lpad(str,len-1)
end

-- function rpad(str,len,char)
--   str=tostr(str)
--   char=char or "0"
--   if(#str==len)return str
--   return rpad(str,len-1)..char
-- end

function spaces(len)
  len=max(0,len) --prevetn errors with neg values
  if(len==0)return ""
  return " "..spaces(len-1)
end
