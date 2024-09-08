_br_spr_hit = { 40, 41, 42, 43, 44 }

brick = class:new({
  x = _screen_left + 12,
  y = _screen_top + 10,
  w = 8,
  h = 5,
  s = 20,
  cnt = 0,
  unbreakable=false,
  score_mul = 5,

  update = _noop,

  draw = function(self)
    if(self:is_state("hidden")) return true
    if(self:is_state("visible")) spr(self.s,self.x,self.y)
    if(self:is_state("hit")) self:draw_hit()
  end,

  draw_hit = function(self)
    local c, m, hs = self.cnt, #_br_spr_hit, _br_spr_hit
    c = (c+1)%m 
    if(c==0) then
      self:state("hidden")
    else
      spr(hs[c+1], self.x, self.y)
      self.cnt=c
    end
  end,

  on_collision = function(self,b)
    b=b or _pball
    if(self.unbreakable) then
      if(b:power()==_pwr_fury) then  -- fury ball (red) beats unbreakable bricks
        self:score_hit(b:hits(), b:power())
      else
        b.pwr+= _pwrbar_increment
        sfx(6) -- metal cling sound
      end
    else
      self:score_hit(b:hits(), b:power()) 
    end
  end,

  score_hit = function(self, n_hits, b_pwr)
    log("brick score hit")
    n_hits = n_hits or 1
    b_pwr = b_pwr or _pwr_off
    self:state("hit")

    local new_combo = _pcombo + n_hits    
    -- Update player's score and combo and ball pwr 
    _pscore += self.score_mul * new_combo
    _pball.pwr+= ceil(new_combo/_pwrbar_combo_factor)
    _pcombo = new_combo
    -- brick hit sound: combo sfx goes up to 7
    if(b_pwr == _pwr_off) sfx(10 + mid(1, new_combo, 7))
    if(b_pwr == _pwr_ball or b_pwr == _pwr_fury) sfx(09)

    return _pcombo, _pball.pwr, _pscore
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
})