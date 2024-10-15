bonus_fx_i = 0 
bonus_fx_n = 20

function init_bonus()
  _bonus={
    [1]={score="002000",claimed=false},
    [2]={score="005000",claimed=false},
    [3]={score="010000",claimed=false},
    [4]={score="020000",claimed=false}
  }
end

function update_bonus()
  for n=1,#_bonus do
    if not _bonus[n]["claimed"] then
      if _score >= _bonus[n]["score"] then
        extra_live()
        _bonus[n]["claimed"] = true
        return false
      end
    end
  end
end

function extra_live()
  _plives+= 1
  bonus_fx_i=bonus_fx_n 
  sfx(3)
end


function draw_bonus()
  if bonus_fx_i > 0 then
    if (bonus_fx_i / 4) % 2 == 0 then
      spr(0, _screen_left, 1)
    else
      spr(1, _screen_left, 1)
    end
    bonus_fx_i-=1
  end
end