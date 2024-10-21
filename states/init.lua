-- Loads cart data and menuitems
function init_sys()
  cartdata(_cdata_id)
  --dset(_high_score_index,0)
  _high_score = dget(_high_score_index)
  if(_debug) then
    menuitem(1,"badges",function()
      _is_dialog_open=true end)
    menuitem(2,"levelup",function()
      gset(levelup) end)
    menuitem(3,"gameover",function()
      gset(gameover) end)
  end
end

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
    [levelup]=levelup_gst
  }
  init_collisions()
  init_aspects()    -- aspects are used for powerups
end

function init_collisions()
  _colle = collision_engine()
  hit_blocks={
    brick={x=_screen_left,y=_screen_top,w=_screen_left+(brick.w*_max_cols),h=_screen_top+(brick.h*_max_rows)},
    pups={x=_screen_left,y=paddle.y,w=_screen_right,h=paddle.h},
    web={x=_pweb.x1, y=_pweb.y1-1, w=_pweb.x2-_pweb.x1, h=_pweb.y2+1}
  }
end

function init_aspects()
  _aspects[paddle_web].enter=function()_pweb:set(idle)end
  _aspects[paddle_web].exit=function()_pweb:set(hidden)end

  _aspects[paddle_expand].enter=function()sfx(34)_ppaddle.w=mid(24,_ppaddle.w+4,32)end
  _aspects[paddle_expand].exit=function()_ppaddle.w=paddle.w end

  _aspects[paddle_shrink].enter=function()sfx(35)
    _ppaddle.w=mid(16,_ppaddle.w-4,24)
    _pwrbar_increment=mid(1,_pwrbar_increment+1,3)
    _pwrbar_combo_factor=mid(1,_pwrbar_combo_factor-1,3)
  end
  _aspects[paddle_shrink].exit=function() 
    _ppaddle.w=paddle.w
    _pwrbar_increment=1
    _pwrbar_combo_factor=3
  end

  _aspects[extra_ball].enter=function() 
    if(#ball.pool>_max_balls)return false
    local b = ball(_ENV,{main=false})
    b:serve()
  end
  --won't destroy _pball
  _aspects[extra_ball].exit=function()ball:each("destroy")end

  _aspects[paddle_glue].enter=function()sfx(33)end 
end