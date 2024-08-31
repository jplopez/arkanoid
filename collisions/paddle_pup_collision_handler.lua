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
          self:handle_powerup_aspect(pup)
          --modify paddle behavior
        end
      end
    end
  end,

  handle_powerup_aspect=function(self, pup)
    -- if(pup.s==_pup_1up) _plives+=1
    -- if(pup.s==_pup_large) _aspects["paddle_large"].enabled=true
    -- if(pup.s==_pup_small) _aspects["paddle_small"].enabled=true

    -- if(pup.s==_pup_score) _pscore+=500

  end

})