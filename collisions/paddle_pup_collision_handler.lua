pup_handler = collision_handler:new({

  handle=function(_ENV, paddle, pup)
    -- log("paddle-pup handle")
    -- for pup in all(_pups) do
    --   -- log("paddle-pup " .. pup.s .. " " .. tostr(pup:state()))
    --   if(pup:is(visible)) then
    --     local col = collision_engine:is_rect_colliding(paddle, pup)
    --     -- log("paddle-pup " .. pup.s .. " collision: ".. tostr(col))
    --     if(col) then
          pup:set(hidden)
          handle_powerup(_ENV,pup)
          --modify paddle behavior
    --     end
    --   end
    -- end
  end,

  handle_powerup=function(_ENV, pup)
    if(pup.s==_pup_1up) pup_live(_ENV,pup)
    if(pup.s==_pup_large) toggle_aspect_by_name("paddle_expand", true)
    if(pup.s==_pup_small) toggle_aspect_by_name("paddle_shrink", true)
    if(pup.s==_pup_score) pup_score(_ENV,pup)
    if(pup.s==_pup_glue) toggle_aspect_by_name("paddle_glue", true)
    if(pup.s==_pup_3balls) toggle_aspect_by_name("extra_ball", true)
    if(pup.s==_pup_web) toggle_aspect_by_name("web", true)
  end,

  pup_score=function(_ENV,pup) 
    _score:add(_pup_score_val)
    sfx(32)
    pup=self:pup_msg(pup,tostr(_pup_score_val))
  end,

  pup_live=function(_ENV,pup) 
    global._plives+=1
    pup=pup_msg(_ENV,pup,"1UP!")
  end,

  pup_msg=function(_ENV,pup,msg)
    pup:set(idle)
    pup.c=0
    pup.update=function(_ENV)y-=1 end
    pup.draw=function(_ENV)
      if(is(_ENV,idle))then
        c=(c+1)%12
        if(c==0)then set(_ENV,hidden)
        else print(msg,x-5,y-5,8+rnd(3))end
      end
    end
    return pup
  end

})