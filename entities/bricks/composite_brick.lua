function composite_brick()
  return brick:new({
    bricks = {},
    oob_bricks = {},
    union = function(self, other, oob)
      if other != nil then
        if #self.bricks == 0 then
          self.x = other.x
          self.y = other.y
          self.w = other.w
          self.h = other.h
          self.clr = other.clr
          self.state = other.state
        else
          self = self:join(self, other)
        end
        if(oob) add(self.oob_bricks, other)
        if(not oob) add(self.bricks, other)
      end
      return self
    end,

    on_collision = function(self, b)
      local hit=0
      for br in all(self.bricks) do
        if(br:on_collision(b)=="hit") hit+=1
      end
      return hit
    end,
  })
end
