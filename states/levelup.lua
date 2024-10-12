levelup_gamestate={
  snd=true,
  update=function(self)
    log("update levelup snd "..tostr(self.snd))
    --levelup melody
    if(self.snd)music(5,6000,_music_channels)self.snd=false
    if(btn(5))delay(6,levelup)
  end,

  draw=function(self)
    cls(1)
    printoc("level "..tostr(_plevel).." clear!",25,_pal_h1,_pal_h1o)
    printc("current score:".._score:tostr(),35,_pal_h2)
    if(_score:is_high_score())printoc("new high score!",42,_pal_h2,_pal_h2o)
    printc("lives : ".._plives,50,_pal_h2)
    if(muted())printoc("press ❎ to start next level",80,_pal_h2,_pal_h2o)
  end
}

function levelup()
  log("levelup")
  local cur_lvl=_plevel
  -- reset paddle and ball
  _ppaddle:init()
  _pball.serve(global,{dy=-1,dx=0.5})
  _pups={}
  --increase level and load
  _plevel+=1
  for b in all(_pup_extra_balls)do b:serve({dy=-1,dx=0.5})end
  gamestate("game")
  levelup_gamestate.snd=true
  _lvl:init(_plevel)
end