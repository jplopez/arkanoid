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

  hit_spr = 1,
  hit_frs = 0,

  score_mul = 5,

  update = _noop,

  --TODO delegate draw/update functions to state handlers
  draw = function(self)
    if(self:is_state("hidden")) return true
    if(self:is_state("visible")) spr(self.clr,self.x,self.y)
    if(self:is_state("hit")) self:draw_hit()
  end,

  draw_hit = function(self)
    if self.hit_spr == #_brick_hit_spr then
      self:state("hidden")
    else
      if self.hit_frs >= _brick_hit_frs then
        spr(_brick_hit_spr[self.hit_spr], self.x, self.y)
        self.hit_spr += 1
        self.hit_frs = 0
      else
        self.hit_frs += 1
      end
    end
  end,

  on_collision = function(self)
    self:score_hit()
  end,

  score_hit = function(self)
    self:state("hit")

    local new_combo = _players["p1"]["combo"] + 1
    -- brick hit sound: combo sfx goes up to 7
    sfx(10 + mid(1, new_combo, 7))
    
    -- Update player's score and combo 
    _players["p1"]["score"] += self.score_mul * new_combo
    _players["p1"]["combo"] = new_combo
  end,

  visible = function(self)
    return self:is_state("visible")
  end,

  is_hit = function(self)
    return self:is_state("hit")
  end,

  is_hidden = function(self)
    return self:is_state("hidden")
  end,

  left_of = function(self, other)
    return self != other
        and self.x + self.w == other.x
        and self.y == other.y
  end,

  right_of = function(self, other)
    return other:left_of(self)
  end,

  top_of = function(self, other)
    return self != other
        and self.y + self.h == other.y
        and self.x == other.x
  end,

  bottom_of = function(self, other)
    return other:top_of(self)
  end,

  next_of = function(self, other)
    return self:left_of(other)
        or self:right_of(other)
        or self:top_of(other)
        or self:bottom_of(other)
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

composite_brick = brick:new({
  bricks = {},

  new = function(self, other)
    tbl = brick.new(self, other)
    tbl.bricks = {}
    return tbl
  end,

  union = function(self, other)
    if other != nil then
      if #self.bricks == 0 then
        self.x = other.x
        self.y = other.y
        self.w = other.w
        self.h = other.h
        self.clr = other.clr
        self.state = other.state
      else
        self = brick.union(self, other)
      end
      add(self.bricks, other)
    end
    -- log("brick.union self=(" .. self.x .. "," .. self.y .. "," .. self.w .. "," .. self.h .. ")")
    -- log("brick union bricks: " .. #self.bricks)
    return self
  end,

  on_collision = function(self)
    for br in all(self.bricks) do
      br:on_collision()
    end
  end,

  hidden_count = function(self)
    local count = 0
    for br in all(self.bricks) do
      if not br:is_state("visible") then
        count += 1
      end
    end
    return count
  end
})

--unbreakable
god_brick = brick:new({
  clr = 38,

  hit_fr = 3,
  hit_count = 0,
  hit_clr = 4,

  update = function(self)
    if self.hit_count > 0 then
      self.clr = self.hit_clr
      self.hit_count -= 1
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

  update = function(self)
    if self.hit_count > 0 then
      self.clr = self.hit_clr
      self.hit_count -= 1
    else
      self.clr = 37
    end
  end,

  on_collision = function(self)
    if self.hits == self.shield then
      self:score_hit()
    else
      --update shield hits count
      self.hits += 1
      self.hit_count = self.hit_fr
      sfx(5)

      --update player's combo and score
      local combo = _players["p1"]["combo"] + 1
      _players["p1"]["combo"] = combo
      _players["p1"]["score"] += self.score_mul * combo
    end
  end
})
--shield_brick:init_states()

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