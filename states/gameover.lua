gameover_gst=gst_handler:extend({
  snd=true,

  on=function(_ENV)snd=true end,
  
  update=function(_ENV)
    --play gameover music
    music(-1)
    if(stat(46)==-1 and snd) then 
      sfx(30)
      snd=false
    end
    _plevel=1
    -- start game delay
    if btn(5) then
      sfx(3)
      delay(6,startgame,_plevel)
      --self.y=_screen_bot
    end
  end,

  draw=function(_ENV)
    cls(1)
    printoc("gameover",25,_pal_h1,_pal_h1o)
    printc("score:".._score:tostring(),35,_pal_h2)
    if(_score:is_high_score())printoc("New high score!",42,_pal_h2,_pal_h2o)
    printoc("press ❎ to start",80,_pal_h2,_pal_h2o)
  end
})