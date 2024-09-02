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
    printoc("level " .. tostr(_plevel) .. " clear!", 25, _pal_h1, _pal_h1o)
    printc("current score:".. _pscore, 35, _pal_h2)
    if(_pscore >= _high_score) printsc("New high score!", 42, _pal_h2)
    printc("lives : " .. _plives, 50, _pal_h2)
    printoc("press ❎ to start next level", 80, _pal_h2, _pal_h2o)
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