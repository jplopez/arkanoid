powerbar = class:new({

  x = _screen_right - 38,
  y = _screen_top - 5,
  bars=0,
  max=8,
  pwr = "empty",
  pre_pwr=_pwr_off,

  update=function(self)
    local b=_players["p1"]["ball"]
    self.bars = mid(0, 
          ceil((b.pwr/_pwr_max) * self.max), 
          self.max)
    self.pre_pwr = self.pwr
    self.pwr = b:power()

    if(self.pre_pwr != self.pwr) then
      self:update_ball(b)
    end
  end,

  draw=function(self)

    for i=1,self.max do
      if(self.bars < i) then
        self:draw_bar_item(i, _pwr_spr["empty"])
      else
        self:draw_bar_item(i, _pwr_spr[self.pwr])
      end
    end
    pal()
  end,

  draw_bar_item=function(self, i, s)
    local sx, sy, sw, sh, fl_x =
          s["sxb"], s["syb"], 5, 6, (self.max==i)
    local dx = self.x+ sw + ((i-1)*4)
    
    palt(s["paltb"])
    if(i>1 and i<self.max) then
      sx, sy, sw = s["sx"], s["sy"], 4 
      palt(s["palt"])
    end
    sspr(sx, sy, sw, sh, dx, self.y, sw, sh, fl_x, false)
  end, 

  update_ball=function(self, b) 
    if(b:power() == _pwr_off) then
      -- regular ball
    elseif(b:power() == _pwr_ball) then
      -- speed up and hits*2
    elseif(b:power() == _pwr_fury) then
      -- shake when hitting walls
      -- go through bricks
      -- stops when hits the paddle
      -- power bar empty
    end
  end
})