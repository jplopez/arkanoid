function startgame()
  log("startgame")
  ball:destroy_extra_balls()
  powerup:each("destroy")
  _pball:serve({dy=-1,dx=0.5})
  _ppaddle:serve()
  _pcombo=0
  _lvl:load(global._plevel)
  aspect:each("off")
end

function shake_screen()
  local sh_x, sh_y = 0, 0
  if(_shake > 0) then
    sh_x=(4-rnd(8)) * _shake
    sh_y=(4-rnd(8)) * _shake
    _shake = (_shake<0.05) and 0 or (_shake*0.95)
  end
  camera(sh_x,sh_y)
end

-- function draw_highscores(_y) 
--   printoc("high scores", _y,_pal_h1,_pal_h1o)
--   print("name"..spaces(2).."score",42,_y+10,7)
--   local highscores=score:load_highscores()
--   local ypos=_y+18
--   for i=1,3 do
--     local sc = highscores[i]
--     print(i.." ", 36,ypos,6)
--     print(sc.name..spaces(3)..sc.score,42,ypos,6)
--     ypos+=8
--   end
-- end

