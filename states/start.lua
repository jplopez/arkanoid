-- start
start_gamestate = gamestate:new({

  update=function(self)
    local timer = _timers["start_timer"]
    if timer.active then
      timer:update()
    else
      if btn(5) then
        sfx(3)
        timer:restart()
      end
    end
  end,

  draw=function(self)
    cls(_pals.bg[1])
    printc("pico-8 arkanoid", 40, 10)
    printc("press ❎ to start", 60, 11)
    printc("made with ♥ by jp", 110, 9)
  
  end

})

-- function draw_start()
--   cls(_pals.bg[1])
--   printc("pico-8 arkanoid", 40, 10)
--   printc("press ❎ to start", 60, 11)
--   printc("made with ♥ by jp", 110, 9)
-- end

-- function update_start()
--   local t = _timers["start_timer"]
--   if t.active then
--     --log("start_timer " .. tostr(t.length))
--     t:update()
--   else
--     if btn(5) then
--       sfx(3)
--       t:restart()
--     end
--   end
-- end

function startgame(l)
  l = l or 1
 
  -- reset paddle and ball
  local p = _players["p1"]["paddle"]
  local b = _players["p1"]["ball"]

  p:init()
  b:serve()

  -- reset player data
  _players["p1"]["lives"] = 3
  _players["p1"]["score"] = 0
  _players["p1"]["level"] = l
  _players["p1"]["combo"] = 0
  init_bonus()

  _cur_lvl:init(l)
  -- log("Game state: start -> game - level: "..tostr(l))
  -- _state = "game"
  set_gamestate("game")
end