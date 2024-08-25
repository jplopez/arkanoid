
function nil_line()
  local line = {}
  for i=1,_max_cols do
    add(line, nil)
  end
  return line
end

-- Test Level 3x3 in center
-- _lvl_def[1] = {
--   nil_line(),
--   nil_line(),
--   nil_line(),
--   { nil, nil, nil, nil, nil, nil, brick, brick, brick, nil, nil, nil, nil, nil, nil },
--   { nil, nil, nil, nil, nil, nil, brick, brick, brick, nil, nil, nil, nil, nil, nil },
--   { nil, nil, nil, nil, nil, nil, brick, brick, brick, nil, nil, nil, nil, nil, nil },
--   { nil, nil, nil, nil, nil, nil, brick, brick, brick, nil, nil, nil, nil, nil, nil },
--   nil_line(),
--   nil_line(),
--   nil_line()
-- }

--level1
-- _lvl_def[2] = {
--   nil_line(),
--   { nil, nil, nil, nil, nil, brick, brick, brick, brick, brick, nil, nil, nil, nil, nil },
--   { nil, nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil, nil },
--   { nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil },
--   { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
--   { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
--   { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
--   { nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil },
--   { nil, nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil, nil },
--   { nil, nil, nil, nil, nil, brick, brick, brick, brick, brick, nil, nil, nil, nil, nil }
-- }

-- --level2
-- _lvl_def[1] = {
--   nil_line(),
--   { nil, nil, nil, nil, nil, brick, brick, brick, brick, brick, nil, nil, nil, nil, nil },
--   { nil, nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil, nil },
--   { nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil },
--   { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
--   { nil, nil, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, nil, nil },
--   { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
--   { nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil },
--   { nil, nil, nil, nil, brick, brick, brick, brick, brick, brick, brick, nil, nil, nil, nil },
--   { nil, nil, nil, nil, nil, brick, brick, brick, brick, brick, nil, nil, nil, nil, nil }
-- }

-- --level3
-- _lvl_def[3] = {
--   nil_line(),
--   nil_line(),
--   { nil, nil, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, nil, nil },
--   { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
--   { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
--   { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
--   { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
--   { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
--   { nil, nil, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, brick, nil, nil },
--   nil_line()
-- }

-- --level4
-- _lvl_def[4] = {
--   nil_line(),
--   nil_line(),
--   { nil, nil, nil, god_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, shield_brick, god_brick, nil, nil, nil },
--   { nil, nil, nil, shield_brick, brick, brick, brick, brick, brick, brick, brick, shield_brick, nil, nil, nil },
--   { nil, nil, nil, shield_brick, brick, brick, brick, brick, brick, brick, brick, shield_brick, nil, nil, nil },
--   { nil, nil, nil, god_brick, brick, brick, brick, brick, brick, brick, brick, god_brick, nil, nil, nil },
--   { nil, nil, nil, god_brick, brick, brick, brick, brick, brick, brick, brick, god_brick, nil, nil, nil },
--   { nil, nil, nil, god_brick, brick, brick, brick, brick, brick, brick, brick, god_brick, nil, nil, nil },
--   { nil, nil, nil, god_brick, brick, brick, god_brick, god_brick, god_brick, brick, brick, god_brick, nil, nil, nil },
--   nil_line(),
--   nil_line()
-- }

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

au = brick:new({ unbreakable = true, clr=38 })
bora = brick:new({ clr=20 })
bred = brick:new({ clr=21 })
bgreen = brick:new({ clr=22 })
bblue = brick:new({ clr=23 })
bpink = brick:new({ clr=36 })

al = shield_brick:new({ shield=2})
ti = shield_brick:new({ shield=4})


_lvl_map = {
  col_sep = ",",
  row_sep = "|",
  default = {
    type = brick,
    count = true
  },
  n = nil,
  b = {
    type = brick,
    count = true
  },
  bo = {
    type = bora,
    count = true
  },
  br = {
    type = bred,
    count = true
  },
  bg = {
    type = bgreen,
    count = true
  },
  bb = {
    type = bblue,
    count = true
  },
  bp = {
    type = bpink,
    count = true
  },

  s = {
    type = al,
    count = true
  },
  ti = {
    type = ti,
    count = true
  },

  g = {
    type = au,
    count = false
  }
}

_lvl_def2 = {
[1] = "|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
      "n,n,n,n,bo,bo,bo,bo,bo,bo,bo,n,n,n,n|"..
      "n,n,n,bo,bo,bo,bo,bo,bo,bo,bo,bo,n,n,n|"..
      "n,n,br,br,br,br,br,br,br,br,br,br,br,n,n|"..
      "n,n,br,br,br,br,br,br,br,br,br,br,br,n,n|"..
      "n,n,br,br,br,br,br,br,br,br,br,br,br,n,n|"..
      "n,n,n,bo,bo,bo,bo,bo,bo,bo,bo,bo,n,n,n|"..
      "n,n,n,n,bo,bo,bo,bo,bo,bo,bo,n,n,n,n|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|",

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
