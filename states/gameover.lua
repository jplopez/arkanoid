gameover_gamestate={

  snd=true,
  
  update=function(self)
    --play gameover music
    music(-1)
    if(stat(46)==-1 and self.snd) then 
      sfx(30)
      self.snd=false
    end
    _plevel=1
    -- start game delay
    if btn(5) then
      sfx(3)
      delay(6,startgame,_plevel)
      self.y=_screen_bot
    end

  end,

  draw=function(self)
    cls(1)
    printoc("gameover", 25, _pal_h1, _pal_h1o)
    printc("score:".. _score:tostr(), 35, _pal_h2)
    if(_score:is_high_score()) printoc("New high score!", 42, _pal_h2, _pal_h2o)
    printoc("press ❎ to start", 80,_pal_h2, _pal_h2o)
  end
}