levelup_gst=gst_handler:extend({
  snd=true,
  on=function(_ENV)snd=true end,
  off=function(_ENV) global._plevel+=1 end,

  update=function(_ENV)
    --levelup melody
    if(snd)music(5,6000,_music_channels)snd=false
    if(btn(5))delay(6,function()gset(game)end)
  end,

  draw=function(_ENV)
    cls(1)
    printoc("level "..tostr(global._plevel).." clear!",25,_pal_h1,_pal_h1o)
    printc("current score:"..global._score:tostring(),35,_pal_h2)
    if(global._score:is_high_score())printoc("new high score!",42,_pal_h2,_pal_h2o)
    printc("lives : "..global._plives,50,_pal_h2)
    if(muted())printoc("press ❎ to start next level",80,_pal_h2,_pal_h2o)
  end
})

-- function levelup()
--   log("levelup")
--   local cur_lvl=_plevel
--   -- reset paddle and ball
--   _ppaddle:init()
--   _pball:serve({dy=-1,dx=0.5})
--   _pups={}
--   --increase level and load
--   _plevel+=1
--   for b in all(_pup_extra_balls)do b:serve({dy=-1,dx=0.5})end
--   gset(game)
--   _lvl=level({lvl=_plevel})
-- end