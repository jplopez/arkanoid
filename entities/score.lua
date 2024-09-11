score = class:new({
  v=0,

  reset=function(self)
    log("score reset")
    self.v=0
  end,

  is_high_score=function(self)
    return (self.v >= _high_score)
  end,

  update = function(self) 
    log("score upd")
    if(self.v > _high_score) dset(_high_score_index, self.v)
    _high_score = dget(_high_score_index)

  end,
  
  draw = function(self) 
    log("score draw")
    log(_high_score)
    --high score
    printc("high score", 1, 7)
    printc(self:tostr(_high_score), 7, 7)
    --player score
    print("score", _screen_right - 20, 1, 7)
    print(self:tostr(), _screen_right - 24, 7, 7)
  end,

  add = function(self, n) 
    self.v+=n>>16
  end,

  tostr = function(self, v) 
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

-- function score_test()

--   score:add(1000)
--   print("+1000->score:tostr() == '1000' " .. tostr(score:tostr()=='1000'))

--   score:add(1250) -- 1000 + 1250 = 2250
--   print("+1250->score:tostr() == '2250' " .. tostr(score:tostr()=='2250'))

--   score:add(700) -- 2250 + 700 = 3150
--   print("+700->score:tostr() == '2950' " .. tostr(score:tostr()=='2950'))

--   for i=1,10 do 
--     score:add(10000) 
--     assert = pad(tostr(i) .. "2950",6)
--     print("+10000->score:tostr() == '" .. assert .."' :")
--     print("score: " .. score:tostr())
--     print("test:  ".. tostr(score:tostr()==assert))
--   end

-- end