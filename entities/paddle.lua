paddle=object:new():extends(
  { x=52, y=112, w=24, h=8, dx=2,
    states={"idle","move","hit"} })

paddle.new=function(self,tbl)
  tbl=tbl or {}
  tbl=class.new(paddle,tbl)
  return tbl
end

paddle.init=function(self)
  local mid_screen=_screen_left+(_screen_right-_screen_left)/2
  self.x=mid_screen-self.w/2
  self.dx=2
  self:state("idle")
end

paddle.update=function(self)
  local dir=0 -- no movement
  if(btn(0))dir=-1 -- move left
  if(btn(1))dir=1  -- move right
  self.x=mid(_screen_left+_tol,self.x+(dir*self.dx),
      _screen_right-self.w-_tol)
  self:state("move")
end

paddle.draw=function(self)
  sspr(40,40,8,8,self.x,self.y,8,self.h, false, false)
  sspr(48,40,8,8,self.x+8,self.y,self.w-16,self.h, false, false)
  sspr(40,40,8,8,self.x+self.w-8,self.y,8,self.h, true, false)
end

paddle.on_collision=function(self) end
