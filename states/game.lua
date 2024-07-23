-- game
function update_game()
  log("update_game begin ")
  _cur_lvl:update()

  --apply changes to objects
  _col_eng:update(_col_eng)
  _players["p1"]["ball"]:update()
  _players["p1"]["paddle"]:update()

  if _cur_lvl.br_left <= 0 then
    log("update_game levelup")
    _state = "levelup"
  end

  update_bonus()
  log("update_game end ")

  -- serve ball, loose a life.
  if btn(4) then
    local lives = _players["p1"]["lives"]
    if lives > 0 then
      local b = _players["p1"]["ball"]
      --_players["p1"]["lives"]=lives-1
      b:serve()
    end
  end
end

function draw_game()
  cls(0)
  draw_game_level()
  draw_game_ui()
  draw_players()
  debug()
end

function draw_game_level()
  --playable screen
  rect(
    _screen_left - 1,
    _screen_top - 1,
    _screen_right + 1,
    _screen_bot + 1,
    _pals.bg[2]
  )
  rectfill(
    _screen_left,
    _screen_top,
    _screen_right,
    _screen_bot,
    _pals.bg[1]
  )

  --level bricks
  _cur_lvl:draw()
end

function draw_game_ui()
  --player lives
  local liv = pad(_players["p1"]["lives"], 2)
  local next_x = print(
    "p1X" .. liv,
    _screen_left, 1, 9
  )

  --level
  local lev = pad(_players["p1"]["level"], 2)
  next_x = print(
    "level " .. lev,
    next_x + 5, 1, 9
  )

  --score
  local score = pad(_players["p1"]["score"], 6)
  next_x = print(
    "score: " .. score,
    _screen_right - 50, 1, 9
  )
end

function draw_players()
  _players["p1"]["ball"]:draw()
  _players["p1"]["paddle"]:draw()
end