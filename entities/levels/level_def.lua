
function nil_line()
  local line = {}
  for i=1,_max_cols do
    add(line, nil)
  end
  return line
end

-- common_brick=function() return brick:new() end
-- au = function() return brick:new({ unbreakable = true, s=38 }) end
-- bora = function() return brick:new({ s=20 }) end
-- bred = function() return brick:new({ s=21 }) end
-- bgreen = function() return brick:new({ s=22 }) end
-- bblue = function() return brick:new({ s=23 }) end
-- bpink = function() return brick:new({ s=36 }) end

-- al = function() return shieldbrick(2) end
-- ti = function() return shieldbrick(4) end


_lvl_map = {
  col_sep = ",",
  row_sep = "|",
  default = {
    type = function() return brick:new() end,
    count = true
  },
  n = nil,
  b = {
    type = function() return brick:new() end,
    count = true
  },
  bo = {
    type = function() return brick:new({ s=20 }) end,
    count = true
  },
  br = {
    type = function() return brick:new({ s=21 }) end,
    count = true
  },
  bg = {
    type = function() return brick:new({ s=22 }) end,
    count = true
  },
  bb = {
    type = function() return brick:new({ s=23 }) end,
    count = true
  },
  bp = {
    type = function() return brick:new({ s=36 }) end,
    count = true
  },

  s = {
    type = function() return shieldbrick(2) end,
    count = true
  },
  ti = {
    type = function() return shieldbrick(4) end,
    count = true
  },

  g = {
    type = function() return brick:new({ unbreakable = true, s=38 }) end,
    count = false
  }
}

_lvl_def2 = {
  [1] = "|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
      "n,n,n,n,n,s,s,s,s,s,n,n,n,n,n|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
      "n,n,n,n,n,s,s,s,s,s,n,n,n,n,n|",

-- [1] = "|"..
--       "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
--       "n,n,n,n,bo,bo,bo,bo,bo,bo,bo,n,n,n,n|"..
--       "n,n,n,bo,bo,bo,bo,bo,bo,bo,bo,bo,n,n,n|"..
--       "n,n,br,br,br,br,br,br,br,br,br,br,br,n,n|"..
--       "n,n,br,br,br,br,br,br,br,br,br,br,br,n,n|"..
--       "n,n,br,br,br,br,br,br,br,br,br,br,br,n,n|"..
--       "n,n,n,bo,bo,bo,bo,bo,bo,bo,bo,bo,n,n,n|"..
--       "n,n,n,n,bo,bo,bo,bo,bo,bo,bo,n,n,n,n|"..
--       "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|",

[2] = "|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
      "n,n,n,n,bo,bo,bo,bo,bo,bo,bo,n,n,n,n|"..
      "n,n,n,bo,bo,bo,bo,bo,bo,bo,bo,bo,n,n,n|"..
      "n,n,br,br,br,br,br,br,br,br,br,br,br,n,n|"..
      "n,n,s,s,s,s,s,s,s,s,s,s,s,n,n|"..
      "n,n,br,br,br,br,br,br,br,br,br,br,br,n,n|"..
      "n,n,n,bo,bo,bo,bo,bo,bo,bo,bo,bo,n,n,n|"..
      "n,n,n,n,bo,bo,bo,bo,bo,bo,bo,n,n,n,n|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|",

[3] = "||"..
      "n,n,s,s,s,s,s,s,s,s,s,s,s,n,n|"..
      "n,n,b,b,b,b,b,b,b,b,b,b,b,n,n|"..
      "n,n,b,b,b,b,b,b,b,b,b,b,b,n,n|"..
      "n,n,b,b,b,b,b,b,b,b,b,b,b,n,n|"..
      "n,n,b,b,b,b,b,b,b,b,b,b,b,n,n|"..
      "n,n,b,b,b,b,b,b,b,b,b,b,b,n,n|"..
      "n,n,b,b,b,b,b,b,b,b,b,b,b,n,n||",

[4] = "|"..
      "n,n,s,s,s,s,s,s,s,s,s,s,s,n,n|"..
      "n,n,b,b,b,b,b,b,b,b,b,b,b,n,n|"..
      "n,n,b,b,b,b,b,b,b,b,b,b,b,n,n|"..
      "n,n,b,b,b,b,b,b,b,b,b,b,b,n,n|"..
      "n,n,b,b,b,b,b,b,b,b,b,b,b,n,n|"..
      "n,n,b,b,b,b,b,b,b,b,b,b,b,n,n|"..
      "n,n,b,b,b,b,b,b,b,b,b,b,b,n,n|"..
      "n,n,g,g,g,g,g,g,g,g,g,g,g,n,n|"..
      "n,n,n,n,n,n,n,n,n,n,n,n,n,n,n|",

[5] = "|"..
      "b,b,b,b,b,b,n,n,n,n,n,n,n,n,n|"..
      "b,b,b,b,b,b,b,n,n,n,n,n,n,n,n|"..
      "b,b,b,b,b,b,b,b,n,n,n,n,n,n,n|"..
      "b,b,b,b,b,b,b,b,b,n,n,n,n,n,n|"..
      "b,b,b,b,b,b,b,b,b,b,n,n,n,n,n|"..
      "b,b,b,b,b,b,b,b,b,b,b,n,n,n,n|"..
      "b,b,b,b,b,b,b,b,b,b,b,b,n,n,n|"..
      "g,g,g,g,g,g,g,g,g,g,g,g,s,s,s|"..
      "|",

[6] = "g,g,g,n,n,g,g,g,g,g,n,n,g,g,g|"..
      "g,b,b,n,n,g,b,b,b,g,n,n,b,b,g|"..
      "g,b,b,n,n,g,b,b,b,g,n,n,b,b,g|"..
      "g,b,b,n,n,g,b,b,b,g,n,n,b,b,g|"..
      "||"..
      "n,n,g,g,g,g,g,g,g,g,g,g,g,n,n|"..
      "n,n,g,b,b,b,b,b,b,b,b,b,g,n,n|"..
      "n,n,g,b,b,b,b,b,b,b,b,b,g,n,n|"..
      "n,n,g,b,b,b,b,b,b,b,b,b,g,n,n|"

}

-- --level5
-- _lvl_def[5] = {
--   { nil, nil, nil, slow_x_brick, nil, nil, shield_brick, shield_brick,shield_brick, nil, nil, slow_x_brick, nil, nil, nil },
--   { nil, nil, nil, slow_x_brick, nil, nil, brick, brick, brick, nil, nil, slow_x_brick, nil, nil, nil },
--   { nil, nil, nil, slow_x_brick, nil, nil, brick, brick, brick, nil, nil, slow_x_brick, nil, nil, nil },
--   { nil, nil, nil, slow_x_brick, nil, nil, brick, brick, brick, nil, nil, slow_x_brick, nil, nil, nil },
--   { nil, nil, nil, slow_x_brick, nil, nil, brick, brick, brick, nil, nil, slow_x_brick, nil, nil, nil },
--   { nil, nil, nil, slow_x_brick, nil, nil, brick, brick, brick, nil, nil, slow_x_brick, nil, nil, nil },
--   { nil, nil, nil, slow_x_brick, nil, nil, brick, brick, brick, nil, nil, slow_x_brick, nil, nil, nil },
--   { nil, nil, nil, god_brick, nil, nil, god_brick, brick, god_brick, nil, nil, god_brick, nil, nil, nil },
--   nil_line(),
--   nil_line()
-- }

-- _lvl_def[6] = {
--   nil_line(),
--   nil_line(),
--   { nil, nil, nil, god_brick, god_brick, shield_brick, brick, brick, brick, shield_brick, god_brick, god_brick, nil, nil, nil },
--   { nil, nil, nil, nil, mid_x_brick, nil, brick, brick, brick, nil, mid_x_brick, nil, nil, nil, nil },
--   { nil, nil, nil, nil, mid_x_brick, nil, brick, brick, brick, nil, mid_x_brick, nil, nil, nil, nil },
--   { nil, nil, nil, nil, mid_x_brick, nil, brick, brick, brick, nil, mid_x_brick, nil, nil, nil, nil },
--   { nil, nil, nil, nil, mid_x_brick, nil, brick, brick, brick, nil, mid_x_brick, nil, nil, nil, nil },
--   { nil, nil, nil, god_brick, nil, god_brick, shield_brick, shield_brick, shield_brick, god_brick, nil, god_brick, nil, nil, nil },
--   nil_line(),
--   nil_line()
-- }
