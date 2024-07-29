--powerup events

powerup_event = event:new({

  pups = {},

  eval = function(self)
    return #self.pups > 0
  end,

  update = function(self)
    log("powerup event update pups "..#self.pups)

    for pup in all(self.pups) do
      pup:update()
    end

    --TODO powerup collision with paddle
  end,

  draw = function(self)
    log("powerup event draw pups "..#self.pups)
    for pup in all(self.pups) do
      pup:draw()
    end
  end,

  notify = function(self, brick)
    log("powerup event notify pups "..#self.pups)
    if brick != nil then

      local pull = pup_gatcha_pull()
      if pull != nil then
        pull.x = ((brick.x + brick.w) / 2) - 4
        pull.y = brick.y
        pull.state = _pup_states.visible
        add(self.pups, pull)
        log("powerup "..pull.clr.." added at ("..pull.x..","..pull.y..")")
      end
    end

  end
})