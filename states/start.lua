-- start
function draw_start()
  cls(_pals.bg[1])
  printc("pico-8 arkanoid", 40, 10)
  printc("press ❎ to start", 60, 11)
  printc("made with ♥ by jp", 110, 9)
end

function update_start()
  local t = _timers["start_timer"]
  if t.active then
    log("start_timer " .. tostr(t.length))
    t:update()
  else
    if btn(5) then
      sfx(3)
      t:restart()
    end
  end
end

function startgame(l)
  l = l or 1

  log("startgame " .. tostr(l))
 
  -- reset paddle and ball
  local p = _players["p1"]["paddle"]
  local b = _players["p1"]["ball"]

  p:init()
  -- p.x = 64 - p.w / 2
  -- p.dx = 4
  -- p.state = "idle"
  b:serve()

  -- reset player data
  _players["p1"]["lives"] = 3
  _players["p1"]["score"] = 0
  _players["p1"]["level"] = l
  _players["p1"]["combo"] = 0
  init_bonus()

  _cur_lvl:init(l)

  _state = "game"

end