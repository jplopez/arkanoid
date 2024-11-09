-- Loads cart data and menuitems
function init_sys()
  cartdata(_cdata_id)
  --dset(_high_score_index,0)
  _high_score = dget(_highest_score_index)
  if(_debug) then
    menuitem(1,"aspects",function()
      _is_dialog_open=true end)
    menuitem(2,"levelup",function()
      gset(levelup) end)
    menuitem(3,"gameover",function()
      gset(gameover) end)
  end

  --if(dget(_hs_index_flag)==0) init_hs()
end

-- function init_hs()
--   local a=97
--   local names = { 
--     {106,112,108},
--     {109,97,101},
--     {108,101,111},
--   }
--   for i=1,3 do
--     if(i==1)then dset(_hs_index*i,_high_score)
--     else dset(_hs_index*i,0.020) end
--     dset(_hs_index*i+1,names[i][1])
--     dset(_hs_index*i+2,names[i][2])
--     dset(_hs_index*i+3,names[i][3])
--   end
--   dset(_hs_index_flag,1)
-- end

-- Player entities and attributes
function init_players()
  _pball=ball()
  _ppaddle=paddle()
  _ppwrbar=powerbar()
  _pweb=web()
  _score=score()
  _plevel=1
  _plives=3
  _pserves=99
end

function init_world()
  _lvl=level()-- current level
  _gamestates._st={
    [intro]=intro_gst,
    [game]=game_gst,
    [gameover]=gameover_gst,
    [levelup]=levelup_gst,
  }
  init_collisions()
end

function init_collisions()
  _colle = collision_engine()
  hit_blocks={
    brick={x=_screen_left,y=_screen_top,w=_screen_left+(brick.w*_max_cols),h=_screen_top+(brick.h*_max_rows)},
    pups={x=_screen_left,y=paddle.y,w=_screen_right,h=paddle.h},
    web={x=_pweb.x1, y=_pweb.y1-1, w=_pweb.x2-_pweb.x1, h=_pweb.y2+1}
  }
end