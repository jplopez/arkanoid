score=class2:extend({
  v=0,
  reset=function(_ENV)v=0end,

  is_high_score=function(_ENV)return(v>=_high_score)end,

  update=function(_ENV) 
    if(v>_high_score)dset(_high_score_index,v)
    _high_score=dget(_high_score_index)
  end,

  draw=function(_ENV) 
    --high score
    printc("high score",1,7)
    printc(tostring(_ENV,_high_score),7,7)
    --player score
    print("score",_screen_right-20,1,7)
    print(tostring(_ENV),_screen_right-24,7,7)
  end,

  add=function(_ENV, n)v+=n>>16 end,

  tostring=function(_ENV,_v) 
    _v=_v or v
    return pad(s32_tostr(_v),6)
  end
})

function s32_tostr(_v)
  local s,t="",abs(_v)
  repeat
    s=(t%0x0.000a<<16)..s
    t/=10
  until t==0
  return _v<0 and "-"..s or s
end