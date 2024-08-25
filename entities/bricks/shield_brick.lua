
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
    log("shield brick on collision")
    local n_hits = _players["p1"]["ball"]:hits()
    self.hits += n_hits
    self:score_hit(n_hits)
    if(self.hits < self.shield) then
      self:state("visible")
      sfx(5)
      self.hit_count = self.hit_fr
    end

  end
})