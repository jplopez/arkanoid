-- paddle
_paddle_states = {
  idle="idle", 
  left="left",
  right="right",
  hit="hit"
 }

paddle=class:new({
    x=52,
    y=120,
    w=24,
    h=3,
    clr=rnd(_pals["paddle"]),
    
    dx=2,
    
    states = {
     idle="idle", 
     left="left",
     right="right",
     hit="hit"
    },
    
    state=_paddle_states.idle,
    
    hit_clr=7,
    hit_frames=3,
    hit_count=0,
    
    new=function(self, tbl)
        tbl=tbl or {}
        setmetatable(tbl, {
          __index=self
        })
        return tbl
    end,
    
    init=function(self)
      local mid_screen = _screen_left + ((_screen_right - _screen_left) / 2)
      self.x = mid_screen - (self.w / 2)
      self.dx = 2
      self.state = _paddle_states.idle
    
    end,

    move=function(self)
     if btn(0) then 
      self.left(self) 
     elseif btn(1) then
      self.right(self) 
     elseif self.state != 
         self.states.idle then
      self.brake(self)
     end 
   
    end,
    
    sndfx=function(self)
      if self.state==_paddle_states.left
        or self.state==_paddle_states.right then
        --sfx(3)
      end    
    end,
    
    update=function(self)
     self:move()
     self:sndfx()
    end,
    
    draw=function(self)
     rectfill(
      self.x,
      self.y,
      self.x+self.w,
      self.y+self.h,
      self:paddle_clr())
    end,
    
    left=function(self)
     if (self.x > _screen_left) then
      self.x-=self.dx
      self.state=_paddle_states.left
     end
    end,
    
    right=function(self)
        if (self.x < _screen_right-self.w) then
         self.x+=self.dx
         self.state=_paddle_states.right
     end
    end,
    
    --not working
    brake=function(self)
     local dx = self.dx
     self.dx = self.dx/1.7
     if self.state == _paddle_states.left then
      self:left()
     elseif self.state == _paddle_states.right then
      self:right()
     else end
     self.dx=dx
     self.state=_paddle_states.idle
    end,
   
    on_collision = function(self)
      self.hit_count = self.hit_frames
    end,

    paddle_clr=function(self)
      if self.hit_count > 0 then
       self.hit_count-=1
       return self.hit_clr
      else
       return self.clr
      end
    end
})
   