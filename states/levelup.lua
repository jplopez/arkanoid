-- levelup
levelup_gamestate = gamestate:new({

  update=function(self)
    local timer = _timers["levelup_timer"]
    if timer.active then
      log("levelup_timer "..tostr(timer.length))
      timer:update()
    else
      if btn(5) then
        sfx(3)
        timer:restart()
      end
    end
  end,

  draw=function(self)
    local l = _players["p1"]["level"]

    cls(_pals.bg[1])
    printc("level " .. tostr(l)
          .. " clear!", 25, 8)
    printc("lives : "
          .. _players["p1"]["lives"], 40, 8)
    printc("current score:"
          .. _players["p1"]["score"], 55, 10)
    printc("press ❎ to start next level", 70, 11)
  end
})

function levelup()
  local cur_lvl = _players["p1"]["level"]
  log("Levelup - current level:" .. cur_lvl)

  -- reset paddle and ball
  local p = _players["p1"]["paddle"]
  local b = _players["p1"]["ball"]

  p:init()
  b:serve()

  --load new level
  local new_lvl = cur_lvl + 1
  _players["p1"]["level"] = new_lvl
  _cur_lvl:init(new_lvl)

  -- log("Game state: ".._state.." -> game - level:"..new_lvl)
  -- _state = "game"
  set_gamestate("game")

end