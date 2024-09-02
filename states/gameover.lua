gameover_gamestate = start_gamestate:new({
   
  draw=function(self)
    cls(1)
    local str = "gameover"
    local x=64-(#str*4)/2
    printoc("gameover", 25, _pal_h1, _pal_h1o)
    printc("score:".. _pscore, 35, _pal_h2)
    if(_pscore >= _high_score) printsc("New high score!", 42, _pal_h2)
    printoc("press ❎ to start", 80,_pal_h2, _pal_h2o)
  end
})