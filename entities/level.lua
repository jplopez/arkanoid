-- level
level = class:new({
  max_row = 10,
  max_col = 16,

  pad_row = 0,
  pad_col = 0,

  -- br_clrs = { 8, 9, 11, 12, 13 },
  br_clrs = {20, 21, 22, 23, 36},
  grid = {},
  lvl = 1,

  br_count = 0,
  br_left = 0,

  init = function(self, lvl)
    log("begin level init " .. lvl)
    lvl = mid(1, lvl, #_lvl_def)
    local brick_types = _lvl_def[lvl]

    self.br_count = 0
    self.br_left = 0

    local br_x = _screen_left
    local br_y = _screen_top
    

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
          if br_type == brick then
            br.clr=self.br_clrs[lvl]
          end
          self.grid[r][c] = br

          self.br_count += 1
          if br_type ~= god_brick then
            self.br_left += 1
          end
        end
        br_x += brick.w + self.pad_col
      end
    end
    log("end level init " .. lvl)
    log(" br_count "..self.br_count.." br_left "..self.br_left)

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

function nil_line()
  local line = {}
  for i=1,level.max_col do
    add(line, nil)
  end
  return line
end


-- level definitions
-- items in _lvl_def are
-- a 2d [10][10] array with
-- the brick_type in each cell
_lvl_def = {}

--level1
_lvl_def[4] = {
  nil_line(),
  { nil, nil, nil, nil, nil, brick, brick, brick, brick, brick, nil, nil, nil, nil, nil },
  { nil, nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil, nil },
  { nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil },
  { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
  { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
  { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
  { nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil },
  { nil, nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil, nil },
  { nil, nil, nil, nil, nil, brick, brick, brick, brick, brick, nil, nil, nil, nil, nil }
}

--level2
_lvl_def[2] = {
  nil_line(),
  { nil, nil, nil, nil, nil, brick, brick, brick, brick, brick, nil, nil, nil, nil, nil },
  { nil, nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil, nil },
  { nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil },
  { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
  { nil, nil, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, nil, nil },
  { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
  { nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil },
  { nil, nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil, nil },
  { nil, nil, nil, nil, nil, brick, brick, brick, brick, brick, nil, nil, nil, nil, nil }
}

--level3
_lvl_def[3] = {
  nil_line(),
  nil_line(),
  { nil, nil, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, nil, nil },
  { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
  { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
  { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
  { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
  { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
  { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
  nil_line()
}

--level4
_lvl_def[1] = {
  nil_line(),
  nil_line(),
  { nil, nil, nil, god_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, god_brick, nil, nil, nil },
  { nil, nil, nil, shield_brick, brick, brick, brick, brick, brick, brick, brick, shield_brick, nil, nil, nil },
  { nil, nil, nil, shield_brick, brick, brick, brick, brick, brick, brick, brick, shield_brick, nil, nil, nil },
  { nil, nil, nil, god_brick, brick, brick, brick, brick, brick, brick, brick, god_brick, nil, nil, nil },
  { nil, nil, nil, god_brick, brick, brick, brick, brick, brick, brick, brick, god_brick, nil, nil, nil },
  { nil, nil, nil, god_brick, brick, brick, brick, brick, brick, brick, brick, god_brick, nil, nil, nil },
  { nil, nil, nil, god_brick, brick, brick, god_brick, god_brick, god_brick, brick, brick, god_brick, nil, nil, nil },
  nil_line(),
  nil_line()
}

--level5
_lvl_def[5] = {
  { nil, nil, nil, slow_x_brick, nil, nil, shield_brick, shield_brick,shield_brick, nil, nil, slow_x_brick, nil, nil, nil },
  { nil, nil, nil, slow_x_brick, nil, nil, brick, brick, brick, nil, nil, slow_x_brick, nil, nil, nil },
  { nil, nil, nil, slow_x_brick, nil, nil, brick, brick, brick, nil, nil, slow_x_brick, nil, nil, nil },
  { nil, nil, nil, slow_x_brick, nil, nil, brick, brick, brick, nil, nil, slow_x_brick, nil, nil, nil },
  { nil, nil, nil, slow_x_brick, nil, nil, brick, brick, brick, nil, nil, slow_x_brick, nil, nil, nil },
  { nil, nil, nil, slow_x_brick, nil, nil, brick, brick, brick, nil, nil, slow_x_brick, nil, nil, nil },
  { nil, nil, nil, slow_x_brick, nil, nil, brick, brick, brick, nil, nil, slow_x_brick, nil, nil, nil },
  { nil, nil, nil, god_brick, nil, nil, god_brick, brick, god_brick, nil, nil, god_brick, nil, nil, nil },
  nil_line(),
  nil_line()
}

_lvl_def[6] = {
  nil_line(),
  nil_line(),
  { nil, nil, nil, god_brick, god_brick, shield_brick, brick, brick, brick, shield_brick, god_brick, god_brick, nil, nil, nil },
  { nil, nil, nil, nil, mid_x_brick, nil, brick, brick, brick, nil, mid_x_brick, nil, nil, nil, nil },
  { nil, nil, nil, nil, mid_x_brick, nil, brick, brick, brick, nil, mid_x_brick, nil, nil, nil, nil },
  { nil, nil, nil, nil, mid_x_brick, nil, brick, brick, brick, nil, mid_x_brick, nil, nil, nil, nil },
  { nil, nil, nil, nil, mid_x_brick, nil, brick, brick, brick, nil, mid_x_brick, nil, nil, nil, nil },
  { nil, nil, nil, god_brick, nil, god_brick, shield_brick, shield_brick, shield_brick, god_brick, nil, god_brick, nil, nil, nil },
  nil_line(),
  nil_line()
}

