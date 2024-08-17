-- game state
game_gamestate = gamestate:new({

  serve_countdown = 10,
  cur_countdown = 0,

  update=function(self)
    -- log("UPD state:game")

    -- current level
    _cur_lvl:update()

    -- collision engine
    _col_eng_v2:update()
  
    --player's ball and paddle
    _players["p1"]["ball"]:update()
    _players["p1"]["paddle"]:update()
  
    -- detect all bricks were hit 
    if _cur_lvl.br_left <= 0 then
      -- log("Game state: game -> levelup")
      -- _state = "levelup"
      set_gamestate("levelup")
    end
    
    update_bonus()
  
    -- serve ball, loose a serve count.
    if(btn(4)) self:btn_4(self)
  end,

  draw=function(self)
    -- log("draw state: game")
    cls(0)
    draw_game_level()
    draw_game_ui()
    draw_players()
    draw_bonus()
  end,

  --serves ball
  btn_4=function(self)
    if self.cur_countdown == 0 then
      
      local serves = _players["p1"]["serves"]
      if serves > 0 then
        local b = _players["p1"]["ball"]
        _players["p1"]["serves"]=serves-1
        draw_serves(serves-1)
        b:serve()
        self.cur_countdown = self.serve_countdown
      end
    else 
      self.cur_countdown-=1
    end
  end
})

function draw_game_level()
  --playable screen
  rectfill(
    _screen_left ,
    _screen_top,
    _screen_right,
    _screen_bot,
    _pals.bg[1]
  )
  rect(
    _screen_left,
    _screen_top,
    _screen_right,
    _screen_bot,
    _pals.bg[2]
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