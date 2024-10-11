score=class:new({
  v=0,
  reset=function(self)self.v=0end,

  is_high_score=function(self)return(self.v>=_high_score)end,

  update=function(self) 
    if(self.v>_high_score)dset(_high_score_index,self.v)
    _high_score=dget(_high_score_index)
  end,

  draw=function(self) 
    --high score
    printc("high score",1,7)
    printc(self:tostr(_high_score),7,7)
    --player score
    print("score",_screen_right-20,1,7)
    print(self:tostr(),_screen_right-24,7,7)
  end,

  add=function(self, n)self.v+=n>>16 end,

  tostr=function(self,v) 
    v=v or self.v
    return pad(s32_tostr(v),6)
  end
})

function s32_tostr(v)
  local s,t="",abs(v)
  repeat
    s=(t%0x0.000a<<16)..s
    t/=10
  until t==0
  return v<0 and "-"..s or s
end