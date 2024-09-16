function shieldbrick(sh)
  return brick:new({
    shield = sh or 2,
    hits = 0,
    s = 37,
    hf = 3, -- frames for hit anim
    hc = 0,  -- hit counter
  
    update = function(self)
      self.s = 37
      if self.hc>0 then
        self.s=4
        self.hc-=1
      end
    end,
  
    on_collision = function(self, b)
      -- log("shield brick on collision")
      local n_hits = b:hits()
      self.hits += n_hits
      self:score_hit(n_hits, b:power())
      if(self.hits < self.shield) then
        sfx(5)
        self.hc = self.hf
        return self:state("visible")
      end
      return (self:state("hit"))
    end
  })
end