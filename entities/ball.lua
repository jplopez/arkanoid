-- ball 
ball=class:new({
  
    x=_screen_left, --rnd(122),
    y=_screen_bot-20, --rnd(122),
    dx=0.5, --+rnd(6),
    dy=-1, --+rnd(6),
    r=2,
    clr=8,
   
    states = {
     idle="idle", 
     move="move",
     invert_x="invert_x",
     invert_y="invert_y",
     sticky="sticky"
    },
    state = "idle",  
    
    move=function(self) 
    
     if(self.state==self.states.sticky) do self:sticky_move()
     else
      self.state=self.states.move
       
      if outside(self.x, _screen_left, _screen_right) then
       self.dx*=-1
       self.state=self.states.invert_x
      end
    
      --if _col_eng.ball_paddle or 
      if self.y < _screen_top then
       self.dy*=-1
       self.state=self.states.invert_y
      end
   
      self.x+=self.dx
      self.y+=self.dy
     end --else
    end,   
     
    sticky_move=function(self)
     local p = _players["p1"]["paddle"]
     self.x=p.x+(p.w/2)
     self.y=p.y-(self.r*2)
    end,
    
    action=function(self)
     if self.state==self.states.sticky then
      if btn(5) then
       self.state=self.states.idle
      end
     end 
    end,
    
    sndfx=function(self)
     if(_col_eng.ball_paddle) then 
      sfx(1) end
   
     if (self.state==self.states.invert_y 
       or self.state==self.states.invert_x) then
         sfx(0) end
    end,
   
    update=function(self)
     self:move()
     self:action()
     self:sndfx()
    end,
     
    draw=function(self)
     circfill(
       self.x, 
       self.y, 
       self.r, 
       self.clr)
    end,
    
    serve=function(self)
     --resets paddle and ball
     local p = 
      _players["p1"]["paddle"]
    
        self.x=p.x+(p.w/2)
        self.y=p.y-(self.r*2)
        self.dx=0.5
        self.dy=-1
        self.state=self.states.sticky
    end
})
   