-- lvl_chance = 0.2
-- s_tier_chance = 0.05
-- a_tier_chance = 0.15
-- b_tier_chance = 0.8
--
-- Powerup Gatcha formula:
-- pup_chance = lvl_chance * tier_chance + (0.02 * player_combo)
_gatcha_probs={
 { 2, 4, 6, 8,10,12,14}, --s tier
 { 6, 8,10,11,13,15,16}, --a tier
 {18,20,22,24,26,28,30}  --b tier
}
_gatcha_items={
  {_pup_web, _pup_1up,}, -- s tier
  {_pup_3balls, _pup_large, _pup_small,}, -- a tier
  { _pup_score, _pup_glue,} --b tier
}

function pup_gatcha_pull()
  local combo=gatcha_combo()
  local chance=ceil(rnd(100))
  for i=1,3 do 
    if(chance<_gatcha_probs[i][combo])return rnd(_gatcha_items[i])
  end
  return nil
end

function gatcha_combo()
  local c=_pcombo
  if(_pball.power==_pwr_fury)c=1
  if(_pball.power==_pwr_ball)c=ceil(c*0.66)
  return mid(1,c,7)
end