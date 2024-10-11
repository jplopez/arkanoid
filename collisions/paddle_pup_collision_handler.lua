pup_handler = collision_handler:new({

  handle=function(self, paddle, pup_area)
    -- log("paddle-pup handle")
    for pup in all(_pups) do
      -- log("paddle-pup " .. pup.s .. " " .. tostr(pup:state()))
      if(pup:is_state("visible")) then
        local col = collision_engine:is_rect_colliding(paddle, pup)
        -- log("paddle-pup " .. pup.s .. " collision: ".. tostr(col))
        if(col) then
          pup:state("hidden")
          self:handle_powerup(pup)
          --modify paddle behavior
        end
      end
    end
  end,

  handle_powerup=function(self, pup)
    if(pup.s==_pup_1up) self:pup_live(pup)
    if(pup.s==_pup_large) toggle_aspect_by_name("paddle_expand", true)
    if(pup.s==_pup_small) toggle_aspect_by_name("paddle_shrink", true)
    if(pup.s==_pup_score) self:pup_score(pup)
    if(pup.s==_pup_glue) toggle_aspect_by_name("paddle_glue", true)
    if(pup.s==_pup_3balls) toggle_aspect_by_name("extra_ball", true)
    if(pup.s==_pup_web) toggle_aspect_by_name("web", true)
  end,

  pup_score=function(self,pup) 
    _score:add(_pup_score_val)
    sfx(32)
    pup=self:pup_msg(pup,tostr(_pup_score_val))
  end,

  pup_live=function(self,pup) 
    extra_live()
    pup=self:pup_msg(pup,"1UP!")
  end,

  pup_msg=function(self,pup,msg)
    pup:state("idle")
    pup.c=0
    pup.update=function(this) this.y-=1 end
    pup.draw=function(this)
      if(this:is_state("idle")) then
        this.c=(this.c+1)%12
        if(this.c==0) then 
          this:state("hidden")
        else 
          print(msg,this.x-5, this.y-5, 8+rnd(3));
        end
      end
    end
    return pup
  end

})