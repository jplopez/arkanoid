gameover_gst=gst_handler:extend({
  snd=true,
  hs=false,

  on=function(_ENV)snd=(true)hs=false end,
  off=function(_ENV)_score:reset()end,
  
  update=function(_ENV)
    --play gameover music
    music(-1)
    if(stat(46)==-1 and snd) then 
      sfx(30)
      snd=false
    end
    _plevel=1
    if(_score:is_highest())hs=true
    -- start game delay
    if(btn(5))sfx(3)delay(6,function()gset(game)end)
  end,

  draw=function(_ENV)
    cls(1)
    printoc("gameover",25,_pal_h1,_pal_h1o)
    printc("score:".._score:tostring(),35,_pal_h2)
    if(hs)printoc("new high score!",42,_pal_h2,_pal_h2o)
    printoc("press ❎ to start",80,_pal_h2,_pal_h2o)
  end,
})