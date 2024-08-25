-- brick

_brick_spr = { 20, 21, 22, 23, 36 }
_brick_hit_spr = { 40, 41, 42, 43, 44 }
_brick_hit_frs = 5

--TODO add different sprites depending on where the collision took place
_hit_spr = {
  top = {},
  bottom = {},
  left = {},
  right = {}
}

brick = class:new({
  x = _screen_left + 12,
  y = _screen_top + 10,
  w = 8,
  h = 5,
  clr = rnd(_brick_spr),

  _count = 0,
  unbreakable=false,

  score_mul = 5,

  update = _noop,

  --TODO delegate draw/update functions to state handlers
  draw = function(self)
    if(self:is_state("hidden")) return true
    if(self:is_state("visible")) spr(self.clr,self.x,self.y)
    if(self:is_state("hit")) self:draw_hit()
  end,

  draw_hit = function(self)
    local c, m, s = self._count, #_brick_hit_spr, _brick_hit_spr
    c = (c+1)%m 
    if(c==0) then
      self:state("hidden")
    else
      spr(s[c+1], self.x, self.y)
      self._count=c
    end

  end,

  on_collision = function(self)
    if(not self.unbreakable or
      _players["p1"]["ball"]:power() == _pwr_fury) then
        self:score_hit()
    else
      _players["p1"]["ball"].pwr+= 1
      sfx(6)
    end
    
  end,

  score_hit = function(self, n_hits)
    log("brick score hit")
    n_hits = n_hits or 1
    self:state("hit")

    local new_combo = _players["p1"]["combo"] + n_hits
    -- brick hit sound: combo sfx goes up to 7
    sfx(10 + mid(1, new_combo, 7))
    
    -- Update player's score and combo 
    _players["p1"]["score"] += self.score_mul * new_combo
    _players["p1"]["combo"] = new_combo

    -- update ball's pwr count
    _players["p1"]["ball"].pwr+= ceil(new_combo/2)
  end,

  union = function(self, other)
    if (other == nil) return self
    local new_x = min(self.x, other.x)
    local new_y = min(self.y, other.y)
    local new_w = max(self.x + self.w, other.x + other.w) - new_x
    local new_h = max(self.y + self.h, other.y + other.h) - new_y
    -- log("brick.union self=("..self.x..","..self.y..","..self.w..","..self.h..")\n"
    --   .."            other=("..other.x..","..other.y..","..other.w..","..other.h..")\n"
    --   .."            self+other=("..new_x..","..new_y..","..new_w..","..new_h..")")

    self.x = new_x
    self.y = new_y
    self.w = new_w
    self.h = new_h
    return self
  end,

  equals = function(this, other, skip_color)
    if (other == nil) return false
    local color = this.clr == other.clr
    if (skip_color) color = true
    return this.x == other.x and this.y == other.y
        and this.w == other.w and this.h == other.h
        and color
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

  update = function(self)
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
    brick.draw_visible(self, self.clr, x_pos, y_pos)
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