-- paddle
paddle=class:new({
    x=52,
    y=120,
    w=24,
    h=3,
    clr=12,
    
    dx=2,
    
    states = {
     idle="idle", 
     left="left",
     right="right"
    },
    
    state="idle",
    
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
      self.state = "idle"
    
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
      if self.state==self.states.left
        or self.state==self.states.right then
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
      self.paddle_clr(self))
    end,
    
    left=function(self)
     if (self.x > _screen_left) then
      self.x-=self.dx
      self.state=self.states.left
     end
    end,
    
    right=function(self)
        if (self.x < _screen_right-self.w) then
         self.x+=self.dx
         self.state=self.states.right
     end
    end,
    
    --not working
    brake=function(self)
     local dx = self.dx
     self.dx = self.dx/1.7
     if self.state == self.states.left then
      self:left()
     elseif self.state == self.states.right then
      self:right()
     else end
     self.dx=dx
     self.state=self.states.idle
    end,
   
    paddle_clr=function(self)
      local c = self.clr
      if _col_eng.ball_paddle then
       self.hit_count = self.hit_frames
       c = self.clr-4
      elseif self.hit_count>0 then
       self.hit_count-=1
       c = self.clr-4
      else
       c = self.clr
      end
      return c
    end
})
   