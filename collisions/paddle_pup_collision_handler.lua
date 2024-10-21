pup_handler = collision_handler:extend({

  handle=function(_ENV,paddle,pup)
    pup:set(picked)
    pup:apply()
  end,
})