game_gst=gst_handler:extend({

  --TODO add pup cool down here

  on=function(_ENV)
    world={global._lvl,global._colle,global._pball,global._ppaddle,global._ppwrbar,global._pweb,global._score}
    global._ppaddle:init()
    global._pball:serve({dy=-1,dx=0.5})
    global._pcombo=0
    global._lvl.lvl=global._plevel
    global._lvl:init()
    global._pups={}
    disable_all_aspects()
  end,

  off=function(_ENV)music(-1)end,

  update=function(_ENV)
    for i in all(world)do i:update()end
    uarray(_ENV,global._pups)uarray(_ENV,global._pup_extra_balls)    
    -- detect if all bricks were hit 
    if(global._lvl.br_left<=0)gset(levelup)
  
    -- collisions
    --ball:each("detect",nil,)
    ball:each("detect",_ppaddle,pb_handler.handle,)


  end,

  draw=function(_ENV)
    cls(0)
    shake_screen()
    draw_game_ui(_ENV)
    for i in all(world)do i:draw()end
    darray(_ENV,global._pups)darray(_ENV,global._pup_extra_balls)
  end,
  
  draw_game_ui=function(_ENV)
    --player lives
    spr(0,_screen_left,0)
    print(" x "..pad(global._plives,2),_screen_left+8,1,7)
    --current level
    print("level:"..pad(global._plevel,2),_screen_left+1,7,7)
  end,

  uarray=function(_ENV,a) for p in all(a)do p:update()end end,
  darray=function(_ENV,a) for p in all(a)do p:draw()end end,
})

function shake_screen()
  local sh_x, sh_y = 0, 0
  if(_shake > 0) then
    sh_x=(4-rnd(8)) * _shake
    sh_y=(4-rnd(8)) * _shake
    _shake = (_shake<0.05) and 0 or (_shake*0.95)
  end
  camera(sh_x,sh_y)
end
