-- level
level = class:new({
  max_row = _max_row,
  max_col = _max_col,

  pad_row = 0,
  pad_col = 0,

  -- br_clrs = { 8, 9, 11, 12, 13 },
  br_clrs = {20, 21, 22, 23, 36},
  grid = {},
  lvl = 1,

  br_count = 0,
  br_left = 0,
  
  grid_min_x = _screen_bot,
  grid_min_y = _screen_right,
  grid_max_x = _screen_top,
  grid_max_y = _screen_left,

  init = function(self, lvl)
    log("begin level init " .. lvl, true)
    local brick_types = self:get_brick_types(lvl)
    --log2(brick_types)

    self.br_count = 0
    self.br_left = 0

    local br_x = _screen_left
    local br_y = _screen_top
    
    self.grid_min_x = _screen_bot
    self.grid_min_y = _screen_right
    self.grid_max_x = _screen_top
    self.grid_max_y = _screen_left

    for r = 1, self.max_row do
      self.grid[r] = {}
      br_y += brick.h + self.pad_row
      br_x = _screen_left
      for c = 1, self.max_col do
        local br_type = brick_types[r][c]
        if br_type ~= nil then
          local br = br_type:new({
            x = br_x, y = br_y
          })
          br:state("visible")
          if br_type == brick then
            br.clr=self.br_clrs[lvl]
          end
          self.grid[r][c] = br
          --log2(self.grid[r][c])
          self.br_count += 1
          if br_type ~= god_brick then
            self.br_left += 1
          end

          self.grid_min_x = min(self.grid_min_x, br.x)
          self.grid_min_y = min(self.grid_min_y, br.y)
          self.grid_max_x = max(self.grid_max_x, br.x+br.w)
          self.grid_max_y = max(self.grid_max_y, br.y+br.h)

        end
        br_x += brick.w + self.pad_col
      end
    end
    log("end level init " .. lvl)
    log(" br_count "..self.br_count.." br_left "..self.br_left)
    log2(self.grid)
  end,

  get_brick_types=function(self, lvl)
    return parse_level_def(lvl)
  end,

  __len = function(self)
    return self.br_count
  end,

  on_collision = function(self, r, c, col_func)
    local br = self.grid[r][c]
    if br != nil and br:visible() then
      if col_func != nil then
        col_func(self, br)
      else
        br:on_collision()
      end
    end
  end,

  update = function(self, upd_func)
    for r = 1, self.max_row do
      for c = 1, self.max_col do
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
    for r = 1, self.max_row do
      for c = 1, self.max_col do
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

