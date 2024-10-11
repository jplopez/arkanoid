-- Utils Functions
function is_empty(str)return(str==nil or str=="")end
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
function pad(str,len,char)
  str=tostr(str)
  char=char or "0"
  if(#str==len)return str
  return char..pad(str,len-1)
end

function spaces(len)
  if(len==0)return ""
  return " "..spaces(len-1)
end

function serialize(tbl,level)
  if(tbl==nil)then return "" end
  level=level or 0
  local result={}
  for k,v in pairs(tbl)do
    local field=""
    if type(v)=="string"then field=tostr(k)..' : "'..v..'"'
    elseif type(v)=="function"then field=tostr(k)..' : "function"'
    elseif type(v)=="table"then field=tostr(k)..' :\n'..serialize(v,level+1)
    else field=tostr(k)..' : '..tostr(v) end 
    add(result,spaces(2*(level+1))..field)
  end
  return spaces(2*level) .. '{\n'..table_concat(result,"\n")..'\n'..spaces(2*level)..'}'
end

function table_concat(array,separator)
  if(array==nil or #array==0)return ""
  separator=separator or ","
  local result=""
  for i=1,#array do
    result=result..array[i]
    if(i<#array)result=result..separator
  end
  return result
end

function get(table,value)
  if((table==nil)or(value==nil))return nil
  for i in all(table)do if(i==value)return i end
  return nil
end

function muted()return(stat(48)-stat(49)==0)end

-- delays execution of callback by 2^n-1 frames.
-- can be a number between 1 and 9
function delay(n,callback,...)print("\^"..mid(1,n,9))callback(...)end

function debug()if(not _debug)return
-- local px=46
-- px=print(_pball.dx..",".._pball.dy,px,_screen_bot-5,13)
-- px=print(stat(46).." "..stat(47).." "..stat(48).." "..stat(49),px+1,_screen_bot-5,13)
-- print(" m:"..stat(54),px+1,_screen_bot-5,13)
end