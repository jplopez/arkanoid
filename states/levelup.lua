levelup_gst=gst_handler:extend({
  snd=true,
  hs=false,

  on=function(_ENV)snd=(true)hs=false end,
  off=function(_ENV) global._plevel+=1 end,

  update=function(_ENV)
    if(global._score:is_highest())hs=true
    --levelup melody
    if(snd)music(5,6000,_music_channels)snd=false
    if(btn(5))delay(6,function()gset(game)end)

  end,

  draw=function(_ENV)
    cls(1)
    printoc("level "..tostr(global._plevel).." clear!",25,_pal_h1,_pal_h1o)
    printc("lives : "..global._plives,35,_pal_h2)
    printc("current score:"..global._score:tostring(),45,_pal_h2)
    if(hs)printoc("new high score!",54,_pal_h2,_pal_h2o)
    if(muted())printoc("press ❎ to start next level",80,_pal_h2,_pal_h2o)
  end
})
