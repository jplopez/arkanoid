pup_handler = collision_handler:new({

  handle=function(self, paddle, pup_area)
    -- log("paddle-pup handle")
    for pup in all(_pups) do
      -- log("paddle-pup " .. pup.s .. " " .. tostr(pup:state()))
      if(pup:is_state("visible")) then
        local col = collision_engine:is_rect_colliding(paddle, pup)
        -- log("paddle-pup " .. pup.s .. " collision: ".. tostr(col))
        if(col) then
          sfx(3)
          pup:state("hidden")
          self:handle_powerup(pup)
          --modify paddle behavior
        end
      end
    end
  end,

  handle_powerup=function(self, pup)
    if(pup.s==_pup_1up) extra_live()
    if(pup.s==_pup_large) toggle_aspect_by_name("paddle_expand", true)
    if(pup.s==_pup_small) toggle_aspect_by_name("paddle_shrink", true)
    if(pup.s==_pup_score) self:pup_score(pup)
    if(pup.s==_pup_glue) toggle_aspect_by_name("paddle_glue", true)
    if(pup.s==_pup_3balls) toggle_aspect_by_name("extra_ball", true)
  end,

  pup_score = function(self, pup) 
    --_pscore+=_pup_score_val
    _score:add(_pup_score_val)
    pup:state("idle")
    pup.c=0
    pup.update=function(self) self.y-=1 end
    pup.draw=function(self)
      if(self:is_state("idle")) then
        self.c=(self.c+1)%12
        if(self.c==0) then 
          self:state("hidden")
        else 
          printt(tostr(_pup_score_val),
              self.x-5, self.y-5, 8+rnd(3));
        end
      end
    end
  end

})