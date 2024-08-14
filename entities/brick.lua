-- brick

_brick_spr = {20, 21, 22, 23, 36}

_brick_hit_spr = {40, 41, 42, 43, 44}
_brick_hit_frs = 5

_brick_states = {
  visible = "visible",
  hit = "hit",
  hidden = "hidden"
}

brick = class:new({
  x = _screen_left + 12,
  y = _screen_top + 10,
  w = 8,
  h = 5,
  clr = rnd(_brick_spr),

  -- TODO deprecate
  --visible = true,

  state = _brick_states.visible,

  hit_spr = 1,
  hit_frs = 0,

  update = noop,

  draw = function(self)
    if (self.state == _brick_states.visible) self:draw_visible(self.clr, self.x, self.y)
    if (self.state == _brick_states.hit) self:draw_hit(self.x, self.y) 
  end,

  draw_visible=function(self, n, x_pos, y_pos)
    spr(n,x_pos,y_pos)
  end,

  draw_hit=function(self, x_pos, y_pos)
    if self.hit_spr == #_brick_hit_spr then
      self.state = _brick_states.hidden
      --self.visible = false
    else
      if self.hit_frs >= _brick_hit_frs then
        spr(_brick_hit_spr[self.hit_spr],x_pos,y_pos)
        self.hit_spr += 1
        self.hit_frs = 0
      else
        self.hit_frs += 1
      end
    end
  end,

  on_collision = function(self)
    --self.visible = false
    self.state = _brick_states.hit

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

  visible = function(self)
    return self.state == _brick_states.visible
  end,

  is_hit = function(self)
    return self.state == _brick_states.hit
  end,

  is_hidden = function(self)
    return self.state == _brick_states.hidden
  end,

  -- __eq=function(self, b)
  --   if b==nil then return false end
  --   return self.x == b.x and self.y == b.y 
  --       and self.clr == b.clr
  --       and self.w == b.w and self.h == b.h
  -- end,

  left_of=function(self, other)
    return (self != other) 
        and (self.x+self.w)==other.x 
        and (self.y == other.y)
  end,

  right_of=function(self, other)
    return other:left_of(self)
  end,

  top_of=function(self,other)
    return (self != other) 
        and (self.y+self.h) == other.y
        and (self.x == other.x)
  end,

  bottom_of=function(self,other)
    return other:top_of(self)
  end,

  next_of=function(self, other)
    return self:left_of(other) or
      self:right_of(other) or
      self:top_of(other) or
      self:bottom_of(other)
  end,

  union=function(self, other)
    if(other==nil) return self
  
    local new_x = min(self.x, other.x)
    local new_y = min(self.y, other.y)
    local new_w = max(self.x+self.w, other.x+other.w) - new_x
    local new_h = max(self.y+self.h, other.y+other.h) - new_y
    -- log("brick.union self=("..self.x..","..self.y..","..self.w..","..self.h..")\n"
    --   .."            other=("..other.x..","..other.y..","..other.w..","..other.h..")\n"
    --   .."            self+other=("..new_x..","..new_y..","..new_w..","..new_h..")")

    self.x = new_x
    self.y = new_y
    self.w = new_w
    self.h = new_h
    return self
  end,

  equals=function(this, other, skip_color)
    if(other==nil) return false
    local color = this.clr == other.clr
    if(skip_color) color=true

    return this.x == other.x and this.y == other.y 
        and this.w == other.w and this.h == other.h
        and color
  end

})

composite_brick = brick:new({
  bricks = {},

  new=function(self,other)
    tbl = brick.new(self,other)
    tbl.bricks = {}
    return tbl
  end,

  union=function(self, other)
    if(other!=nil) then
      if #self.bricks==0 then
        self.x = other.x
        self.y = other.y
        self.w = other.w
        self.h = other.h
        self.clr = other.clr
        self.state = other.state
      else
        self = brick.union(self,other)
      end
      add(self.bricks, other)
    end
    log("brick.union self=("..self.x..","..self.y..","..self.w..","..self.h..")")
    log("brick union bricks: "..#self.bricks)
    return self
  end,

  on_collision=function(self)
    for br in all(self.bricks) do
      br:on_collision()
    end
  end,

  hidden_count=function(self)
    local count = 0
    for br in all(self.bricks) do
      if not br:visible() then
        count+=1
      end
    end
    return count
  end

})

--unbreakable
god_brick = brick:new({
  clr = 38,

  hit_fr=3,
  hit_count=0,
  hit_clr=4,

  update=function (self)
    if self.hit_count > 0 then
      self.clr = self.hit_clr
      self.hit_count-=1
    else
      self.clr = 38
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
  clr = 37,

  hit_fr = 3,
  hit_count = 0,
  hit_clr = 4,

  update=function (self)
    if self.hit_count > 0 then
      self.clr = self.hit_clr
      self.hit_count-=1
    else
      self.clr = 37
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

  move_x = false,
  move_y = false,

  length_x = 10 + 3,
  length_y = 4 + 3,

  update = function (self)
    self.frame += self.speed
    self.dx = cos(self.frame) * self.length_x
    self.dy = sin(self.frame) * self.length_y
  end,

  draw_visible = function(self, n, x_pos, y_pos)
    local x_pos = self.x
    if self.move_x then 
      x_pos = mid(_screen_left, x_pos + self.dx, _screen_right - self.w) 
    end

    local y_pos = self.y
    if self.move_y then 
      y_pos = mid(_screen_top, y_pos + self.dy, _screen_bot - self.h) 
    end
    brick.draw_visible(self, self.clr,x_pos,y_pos) 
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

-- fast_x_brick = move_brick:new({
--   move_x = true,
--   move_y = false,
--   speed = 0.015
-- })

-- slow_y_brick = move_brick:new({
--   move_x = false,
--   move_y = true,
--   speed = 0.01
-- })

-- mid_y_brick = move_brick:new({
--   move_x = false,
--   move_y = true,
--   speed = 0.013
-- })

-- fast_y_brick = move_brick:new({
--   move_x = false,
--   move_y = true,
--   speed = 0.015
-- })

-- slow_circ_brick = move_brick:new({
--   move_x = true,
--   move_y = true,
--   speed=0.01
-- })

-- mid_circ_brick = move_brick:new({
--   move_x = true,
--   move_y = true,
--   speed=0.013
-- })

-- fast_circ_brick = move_brick:new({
--   move_x = true,
--   move_y = true,
--   speed=0.015
-- })

-- slow_large_circ_brick = move_brick:new({
--   move_x = true,
--   move_y = true,
--   speed=0.01,
--   length_x = 20 + 5,
--   length_y = 8 + 5
-- })

-- mid_large_circ_brick = move_brick:new({
--   move_x = true,
--   move_y = true,
--   speed=0.013,
--   length_x = 20 + 5,
--   length_y = 8 + 5
-- })

-- fast_large_circ_brick = move_brick:new({
--   move_x = true,
--   move_y = true,
--   speed=0.015,
--   length_x = 20 + 5,
--   length_y = 8 + 5
-- })
