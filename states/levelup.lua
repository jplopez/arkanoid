levelup_gamestate = gamestate:new({

  update=function(self)
    local timer = _timers["levelup_timer"]
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
    cls(1)
    printc("level " .. tostr(_plevel)
          .. " clear!", 25, 8)
    printc("lives : "
          .. _plives, 40, 8)
    printc("current score:"
          .. _pscore, 55, 10)
    printc("press ❎ to start next level", 70, 11)
  end
})

function levelup()
  local cur_lvl = _plevel
  log("Levelup - current level:" .. _plevel)
  -- reset paddle and ball
  _ppaddle:init()
  _pball:serve()
  --increase level and load
  _plevel+=1
  _lvl:init(_plevel)
  set_gamestate("game")
end