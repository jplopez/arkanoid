
function nil_line()
  local line = {}
  for i=1,_max_col do
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
_lvl_def[1] = {
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
_lvl_def[4] = {
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
