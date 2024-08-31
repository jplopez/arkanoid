paddle = class:new({
  x = 52,
  y = 112,
  w = 24,
  h = 8,
  dx = 2,

  init = function(self)
    local mid_screen = _screen_left + (_screen_right - _screen_left) / 2
    self.x = mid_screen - self.w / 2
    self.dx = 2
    self:state("idle")
  end,

  update = function(self)
    local dir = 0 -- no movement
    -- local tol = collision_engine.tolerance
    if(btn(0)) dir=-1 -- move left
    if(btn(1)) dir=1  -- move right

    self.x = mid(_screen_left + _tol, 
        self.x + (dir*self.dx),
        _screen_right - self.w - _tol)
    self:state("move")
    --self.w=40
    -- if(_aspects["paddle_large"].enabled) self.w=12
    -- if(_aspects["paddle_small"].enabled) self.w=4
  end,

  draw = function(self)
    sspr(40,40,8,8,self.x,self.y,8,self.h, false, false)
    sspr(48,40,8,8,self.x+8,self.y,self.w-16,self.h, false, false)
    sspr(40,40,8,8,self.x+self.w-8,self.y,8,self.h, true, false)
  end,

  on_collision = function(self) end

})