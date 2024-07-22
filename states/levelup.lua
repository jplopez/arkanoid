-- levelup
function update_levelup()
  log("update_levelup begin ")
  log("  level " .. _players["p1"]["level"])

  local t = _timers["levelup_timer"]
  if t.active then
    log("levelup_timer "..tostr(t.length))
    t:update()
  else
    if btn(5) then
      sfx(3)
      t:restart()
    end
  end
end

function draw_levelup()
  local l = _players["p1"]["level"]

  cls(_pals.bg[1])
  printc("level " .. tostr(l)
        .. " clear!", 25, 8
  )
  printc("lives : "
        .. _players["p1"]["lives"], 40, 8
  )
  printc("current score:"
        .. _players["p1"]["score"], 55, 10
  )
  printc("press ❎ to start next level", 70, 11
  )
end

function levelup()
  log("levelup begin level:" .. _players["p1"]["level"])

  -- reset paddle and ball
  local p = _players["p1"]["paddle"]
  local b = _players["p1"]["ball"]

--  p.x = 64 - p.w / 2
--  p.dx = 4
--  p.state = "idle"
  p:init()
  b:serve()

  --load new level
  _players["p1"]["level"] += 1
  _cur_lvl:init(_players["p1"]["level"])

  _state = "game"

  log("levelup end level:" .. _players["p1"]["level"])
end