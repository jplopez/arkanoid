-- parses level definitions into a grid of blocks for an 'level' entity type

function parse_level_def(lvl)
  log("level parser "..lvl)
  lvl = mid(1, lvl, #_lvl_def)
  return _lvl_def[lvl]
end

_level_parser_mappings = {
  col_separator = ",",
  row_separator = "|",
  default = {
    type = brick,
    count = true
  }
}

function add_parser_mapping(key, value)
  if(key == nil or value == nil) return false

  if(key == "col_separator" or key == "row_separator") then
    log("WARNING: level_parser_mapping '"..key.."' is a reserved name. Mapping will not be saved")
    return false
  end

  local old_map = _level_parser_mappings[key]
  if(old_map != nil) then
    log("WARNING: level_parser_mapping '"..key.."' already exists. You will overrride it")
    log("WARNING: previous map:")
    log2(old_map)
  end 

  _level_parser_mappings[key] = value
end

function parse_level(level_def) --, settings)
  if(is_empty(level_def)) return false
  -- settings = settings or {}


  local grid = {}
  local brick_count = 0
  local rows = split(level_def, _level_parser_mappings["row_separator"])
  for r=1,_max_rows do
    grid[r] = {}
    if(is_empty(rows[r])) then
      grid[r] = nil_line()
    else
      local cols = split(rows[r], _level_parser_mappings["col_separator"])
      for c=1,_max_cols do
        local brick_map = cols[c]
        grid[r][c], count = parse_brick(brick_map)
        brick_count+=count
      end 
    end
  end

  return grid
end

function parse_brick(brick_map)
  local brick_def = _level_parser_mappings[brick_map]
  brick_def = brick_def or _level_parser_mappings["default"]
  local brick = brick_def["type"]:new()
  local count = 0 
  if(brick_def["count"]) then count=1 end
  return brick,count
end

