
composite_brick = brick:new({
  bricks = {},
  oob_bricks = {},

  new = function(self, other)
    tbl = brick.new(self, other)
    tbl.bricks = {}
    tbl.oob_bricks = {}

    return tbl
  end,

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
        self = brick.union(self, other)
      end
      if(oob) add(self.oob_bricks, other)
      if(not oob) add(self.bricks, other)
    end
    log("brick.union self=(" .. self.x .. "," .. self.y .. "," .. self.w .. "," .. self.h .. ")")
    log("brick union bricks: " .. #self.bricks)
    log("brick union oob br: " .. #self.oob_bricks)
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
      if((not br.unbreakable)and(not br:is_state("visible"))) count += 1
    end
    return count
  end
})
