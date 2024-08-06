-- utils

-- save copied tables in `copies`, indexed by original table.
function deepcopy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy

    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[deepcopy(orig_key, copies)] = deepcopy(orig_value, copies)
            end
            setmetatable(copy, deepcopy(getmetatable(orig), copies))
        end
    else
        -- number, string, boolean, etc
        copy = orig
    end

    return copy
end

function outside(n, a, b, inclusive)
    if inclusive then
        return n <= a or n >= b
    else
        return n < a or n > b
    end
end

function between(n, a, b, inclusive)
    return not outside(n, a, b, not inclusive)
end

-- detects 2 objects are colliding
-- based based on the method
-- axis-aligned bounding boxes (aabb)
function overlap(tol, ax1, ax2, ay1, ay2, bx1, bx2, by1, by2)
    local d1x = bx1 - ax2
    local d1y = by1 - ay2
    local d2x = ax1 - bx2
    local d2y = ay1 - by2

    if d1x > tol or d1y > tol then
        return false
    end

    if d2x > tol or d2y > tol then
        return false
    end

    return true
end

-- are a and b near
-- tol=tolerance distance
function near(tol, a, b)
    return (max(a,b) - min(a,b) <= tol)
end

function side_col(tol, a1, a2, b1, b2)
    return near(tol, a2, b1)
            or near(tol, a1, b2)
end



function tableconcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
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

function printo(s,x,y,c,o) -- 34 tokens, 5.7 seconds
    color(o)
    ?'\-f'..s..'\^g\-h'..s..'\^g\|f'..s..'\^g\|h'..s,x,y
    ?s,x,y,c
end

-- left pad
function pad(str,len,char)
    str=tostr(str)
    char=char or "0"
    if (#str==len) return str
    return char..pad(str, len-1)
end