-- level
level = class:new({
  pad_row = 0,
  pad_col = 0,

  -- br_clrs = { 8, 9, 11, 12, 13 },
  br_clrs = {20, 21, 22, 23, 36},
  grid = {},
  lvl = 1,

  br_count = 0,
  br_left = 0,


  init = function(self, lvl)
    log("begin level init " .. lvl, true)
    self.grid, self.br_left, self.br_count = parse_level(lvl)
    log("end level init " .. lvl)
    log(" br_count "..self.br_count.." br_left "..self.br_left)
  end,

  __len = function(self)
    return self.br_count
  end,

  update = function(self, upd_func)
    for r = 1, _max_rows do
      for c = 1, _max_cols do
        self:upd_br(r, c, upd_func)
      end
    end
  end,

  upd_br = function(self, r, c, upd_func)
    local br = self.grid[r][c]
    if br != nil and br.visible then
      if upd_func != nil then
        upd_func(self, br)
      else
        br:update()
      end
    end
  end,

  draw = function(self, draw_func)
    for r = 1, _max_rows do
      for c = 1, _max_cols do
        self:draw_br(r, c, draw_func)
      end
    end
  end,

  draw_br = function(self, r, c, draw_func)
    local br = self.grid[r][c]
    if br != nil then
      if draw_func != nil then
        draw_func(self, br)
      else
        br:draw()
      end
    end
  end
})

