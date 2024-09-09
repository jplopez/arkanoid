function composite_brick()
  return brick:new({
    bricks = {},
    oob_bricks = {},

    union = function(self, other, oob)
      -- log("compo union")
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
      -- log("brick.union self=(" .. self.x .. "," .. self.y .. "," .. self.w .. "," .. self.h .. ")")
      -- log("brick union bricks: " .. #self.bricks)
      -- log("brick union oob br: " .. #self.oob_bricks)
      return self
    end,

    on_collision = function(self, b)
      local hit=0
      for br in all(self.bricks) do
        br:on_collision(b)
        if(br:state("hit")) hit+=1
      end
      return hit
    end,

    hidden_count = function(self)
      local c = 0
      for br in all(self.bricks) do
        if((not br.unbreakable)and(not br:is_state("visible"))) c+=1
      end
      return c
    end
  })
end
