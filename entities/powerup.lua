powerup=object:new({
  s= 0, 
  x=_screen_left+rnd(_screen_right),
  y=_screen_top+rnd(64),
  w=8,
  h=8,
  speed=0.5,
  states={"visible","hidden","idle"},

  new=function(self,tbl)
    tbl=tbl or {}
    tbl=class.new(powerup,tbl)
    return tbl
  end,
  update=function(self)
    if self:is_state("visible")then
      self.x=mid(_screen_left,self.x+cos(t()),_screen_right-8) 
      self.y=max(_screen_top,self.y+self.speed)
    end
    -- hide powerup if is off the screen
    if(self.y>_screen_bot)self:state("hidden")
  end, 
  draw=function(self)if(self:is_state("visible"))spr(self.s,self.x,self.y)end,
  on_collision=function(self) end
})

_pup_s_tier={_pup_web,}
_pup_a_tier={
  _pup_3balls,
  _pup_large, 
  _pup_small,
  _pup_1up
}
_pup_b_tier={
  _pup_score, 
  _pup_glue
}

-- lvl_chance = 0.2
-- s_tier_chance = 0.05
-- a_tier_chance = 0.15
-- b_tier_chance = 0.8
--
-- Powerup Gatcha formula:
-- pup_chance = lvl_chance * tirt_chance + (0.02 * player_combo)
_pup_gatcha={
--  s = {2, 4, 6, 8, 10,12,14},
--  a = {5, 7, 9, 11,13,15,16},
--  b = {18,20,22,24,26,28,30}
-- }

  s={ 0,  0,  0,  4,  6,  8, 10},
  a={ 0,  0,  5,  7,  9, 11, 13},
  b={18, 20, 22, 24, 26, 28, 30}
}

function pup_gatcha_pull()
  local combo=gatcha_combo()
  if chance(_pup_gatcha["b"][combo])then return rnd(_pup_b_tier)
  elseif chance(_pup_gatcha["a"][combo])then return rnd(_pup_a_tier)
  elseif chance(_pup_gatcha["s"][combo])then return rnd(_pup_s_tier)
  end
  return nil
end

function gatcha_combo()
  if(_pball:power()==_pwr_fury)return 1
  local c=mid(1,_pcombo,7)
  if(_pball:power()==_pwr_ball)return flr(c/2)
  return c
end

function chance(perc)return (1+rnd(100))<=perc end