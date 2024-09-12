tiny_numbers={
  m={
    -- {sx,sy,sw,sh,flip_x,flip_y}
    ['0']={20,16,3,5,false,false},
    ['1']={8,16,1,5,false,false},
    ['2']={9,16,2,5,false,false},
    ['3']={11,16,2,5,false,false},
    ['4']={13,16,2,5,false,false},
    ['5']={9,16,2,5,false,true},
    ['6']={16,16,2,5,false,false},
    ['7']={18,16,2,5,false,false},
    ['8']={20,16,3,5,false,false},
    ['9']={16,16,2,5,true,true},
    ['!']={23,16,1,5,false,false},
  },

  ssprt=function(sx, sy, sw, sh, dx, dy, fl_x, fl_y, c)
    pal(10, c)
    sspr(sx, sy, sw, sh, dx, dy, sw, sh, fl_x, fl_y)
    pal()
    return dx+sw
  end
}

function printt(text, x, y, c) 
  local dx=x
  for i=1,#text do
    local chr = sub(text,i,i)
    local n=tiny_numbers.m[chr]
    if(n) dx=tiny_numbers.ssprt(n[1],n[2],n[3],n[4],dx,y,n[5],n[6],c)
    if(not n) dx=print(chr,dx,y,c)-1
    dx+=1
  end
end