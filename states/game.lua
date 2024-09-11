-- game state
game_gamestate = state_handler:new({

  update=function(self)
    _lvl:update() -- level
    _colle:update() -- collision engine

    --player's ball and paddle
    _pball:update()
    _ppaddle:update()
    _ppwrbar:update()

    --world objects
    --upd_high_score()
    _score:update()
    upd_pups()
    update_bonus()
    -- detect if all bricks were hit 
    if(_lvl.br_left <= 0) gamestate("levelup")

    -- serve ball
    if(btn(4)) _pball:serve()
  end,

  draw=function(self)
    -- log("draw state: game")
    cls(0)
    shake_screen()
    draw_game_level()
    draw_game_ui()
    draw_players()
    draw_bonus()
  end
})

function draw_game_level()
  _lvl:draw() -- current level
  draw_pups() -- powerups
  
  if(_debug) rect(_screen_left, _screen_top, _screen_right, _screen_bot, 2)
end

function draw_game_ui()
  --player lives
  spr(0, _screen_left, 0)
  print(" x " .. pad(_plives, 2), _screen_left+8, 1, 7)
  --current level
  print("level:"..pad(_plevel, 2), _screen_left+1, 7, 7)
  _score:draw()
  -- --high score
  -- printc("high score", 1, 7)
  -- printc(pad(_high_score, 6), 7, 7)
  -- --player score
  -- print("score", _screen_right - 20, 1, 7)
  -- print(pad(_pscore, 6), _screen_right - 24, 7, 7)
end

function draw_players()
  _pball:draw()
  _ppaddle:draw()
  _ppwrbar:draw()
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

-- function upd_high_score()
--   if(_pscore > _high_score) dset(_high_score_index, _pscore)
--   _high_score = dget(_high_score_index)
-- end

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
