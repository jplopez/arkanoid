--power ups

_pup_lvl_chance = 0.2
_pup_s_tier_chance = 0.05
_pup_a_tier_chance = 0.15
_pup_b_tier_chance = 0.8

_pup_states = {
  visible = "visible",
  hidden = "hidden"
}
powerup=class:new({

  clr = 0,

  x = _screen_left,
  y = _screen_top,

  frame = 0,
  speed = 0.01,
  dx = 0,
  dy = 1,
  length_x = 10 + 3,
  length_y = 4 + 3,


  state = _pup_states.hidden,
  
  
  -- new=function(self, clr)
  --   local tbl = class:new(self)
  --   tbl.clr = clr
  --   return tbl
  -- end,

  visible = function(self)
    return self.state == _pup_states.visible
  end,

  update = function(self)
    if self:visible() then
      self.frame += self.speed
      self.dx = cos(self.frame) * self.length_x
      self.dy = 1
    elseif self.state == _pup_states.idle then
      self.dx = 0
      self.dy = 0
    end
  end, 

  draw = function(self)
    if self:visible() then
      local x_pos = self.x
      x_pos = mid(_screen_left, x_pos + self.dx, _screen_right - 8 )

      local y_pos = self.y
      y_pos = max(_screen_top, y_pos + self.dy)
      spr(self.clr, x_pos, y_pos)

      -- powerup went off the screen
      if y_pos > _screen_bot then
        self.state = _pup_states.hidden
      end
    end
  end,

  on_collision=noop

})

pup_1up = powerup:new({clr=8})
pup_large = powerup:new({clr=9})
pup_small = powerup:new({clr=10})
pup_fireball = powerup:new({clr=11})
pup_3balls = powerup:new({clr=12})
pup_speed3 = powerup:new({clr=13})
pup_speed2 = powerup:new({clr=14})
pup_speed1 = powerup:new({clr=15})
pup_score = powerup:new({clr=24})
pup_web = powerup:new({clr=25})
pup_glue = powerup:new({clr=26})
pup_fire = powerup:new({clr=27})

_pup_s_tier = {pup_fire, pup_fireball, pup_web}
_pup_a_tier = {pup_large, pup_small, pup_speed3, pup_glue}
_pup_b_tier = {pup_speed1, pup_speed2, pup_3balls, pup_score}
