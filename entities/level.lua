level = class:new({
  grid = {},
  lvl = 1,

  br_count = 0,
  br_left = 0,

  map=nil,

  init = function(self, lvl)
    log("begin level init " .. lvl, true)
    self.grid, self.br_left, self.br_count = parse_level(lvl)
    self.map = rnd(_maps)
    log("end level init " .. lvl)
    log(" br_count "..self.br_count.." br_left "..self.br_left)
  end,

  -- __len = function(self)
  --   return self.br_count
  -- end,

  update = function(self)
    -- detect if all bricks were hit 
    if(self.br_left <= 0) then 
      set_gamestate("levelup")
    else -- update bricks
      for r = 1, _max_rows do
        for c = 1, _max_cols do
          local br = self.grid[r][c]
          if(br != nil and br:is_state("visible")) br:update()
        end
      end
    end
  end,

  draw = function(self)
    -- level map
    map(self.map.x, self.map.y, 0, _screen_top, 16, 16)  
    -- bricks
    for r = 1, _max_rows do
      for c = 1, _max_cols do
        local br = self.grid[r][c]
        if(br != nil) br:draw()
      end
    end
  end
})

