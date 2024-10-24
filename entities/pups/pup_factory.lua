function aspect_pup(tbl,_s,aspect,toggle) 
  local pup=powerup(tbl)
  pup.s=_s
  pup.aspect=aspect
  if(toggle) then
    pup.apply=function(_ENV)aspect:toggle()end
  else 
    pup.apply=function(_ENV)aspect:on()end
  end
  return pup
end

function pup_1up(tbl)
  local pup=powerup(tbl)
    pup.s=_pup_1up
    pup.msg="1UP!"
    pup.apply=function(_ENV) _plives+=1 end
  return pup
end

function pup_score(tbl)
  local pup=powerup(tbl)
  pup.s=_pup_score
  pup.msg=_pup_score_val
  pup.apply=function(_ENV) 
    _score:add(_pup_score_val)
    sfx(32)
  end
  return pup
end

pup_factory={
  [_pup_1up] = pup_1up,
  [_pup_large] = function(tbl)return aspect_pup(tbl,_pup_large,paddle_expand) end,
  [_pup_small] = function(tbl)return aspect_pup(tbl,_pup_small,paddle_shrink) end,
  [_pup_3balls] = function(tbl)return aspect_pup(tbl,_pup_3balls,extra_ball) end,
  [_pup_score] = pup_score,
  [_pup_web] = function(tbl)return aspect_pup(tbl,_pup_web,paddle_web) end,
  [_pup_glue] = function(tbl)return aspect_pup(tbl,_pup_glue,paddle_glue) end,
}