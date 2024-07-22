-- gameover
function update_gameover()
    -- reset player data 
    _players["p1"]["lives"]=3
    _players["p1"]["score"]=0
    _players["p1"]["level"]=1 
    update_start()
end
   
function draw_gameover()
    cls(_pals.bg[1])
    printc("gameover",40,8)
    printc("score:"..
      _players["p1"]["score"],55,10)
    printc("press ❎ to start",70,11)
end