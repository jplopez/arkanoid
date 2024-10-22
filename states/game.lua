game_gst=gst_handler:extend({

  --TODO add pup cool down here

  on=function(_ENV)startgame()end,
  off=function(_ENV)music(-1)end,

  update=function(_ENV)
    --log("game update")
    entity:each("update")
    -- detect if all bricks were hit 
    if(global._lvl.br_left<=0)gset(levelup)
  
    -- collisions
    ball:each("detect",_ppaddle,function(obj)
        pb_handler:handle(obj,_ppaddle)end)
    ball:each("detect",nil,function(obj)
        bscr_handler:handle(obj)end)
    ball:each("detect",_pweb,function(obj)
        web_handler:handle(obj,_pweb)end)
    ball:each("detect",hit_blocks.brick,function(obj)
        br_handler:handle(obj,hit_blocks.brick)end)
  
    powerup:each("detect",_ppaddle,function(obj)
        pup_handler:handle(_ppaddle,obj)end)

    monitor_balls()
  end,

  draw=function(_ENV)
    cls(0)
    shake_screen()
    draw_game_ui(_ENV)
    global._lvl:draw()
    global._score:draw()
    global._ppwrbar:draw()
    global._ppaddle:draw()
    ball:each("draw")
    powerup:each("draw")
  end,
  
  draw_game_ui=function(_ENV)
    --player lives
    spr(0,_screen_left,0)
    print(" x "..pad(global._plives,2),_screen_left+8,1,7)
    --current level
    print("level:"..pad(global._plevel,2),_screen_left+1,7,7)
  end,
})
