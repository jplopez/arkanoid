gameover_gamestate = start_gamestate:new({
   
  draw=function(self)
    cls(1)
    local str = "gameover"
    local x=64-(#str*4)/2
    printo(str,x, 40, 8, 7)
    printc("score:".. _pscore,55,10)
    printc("press ❎ to start",70,11)
  end
})