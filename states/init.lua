-- init
function init_gamestates()
  _gamestates._st={
      [intro]=intro_gst,
      [game]=game_gst,
      [gameover]=gameover_gst,
      [levelup]=levelup_gst
  }
end

function init_players()
  _pball=ball()
  _ppaddle=paddle()
  _ppwrbar=powerbar:new()
  _ppwrbar.bars=0
  _plevel=1
  _plives=3
  _pserves=99
  _pweb=web()
  _score=score
  _score:reset()
end

function init_world()
  _lvl=level()-- current level
  init_collisions() --collision engine
  --init_bonus()      --bonus - extra 1up
  init_aspects()    -- aspects are used for powerups
  init_gamestates()
end

function init_collisions()
    _colle = collision_engine:new(_tol)

    -- brick area of collisions
    br_area = {x=_screen_left,y=_screen_top,w=_screen_left+(brick.w*_max_cols),h=_screen_top+(brick.h*_max_rows)}
    -- powerup area colliding w/paddle 
    pup_area={x=_screen_left,y=paddle.y,w=_screen_right,h=paddle.h}
    -- web pup area
    web_area={x=_pweb.x1,
        y=_pweb.y1-1,
        w=_pweb.x2-_pweb.x1,
        h=_pweb.y2+1}
 
    -- balls in play, starts w/_pball
    _colle.balls={_pball}
    _colle.update=function(self)
        for b in all(self.balls) do 
            --ball-paddle collision
            if(b:is(moving))then
              local col, side = self:is_circle_rect_colliding(b, _ppaddle)
              if(col) pb_handler:handle(b, _ppaddle, side)
              --ball-screen edges collision
              col, side = self:is_circle_screen_colliding(b)
              if(col) bscr_handler:handle(b, side)
              --ball-brick collision
              col, side = self:is_circle_rect_colliding(b, br_area)
              if(col) br_handler:handle(b, br_area, side)
              --web aspect collision
              if(_aspects["web"].enabled and 
                self:is_circle_rect_colliding(b,web_area)) then 
                  web_handler:handle(b,_pweb) end
            end
        end
        --powerups-paddle collision
        if(self:is_rect_colliding(_ppaddle, pup_area)) pup_handler:handle(_ppaddle, pup_area)
    end
    _colle.draw=_noop
end

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