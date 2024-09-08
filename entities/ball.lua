ball = class:new({
  x = _screen_left, 
  y = _screen_bot - 20,
  dx = 0.5, 
  dy = -1, 
  r = 1.75,
  --clr = 8,
  pwr=0,

  -- sprite flip and count
  fl_x = {false, true, true, false },
  fl_y = {false, false, true, true },
  fl_c = 0,

  update = function(self)
    if self:is_state("sticky") then
      if btn(5) then
        self:state("move")
      else 
        self:serve()
      end
    end
    if self:is_state("move") then
      self.x += self.dx
      self.y += self.dy
    end
  end,

  draw = function(self)
    if(self:is_state("hidden")) return false
    --aliases to save tokens
    local c, fx, fy, dx, dy = self.fl_c, self.fl_x, self.fl_y, self.x-self.r, self.y-self.r

    local sx, sy = self:ball_spr()
    if(self:is_state("move")) then
      -- determine index of flip
      c = (c+1)%10
      sspr(sx,sy,5,5,dx, dy, 5,5,fx[c+1],fy[c+1])
    else
      sspr(sx,sy,5,5,dx, dy, 5,5)
    end
    self.fl_c= c
  end,
 
  ball_spr=function(self)
    if(self.pwr < _pwr_ball) return 0, 8
    if(self.pwr >= _pwr_ball and self.pwr < _pwr_fury) return 8,8
    if(self.pwr >= _pwr_fury) return 16,8
  end,

  power=function(self)
    if(self.pwr < _pwr_ball) return _pwr_off
    if(self.pwr >= _pwr_ball and self.pwr < _pwr_fury) return _pwr_ball
    if(self.pwr >= _pwr_fury) return _pwr_fury
  end,

  hits=function(self)
    if(self:power() == _pwr_off) return _pwr_off_hit
    if(self:power() == _pwr_ball) return _pwr_ball_hit
    if(self:power() == _pwr_fury) return _pwr_fury_hit
    return 1 -- to cover edge case
  end,

  serve = function(self)
    --resets paddle and ball
    self.pwr = 0
    self.x = _ppaddle.x + _ppaddle.w / 2
    self.y = _ppaddle.y - (self.r)
    self.dx = 0.5
    self.dy = -1
    self:state("sticky")
  end
})

