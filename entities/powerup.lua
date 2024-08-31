--power ups

powerup=class:new({

  s = 0,
  -- sx = 0,
  -- sy = 0,
  -- sw = 0,
  -- sh = 0,  
  x = _screen_left + rnd(_screen_right),
  y = _screen_top + rnd(64),

  w = 8,
  h = 8,

  speed = 0.5,

  new=function(self, tbl)
    tbl = class.new(self, tbl)
    add_states(tbl, {"visible", "hidden"})
    return tbl
  end,

  update = function(self)
    if self:is_state("visible") then
      self.x += cos(t()) 
      self.y += self.speed
    end
    -- powerup went off the screen
    if(self.y > _screen_bot) self:state("hidden")
  end, 

  draw = function(self)
    if self:is_state("visible") then
      local x, y = self.x, self.y
      x_pos = mid(_screen_left, x, _screen_right - 8 )
      y_pos = max(_screen_top, y)
      --log("draw powerup ")
      --log2(self)
      spr(self.s, x, y)
    end
  end,

  on_collision=function(self) end

})


_pup_s_tier = {_pup_fire, _pup_fireball, _pup_web}
_pup_a_tier = {_pup_large, _pup_small,_pup_speed3, _pup_1up}
_pup_b_tier = {_pup_speed1, _pup_speed2, _pup_3balls, _pup_score, _pup_glue}

-- lvl_chance = 0.2
-- s_tier_chance = 0.05
-- a_tier_chance = 0.15
-- b_tier_chance = 0.8
--
-- Powerup Gatcha formula:
-- pup_chance = lvl_chance * tirt_chance + (0.02 * player_combo)
_pup_gatcha = {
--  s = {2, 4, 6, 8, 10,12,14},
--  a = {5, 7, 9, 11,13,15,16},
--  b = {18,20,22,24,26,28,30}
-- }

  s = { 0,  0,  0,  4,  6,  8, 10},
  a = { 0,  0,  5,  7,  9, 11, 13},
  b = {18, 20, 22, 24, 26, 28, 30}
}

function pup_gatcha_pull()
  log("pup gatcha pull")
  local combo = gatcha_combo()
  log("pup gatcha pull combo "..combo)

  if chance(_pup_gatcha["b"][combo]) then
    log("pup gatcha pull - b tier!")
    return rnd(_pup_b_tier)
  elseif chance(_pup_gatcha["a"][combo]) then
    log("pup gatcha pull - a tier!")
    return rnd(_pup_a_tier)
  elseif chance(_pup_gatcha["s"][combo]) then
  log("pup gatcha pull - s tier!")
    return rnd(_pup_s_tier)
  end
  log("pup gatcha pull - no pup")
  return nil
end

function gatcha_combo()
  local b = _players["p1"]["ball"]
  local combo = mid(1, _players["p1"]["combo"], 7)
  if(b:power() == _pwr_fury) return 1
  if(b:power() == _pwr_ball) return flr(combo/2)
  return combo
end

function chance(percentage)
  return (1 + rnd(100)) <= percentage
end