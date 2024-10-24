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
