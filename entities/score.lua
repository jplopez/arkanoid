score=entity:extend({
  v=0,
  highscores=nil,

  init=function(_ENV)
    entity.init(_ENV)
    reset(_ENV)
    --load_highscores(_ENV)
  end,

  reset=function(_ENV)v=0end,

  is_highest=function(_ENV)return(v>=_high_score)end,

  -- is_highscore=function(_ENV) 
  --   highscores = highscores or load_highscores()
  --   for sc in all(highscores) do
  --     if(v>sc.score) return true
  --   end
  --   return false
  -- end,


  update=function(_ENV) 
    if(v>_high_score)dset(_highest_score_index,v)
    _high_score=dget(_highest_score_index)
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
    return lpad(s32_tostr(_v),6)
  end,

  -- load_highscores=function(_ENV)
  --   highscores={}
  --   for i=1,3 do
  --     local sc = {}
  --     sc.score= tostring(_ENV, dget(_hs_index*i))
  --     sc.name=chr(
  --       dget(_hs_index*i+1),
  --       dget(_hs_index*i+2),
  --       dget(_hs_index*i+3))
  --     add(highscores,sc)
  --   end
  --   return highscores
  -- end,
})

function s32_tostr(_v)
  local s,t="",abs(_v)
  repeat
    s=(t%0x0.000a<<16)..s
    t/=10
  until t==0
  return _v<0 and "-"..s or s
end