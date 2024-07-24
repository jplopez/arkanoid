-- gameover
function update_gameover()
    -- reset player data 
    update_start()
end
   
function draw_gameover()
    cls(_pals.bg[1])
    local str = "gameover"
    local x=64-(#str*4)/2
    printo(str,x, 40, 8, 7)
    printc("score:"..
      _players["p1"]["score"],55,10)
    printc("press ❎ to start",70,11)
end