player=entity:extend({

  pad=paddle(),
  b=ball(),
  pwrbar=powerbar(),
  extra_balls=ball,
  pup=powerup,
  aspects=_aspects, --temporary
  score=score(),
  combo=0,
  lives=3,

  init=function(_ENV) 
    entity.init(_ENV)
    _st={intro,game,levelup,gameover}
    reset(_ENV)
  end,

  reset=function(_ENV) 
    ball:destroy_extra_balls()
    powerup:each("destroy")
    b:serve({dy=-1,dx=0.5})
    pad:serve()
    combo=0
    disable_aspects()
  end,

  update=function(_ENV)
    pad:update()
    extra_balls:each("update")
    pup:each("update")
    score:update()
    pwrbar:update()
  end,

  draw=function(_ENV) 
    pad:draw()
    extra_balls:each("draw")
    pup:each("draw")
    score:draw()
    pwrbar:draw()
  end,

  create_extra_ball=function(_ENV)
    if(#extra_balls.pool>_max_balls) return 
    local extra=extra_balls:create_extra_ball()
    return extra
  end,

  toggle_aspect=function(_ENV,aspect,enabled) 
    local a =aspects[aspect]
    if(a)a.enabled=enabled
    if(a.enabled)then
      if(a.disables)then
        for d in all(a.disables)do
          if(aspects[d].enabled)then
            aspects[d].exit()
            aspects[d].enabled=false
          end
        end
      end
      a.enter()
    else a.exit()end
  end,

  disable_aspects=function(_ENV)
    for k,v in pairs(aspects)do toggle_aspect(k,false)end
  end,

  apply_pup=function(_ENV, pup) end,

  score_hit=function(_ENV,obj)
    local new_combo=combo+b.hits    
    -- Update player's score
    score:add(obj.score_mul*new_combo)
    -- upd player's combo
    combo=new_combo
    -- upd ball power level
    b.pwr+=ceil(new_combo/_pwrbar_combo_factor)
    -- brick hit sound: combo sfx goes up to 7
    if(b.power==_pwr_off)sfx(10+mid(1,new_combo,7))
    if(b.power==_pwr_ball or b.power==_pwr_fury)sfx(09)
  end,

  ball_sfx=function(_ENV) 
    if(b.power==_pwr_off)sfx(10+mid(1,new_combo,7))
    if(b.power==_pwr_ball or b.power==_pwr_fury)sfx(09)
  end,

})