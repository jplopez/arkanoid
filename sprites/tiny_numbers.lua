tiny_numbers = class:new({

  uno=function(self,x,y,c)
    return self.ssprt(8, 16, 1, 5, x, y, false, false, c)
  end,

  dos=function(self, x,y,c)
    return self.ssprt(9, 16, 2, 5, x, y, false, false, c)
  end,

  tres=function(self, x,y,c)
    return self.ssprt(11, 16, 2, 5, x, y, false, false, c)
  end,

  qua=function(self, x,y,c)
    return self.ssprt(13, 16, 2, 5, x, y, false, false, c)
  end,

  cinco=function(self, x,y,c)
    return self.ssprt(9, 16, 2, 5, x, y, false, true, c)
  end,

  seis=function(self, x,y,c)
    return self.ssprt(16, 16, 2, 5, x, y, false, false, c)
  end,

  siete=function(self, x,y,c)
    return self.ssprt(18, 16, 2, 5, x, y, false, false, c)
  end,

  ocho=function(self, x,y,c)
    self:tres(x+1,y,c)
    return self:cero(x,y,c)
  end,

  nueve=function(self, x,y,c)
    return self.ssprt(16, 16, 2, 5, x, y, true, true, c)
  end,

  cero=function(self, x,y,c)
    return self.ssprt(20, 16, 3, 5, x, y, false, false, c)
  end,

  excl=function(self, x,y,c)
    return self.ssprt(23, 16, 1, 5, x, y, false, false, c)
  end,

  ssprt=function(sx, sy, sw, sh, dx, dy, fl_x, fl_y, c)
    pal(10, c)
    sspr(sx, sy, sw, sh, dx, dy, sw, sh, fl_x, fl_y)
    pal()
    return dx+sw
  end
})

function printt(text, x, y, c) 
  local dx=x
  for i=1,#text do
    local chr = sub(text,i,i)
    if(chr=="!") dx=tiny_numbers:excl(dx,y,c)
    local n=tonum(chr)
    if(n==0) dx=tiny_numbers:cero(dx,y,c)
    if(n==1) dx=tiny_numbers:uno(dx,y,c)
    if(n==2) dx=tiny_numbers:dos(dx,y,c)
    if(n==3) dx=tiny_numbers:tres(dx,y,c)
    if(n==4) dx=tiny_numbers:qua(dx,y,c)
    if(n==5) dx=tiny_numbers:cinco(dx,y,c)
    if(n==6) dx=tiny_numbers:seis(dx,y,c)
    if(n==7) dx=tiny_numbers:siete(dx,y,c)
    if(n==8) dx=tiny_numbers:ocho(dx,y,c)
    if(n==9) dx=tiny_numbers:nueve(dx,y,c)
    dx+=1
  end
end