-- parses level definitions into a grid of blocks for an 'level' entity type
function parse_level(lvl)

  -- safety check and when player
  -- finishes all available levels
  if(_lvl_def2[lvl]==nil ) lvl = 1
  local lvl_def = _lvl_def2[lvl]
  
  -- Local vars
  --   grid = resulting bricks
  --   br_x, br_y = x,y of next brick
  --   br_count = # of bricks to count until level is complete
  --   br_total = # of total bricks in level. br_total >= br_count
  local grid, br_x, br_y, br_count, br_total = {}, _screen_left, _screen_top, 0, 0

  local rows = split(lvl_def, _lvl_map["row_sep"])
  for r=1,_max_rows do
    grid[r] = {}
    br_y = _screen_top + (r*brick.h)
    br_x = _screen_left
    if(is_empty(rows[r])) then
      grid[r] = nil_line()
    else
      local cols = split(rows[r], _lvl_map["col_sep"])
      for c=1,_max_cols do
        local br_map = cols[c]
        br_type, count = parse_brick(br_map)
        --log("grid["..r.."]["..c.."] : ".. tostr(br_type) .. " count:"..tostr(count))
        grid[r][c] = br_type and create_brick(br_type, br_x, br_y) or nil
        --log2(grid[r][c])
        br_count+=count
        br_total+= br_type and 1 or 0
        br_x = _screen_left + (c*brick.w)
      end 
    end
  end
  return grid, br_count, br_total
end

function parse_brick(br_map, br_x, br_y)
  local br_def = _lvl_map[br_map]
  if(br_def==nil) return nil,0
  if(br_def["count"]) return br_def["type"],1
  return br_def["type"],0
end

function create_brick(br_type, br_x, br_y)
  local br = br_type:new({
    x = br_x, y = br_y
  })
  add_states(br, {"visible", "hit", "hidden"})
  br:state("visible")
  return br
end

function add_lvl_map(key, value, c)
  if(key == nil or value == nil) return false

  if(key == "col_sep" or key == "row_sep") then
    log("warning: level_parser_mapping '"..key.."' is a reserved name, it will not be saved")
    return false
  end
  local old_map = _lvl_map[key]
  if(old_map != nil) then
    log("warn: level_parser_mapping '"..key.."' already exists, it will be overrride")
    log("warn: previous map:")
    log2(old_map)
  end 

  c = c or true
  _lvl_map[key] = { 
      type = value,
      count = c }
end

