shield_brick = brick:new({

  shield = 2,
  hits = 0,
  s = 37,

  hit_fr = 3,
  hit_count = 0,
  hit_s = 4,

  update = function(self)
    if self.hit_count > 0 then
      self.s = self.hit_s
      self.hit_count -= 1
    else
      self.s = 37
    end
  end,

  on_collision = function(self)
    log("shield brick on collision")
    local n_hits = _pball:hits()
    self.hits += n_hits
    self:score_hit(n_hits)
    if(self.hits < self.shield) then
      self:state("visible")
      sfx(5)
      self.hit_count = self.hit_fr
    end
    return (self:state("hit"))
  end
})