levelup_gamestate={

  snd=true,

  update=function(self)
    if(self.snd) then 
      music(5, 6000, _music_channels)
      self.snd=false
    end

    local timer=_timers["levelup_timer"]
    if timer.active then
      timer:update()
    else
      if(btn(5))timer:restart()
    end
  end,

  draw=function(self)
    cls(1)
    printoc("level " .. tostr(_plevel) .. " clear!", 25, _pal_h1, _pal_h1o)
    printc("current score:".. _score:tostr(), 35, _pal_h2)
    if(_score:is_high_score()) printoc("new high score!", 42, _pal_h2, _pal_h2o)
    printc("lives : " .. _plives, 50, _pal_h2)
    if(stat(48)==-1) printoc("press ❎ to start next level", 80, _pal_h2, _pal_h2o)
  end
}

function levelup()
  local cur_lvl = _plevel
  -- reset paddle and ball
  _ppaddle:init()
  _pball:serve()
  --increase level and load
  _plevel+=1
  _lvl:init(_plevel)
  for b in all(_pup_extra_balls) do b:serve() end
  gamestate("game")
  levelup_gamestate.snd=true
end