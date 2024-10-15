-- parses level definitions into a grid of blocks for an 'level' entity type
function parse_level(lvl)
  -- safety check and when player
  -- finishes all available levels
  if(_lvl_def2[lvl]==nil)lvl=1
  local lvl_def=_lvl_def2[lvl]
  -- Local vars
  --   grid = resulting bricks
  --   br_x, br_y = x,y of next brick
  --   br_count = # of bricks to count until level is complete
  --   br_total = # of total bricks in level. br_total >= br_count
  local grid,br_x,br_y,br_count,br_total={},_screen_left,_screen_top,0,0

  local rows=split(lvl_def,_lvl_map["row_sep"])
  for r=1,_max_rows do
    grid[r]={}
    br_y=_screen_top+(r*brick.h)
    br_x=_screen_left
    if(is_empty(rows[r]))then grid[r]=nil_line()
    else
      local cols=split(rows[r],_lvl_map["col_sep"])
      for c=1,_max_cols do
        local br=parse_brick(cols[c],br_x,br_y)
        if(br!=nil)then
          grid[r][c]=br
          br_count+=(br.unbreakable) and 0 or 1 --parse_count
          br_total+=1
        end
        br_x=_screen_left+(c*brick.w)
      end -- cols
    end 
  end -- rows
  return grid,br_count,br_total
end

function parse_brick(br_map,br_x,br_y)
  local br_def=_lvl_map[br_map]
  if(br_def==nil)return nil,0
  local br=br_def["type"]()
  br.x,br.y=br_x,br_y
  br:set(visible)
  return br
end