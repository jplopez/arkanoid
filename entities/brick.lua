-- brick
brick = class:new({
  x = _screen_left + 12,
  y = _screen_top + 10,
  w = 10,
  h = 4,
  clr = 14,
  visible = true,

  update = noop,

  draw = function(self)
    if self.visible then
      rectfill(self.x, self.y,
        self.x + self.w,
        self.y + self.h, self.clr)
    end
  end,

  on_collision = function(self)
    self.visible = false
    
    local combo = mid(1,_players["p1"]["combo"]+1,7)
    sfx(10 + combo)
    _players["p1"]["combo"]=combo
  
    --score
    _players["p1"]["score"]+=5*combo
  end,

  to_string = function(self)
    return "("
        .. tostr(self.x) .. ","
        .. tostr(self.y) .. "),"
        .. tostr(self.visible)
  end,

  __eq=function(self, b)
    if b==nil then return false end
    return self.x == b.x and self.y == b.y 
        and self.clr == b.clr
        and self.w == b.w and self.h == b.h
  end

})

--unbreakable
god_brick = brick:new({
  clr = 10,

  hit_fr=3,
  hit_count=0,
  hit_clr=6,

  update=function (self)
    if self.hit_count > 0 then
      self.clr = self.hit_clr
      self.hit_count-=1
    else
      self.clr = 10
    end
  end,

  on_collision = function(self)
    self.hit_count = self.hit_fr
    sfx(6)
  end
})

--shielded brick
--can sustain 'shield' number
--of hits
shield_brick = brick:new({
  shield = 2,
  hits = 0,
  clr = 13,

  hit_fr = 3,
  hit_count = 0,
  hit_clr = 6,

  update=function (self)
    if self.hit_count > 0 then
      self.clr = self.hit_clr
      self.hit_count-=1
    else
      self.clr = 13
    end
  end,

  on_collision = function(self)
    if self.hits == self.shield then
      brick.on_collision(self)
    else
      self.hits += 1
      self.hit_count = self.hit_fr
      local combo = mid(1,_players["p1"]["combo"]+1,7)
      _players["p1"]["combo"]=combo
      sfx(5)
      --score
      _players["p1"]["score"]+=5*combo

    end
  end
})

move_brick = brick:new({

  frame = 0,
  speed = 0.01,
  dx = 0,
  dy = 0,

  clr = 4,

  move_x = false,
  move_y = false,

  length_x = 10 + 3,
  length_y = 4 + 3,

  update = function (self)
    self.frame += self.speed
    self.dx = cos(self.frame) * self.length_x
    self.dy = sin(self.frame) * self.length_y
  end,

  draw=function(self)

    if self.visible then

      local x_pos = self.x
      if self.move_x then 
        x_pos = mid(_screen_left, x_pos + self.dx, _screen_right - self.w) 
      end
  
      local y_pos = self.y
      if self.move_y then 
        y_pos = mid(_screen_top, y_pos + self.dy, _screen_bot - self.h) 
      end
  
      rectfill(x_pos, y_pos,
        x_pos + self.w, y_pos + self.h,
        self.clr)
    end

  end
})

slow_x_brick = move_brick:new({
  move_x = true,
  move_y = false,
  speed = 0.01
})

mid_x_brick = move_brick:new({
  move_x = true,
  move_y = false,
  speed = 0.013
})

fast_x_brick = move_brick:new({
  move_x = true,
  move_y = false,
  speed = 0.015
})

slow_y_brick = move_brick:new({
  move_x = false,
  move_y = true,
  speed = 0.01
})

mid_y_brick = move_brick:new({
  move_x = false,
  move_y = true,
  speed = 0.013
})

fast_y_brick = move_brick:new({
  move_x = false,
  move_y = true,
  speed = 0.015
})

slow_circ_brick = move_brick:new({
  move_x = true,
  move_y = true,
  speed=0.01
})

mid_circ_brick = move_brick:new({
  move_x = true,
  move_y = true,
  speed=0.013
})

fast_circ_brick = move_brick:new({
  move_x = true,
  move_y = true,
  speed=0.015
})

slow_large_circ_brick = move_brick:new({
  move_x = true,
  move_y = true,
  speed=0.01,
  length_x = 20 + 5,
  length_y = 8 + 5
})

mid_large_circ_brick = move_brick:new({
  move_x = true,
  move_y = true,
  speed=0.013,
  length_x = 20 + 5,
  length_y = 8 + 5
})

fast_large_circ_brick = move_brick:new({
  move_x = true,
  move_y = true,
  speed=0.015,
  length_x = 20 + 5,
  length_y = 8 + 5
})

bomb_brick=brick:new({

  on_collision=function(self)

  end

})

powerup_brick=brick:new({

  wrapped = brick:new(),
  powerup = nil,

  update=function (self)
    self.wrapped:update()
  end,

  draw=function(self)
    self.wrapped:draw()
  end,

  on_collision=function (self)
    self.powerup:draw()
  end
    
})