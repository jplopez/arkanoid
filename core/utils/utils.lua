-- utils

function is_empty(str) 
    return str == nil or str == ""
end

-- print centered
function printc(str,y,clr)
    local x=64-(#str*4)/2
    print(str,x,y,clr)
end
   
-- print shadow
function prints(str,x,y,clr)
    print(str,x+1,y+1,7)
    print(str,x,y,clr)
end

function printsc(str,y,c)
    prints(str,(64-(#str*4)/2), y, c)
end

function printo(s,x,y,c,o) -- 34 tokens, 5.7 seconds
    color(o)
    ?'\-f'..s..'\^g\-h'..s..'\^g\|f'..s..'\^g\|h'..s,x,y
    ?s,x,y,c
end

-- print outlined centered
function printoc(s,y,c,o)
    printo(s,64-(#s*4)/2,y,c,o)
end
-- left pad
function pad(str,len,char)
    str=tostr(str)
    char=char or "0"
    if (#str==len) return str
    return char..pad(str, len-1)
end

function spaces(len)
    if(len == 0) return ""
    return " " .. spaces(len-1)
end

function serialize(tbl, level)
    if(tbl==nil) then return "" end
    level = level or 0
    local result = {}
    for k,v in pairs(tbl) do
        local field = ""
        if type(v) == "string" then
            field = tostr(k) .. ' : "' .. v .. '"'
        elseif type(v) == "function" then
            field = tostr(k) .. ' : "function"'
        elseif type(v) == "table" then 
            field = tostr(k) .. ' :\n' .. serialize(v, level+1)
        else 
            field = tostr(k) .. ' : ' .. tostr(v)
        end 
        add(result, spaces(2*(level+1)) .. field)
    end 
    return  spaces(2*level) .. '{\n' .. 
            table_concat(result, "\n") ..
            '\n' .. spaces(2*level) .. '}'
end

function table_concat(array, separator)
    if(array==nil or #array==0) return ""

    separator = separator or ","
    local result = ""
    for i = 1, #array do
        result = result .. array[i]
        if i < #array then
            result = result .. separator
        end
    end
    return result
end