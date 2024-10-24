aspect=object:extend({
  aspectid=0,
  name="",
  enabled=false,
  overwrites={}, --aspects to disable prior to enable this one

  init=function(_ENV)
    add(entity.pool,_ENV) 
    --aspects are added to the 
    --aspect.pool with their aspectid 
    --as the table key
    if(pool!=entity.pool) then
      if(aspectid==0)aspectid=#pool+1
      pool[aspectid]=_ENV 
    end
  end,

  toggle=function(_ENV)
    if(enabled) then return off(_ENV)
    else return on(_ENV) end
  end,

  rawenter=function(_ENV) 
    for ov in all(overwrites)do 
      if(pool[ov] and pool[ov].enabled)pool[ov]:off()
    end
    enter(_ENV)
  end,
  
  on=function(_ENV) rawenter(_ENV)enabled=true end,
  off=function(_ENV) exit(_ENV)enabled=false end,

  enter=_noop,
  exit=_noop,

  is_enabled=function(_ENV,_aspectid) 
    if(_aspectid) return pool[_aspectid].enabled
    return enabled
  end,

  __eq=function(this,other)
    if(this==other)return true 
    if(other.aspectid)return this.aspectid==other.aspectid
    return false
  end,
})


paddle_expand=aspect({
  aspectid=_paddle_expand,
  name="expand",
  overwrites={_paddle_shrink,_paddle_glue},
  enter=function(_ENV)sfx(34)global._ppaddle.w=mid(24,global._ppaddle.w+4,32)end,
  exit=function(_ENV)global._ppaddle.w=paddle.w end
})

paddle_shrink=aspect({
  aspectid=_paddle_shrink,
  name="shrink",
  overwrites={_paddle_expand,_paddle_glue},
  enter=function(_ENV)sfx(35)
    global._ppaddle.w=mid(16,global._ppaddle.w-4,24)
    global._pwrbar_increment=mid(1,global._pwrbar_increment+1,3)
    global._pwrbar_combo_factor=mid(1,global._pwrbar_combo_factor-1,3)
  end,
  exit=function(_ENV) 
    global._ppaddle.w=paddle.w
    global._pwrbar_increment=1
    global._pwrbar_combo_factor=3
  end
})

paddle_glue=aspect({
  aspectid=paddle_glue,
  name="glue",
  overwrites={_paddle_shrink,_paddle_expand},
  enter=function(_ENV)sfx(33)end,
})

extra_ball=aspect({
  aspectid=_extra_ball,
  name="extra ball",
  overwrites={_paddle_glue},
  enter=function(_ENV) 
    if(#ball.pool>_max_balls)return false
    local b=ball:create_extra_ball()
    b:serve()
  end,
  --won't destroy _pball
  exit=function(_ENV)ball:destroy_extra_balls()end
})

paddle_web=aspect({
  aspectid=_paddle_web,
  name="web",
  overwrites={_paddle_glue},
  enter=function(_ENV)
    log("paddle_web_enter")log(global._pweb)
    global._pweb:set(visible)
  end,
  exit=function(_ENV)global._pweb:set(hidden)end
})