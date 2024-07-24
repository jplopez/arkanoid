-- game

serve_countdown = 10
cur_countdown = 0

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

  -- serve ball, loose a serve count.
  if cur_countdown == 0 then
    if btn(4) then
      local serves = _players["p1"]["serves"]
      if serves > 0 then
        local b = _players["p1"]["ball"]
        _players["p1"]["serves"]=serves-1
        draw_serves(serves-1)
        b:serve()
        cur_countdown = serve_countdown
      end
    end
  else 
    cur_countdown-=1
  end
end

function draw_game()
  cls(0)
  draw_game_level()
  draw_game_ui()
  draw_players()
  draw_bonus()
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
  spr(0, _screen_left, 0)
  local next_x = print(" "..liv, _screen_left+8, 1, 9)
  draw_serves(_players["p1"]["serves"])

  --level
  local lev = "level:"..pad(_players["p1"]["level"], 2)
  next_x = printc(lev, 1, 9)

  --score
  local score = pad(_players["p1"]["score"], 6)
  local str = pad(_players["p1"]["score"], 6)
  next_x = print(str, _screen_right - (#str*4), 1, 9)
end

function draw_players()
  _players["p1"]["ball"]:draw()
  _players["p1"]["paddle"]:draw()
end

function draw_serves(n)
  --n = mid(0,n,4)
  if n == 0 then
    spr(7,_screen_left, 7)
    spr(7,_screen_left + 8, 7)
  elseif n == 1 then
    spr(6,_screen_left, 7)
    spr(7,_screen_left + 8, 7)

  elseif n == 2 then
    spr(5,_screen_left, 7)
    spr(7,_screen_left + 8, 7)
  elseif n == 3 then
    spr(5,_screen_left, 7)
    spr(6,_screen_left + 8, 7)
  else -- n ==4
    spr(5,_screen_left, 7)
    spr(5,_screen_left + 8, 7)
  end
end