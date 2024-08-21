-- ball

ball = class:new({
  x = _screen_left, 
  y = _screen_bot - 20,
  dx = 0.5, 
  dy = -1, 
  r = 1,
  clr = 8,

  pwr=0,

  -- sprite flip and count
  fl_x = {false, true, true, false },
  fl_y = {false, false, true, true },
  fl_c = 60,
  fl_i = 1,

  update = function(self)

    -- if self.state == _ball_states.sticky then
      if self:is_state("sticky") then
      if btn(5) then
        self:state("move") -- = _ball_states.move
      else 
        self:serve()
      end
    end

    -- if self.state == _ball_states.move then
    if self:is_state("move") then
      self.x += self.dx
      self.y += self.dy
    end
  end,

  draw = function(self)
    --aliases to save tokens
    local i, c, fx, fy = self.fl_i, self.fl_c, self.fl_x, self.fl_y

    if(self:is_state("move")) then
      if(c % flr(10/abs(self.dy)) == 0) i = (i == 4) and 1 or (i+1)
      c= (c == 1) and 60 or (c-1)
      sspr(0,8,5,5,self.x, self.y, 5,5,fx[i],fy[i])
    else
      sspr(0,8,5,5,self.x, self.y, 5,5)
    end
    self.fl_i, self.fl_c= i, c
  end,
 
  serve = function(self)
    --resets paddle and ball
    local p = _players["p1"]["paddle"]
    self.pwr=0
    self.x = p.x + p.w / 2
    self.y = p.y - 5 --(self.r*3)
    self.dx = 0.5
    self.dy = -1
    --self.state = _ball_states.sticky
    self:state("sticky")
  end
})

