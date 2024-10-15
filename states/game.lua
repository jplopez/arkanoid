-- game state
game_gamestate = state_handler:new({

  update=function(self)
    _lvl:update() -- level
    _colle:update() -- collision engine

    --player's ball and paddle
    _pball:update()
    _ppaddle:update()
    _ppwrbar:update()
    _pweb:update()
    --world objects
    _score:update()
    upd_pups()
    --update_bonus()
    -- detect if all bricks were hit 
    if(_lvl.br_left <= 0) gamestate("levelup")

  end,

  draw=function(self)
    cls(0)
    shake_screen()
    draw_game_level()
    draw_game_ui()
    draw_players()
    --draw_bonus()
    -- local px = print("dx,dy:".._pball.dx..",".._pball.dy, _screen_left+2,_screen_top+2, 7)
    -- print(_pball:state(),px+1,_screen_top+2, 7)
  end
})

function draw_game_level()
  _lvl:draw() -- current level
  draw_pups() -- powerups  
  -- if(_debug) rect(_screen_left, _screen_top, _screen_right, _screen_bot, 2)
end

function draw_game_ui()
  --player lives
  spr(0, _screen_left, 0)
  print(" x " .. pad(_plives, 2), _screen_left+8, 1, 7)
  --current level
  print("level:"..pad(_plevel, 2), _screen_left+1, 7, 7)
  _score:draw()
end

function update_player()
  _pball:update()
  _ppaddle:update()
  _ppwrbar:update()
  _pweb:update()
end

function draw_players()
  _pball:draw()
  _ppaddle:draw()
  _ppwrbar:draw()
  _pweb:draw()
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

function upd_pups()
  for p in all(_pups) do
    p:update()
  end

  for b in all(_pup_extra_balls) do
    b:update()
  end
end

function draw_pups()
  for p in all(_pups) do
    p:draw()
  end

  for b in all(_pup_extra_balls) do
    b:draw()
  end

end
