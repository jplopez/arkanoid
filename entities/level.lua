level=entity:extend({
  grid={},
  lvl=1,
  br_count=0,
  br_left=0,
  lvl_map=nil,

  init=function(_ENV)
    grid,br_left,br_count=parse_level(lvl)
    lvl_map=rnd(_maps)
    music(-1)
    music(lvl_map.m,6000,_music_channels)
  end,

  update=function(_ENV)
    if(br_left<=0) return
    for r=1,_max_rows do
      for c=1,_max_cols do
        local br=grid[r][c]
        if(br!=nil and br:is(visible))br:update()
      end
    end
  end,

  draw=function(_ENV)
    -- level map
    map(lvl_map.x,lvl_map.y,0,_screen_top,16,16)  
    -- bricks
    for r=1,_max_rows do
      for c=1,_max_cols do
        local br=grid[r][c]
        if(br!=nil) br:draw()
      end
    end
  end
})

