pup_handler = collision_handler:extend({

  handle=function(_ENV,paddle,pup)
    if(pup:is(visible))then
      pup:set(picked)
      pup:apply()
    end
  end,
})