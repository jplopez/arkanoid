gameover_gamestate = start_gamestate:new({
  
  update=function(self)
    --play gameover music
    music(-1)
    _plevel=1
    -- start game delay
    local timer = _timers["start_timer"]
    if timer.active then
      timer:update()
    else
      if btn(5) then
        sfx(3)
        timer:restart()
      end
    end
  end,

  draw=function(self)
    cls(1)
    printoc("gameover", 25, _pal_h1, _pal_h1o)
    printc("score:".. _score:tostr(), 35, _pal_h2)
    if(_score:is_high_score()) printoc("New high score!", 42, _pal_h2, _pal_h2o)
    printoc("press ❎ to start", 80,_pal_h2, _pal_h2o)
  end
})