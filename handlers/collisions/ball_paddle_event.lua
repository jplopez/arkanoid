-- ball hitting paddle
ball_paddle_event=event:new({
 
  dx_next="",
  dy_next="",
  
  eval=function(self)
   local ball= _players["p1"]["ball"]
   local paddle= _players["p1"]["paddle"]
 
   -- sticky ball
   if ball.state==ball.states.sticky then
    return false
   end
    
   self.dx_next=""
   self.dy_next=""
 
   local ball_x=ball.x
   local ball_y=ball.y
   local ball_x2=ball_x+(ball.r*2)
   local ball_y2=ball_y+(ball.r*2)
 
   local paddle_x=paddle.x
   local paddle_y=paddle.y
   local paddle_x2=paddle_x+paddle.w
   local paddle_y2=paddle_y+paddle.h
   
   local tol = 0.5
   if overlap(
         tol, 
         ball_x,
         ball_x2,
         ball_y,
         ball_y2,
         paddle_x,
         paddle_x2,
         paddle_y,
         paddle_y2) then
     
    --to deprecate
    _col_eng.ball_paddle=true
     
    --horizontal
    if near(tol,ball_y2,paddle_y) 
    then
     self.dy_next="up"
     self.x_pos=ball_x2-paddle_x
     self.y_pos=paddle_y-ball_y2
 
    elseif near(tol,ball_y,paddle_y2) 
    then
     self.dy_next="down"
     self.x_pos=ball_x2-paddle_x
     self.y_pos=ball_y-paddle_y2
    end
     
    --vertical
    if near(tol,ball_x,paddle_x2) 
    then
     self.dx_next="right"
     self.x_pos=ball_x-paddle_x
     self.y_pos=ball_y2-paddle_y
    elseif near(tol, ball_x2,paddle_x) 
    then
     self.dx_next="left"
     self.x_pos=paddle_x-ball_x2
     self.y_pos=(ball_y+ball.r)-paddle_y
    end

    if (self.dx_next != "" or self.dy_next != "") then
      paddle:on_collision()
    end
 
    _debug_p_pos=
      "("..paddle.x..","..paddle.y..") "..
      "("..paddle_x2..","..paddle_y2..")"
    _debug_b_pos=
      "("..ball.x..","..ball.y..") "..
      "("..ball_x2..","..ball_y2..")"
    _debug_e_pos=
      "("--..self.x_pos..","..self.y_pos..") "
    _debug_d_pos=
      "next:("..
      self.dx_next..","..
      self.dy_next..")"
 
    return true
   else --no overlap
    --to deprecate
    _col_eng.ball_paddle=false
    return false
   end
  end,
  
  update=function(self)
    local ball= 
      _players["p1"]["ball"]
    local paddle= 
      _players["p1"]["paddle"]
 
    --upd ball's dx and dy  
    ball.dx, ball.dy = 
      self:upd_dx_dy(ball,paddle)
 
    _players["p1"]["combo"]=1
  end,
  
  upd_dx_dy=function(self,ball,paddle)
   local new_dx = ball.dx
   local new_dy = ball.dy
 
   local paddle_x=paddle.x
     
   if self.dy_next=="up" then
    local seg=paddle.w/6
    new_dy=-(abs(new_dy))
    
    if self.x_pos<=seg then
     new_dx=-2
    elseif self.x_pos<=(seg*2) then
     new_dx=-1.5
    elseif self.x_pos<=(seg*3) then
     new_dx=-1
    elseif self.x_pos<=(seg*4) then
     new_dx=1
    elseif self.x_pos<=(seg*5) then
     new_dx=1.5
    else  -- self.x_pos<=(seg*6)
     new_dx=2
    end
    
   elseif self.dy_next=="down" then
    new_dx = -1*(abs(new_dx))
    new_dy= (abs(new_dy))
   -- side hit gives extra speed 
   elseif self.dx_next=="left" then
    new_dx=-2.5
    new_dy=-1*(abs(new_dy))
   elseif self.dx_next=="right" then
    new_dx=2.5
    new_dy=-1*(abs(new_dy))
   end 
 
   self.dx_next=""
   self.dy_next=""
   return new_dx, next_dy
  end,
   
  to_string=function(self)
    return "ball_paddle_event\n"
     --event:string(self)..
     .." n(x,y):("
     ..tostr(self.dx_next)..","
     ..tostr(self.dy_next)..")"
  end
 })
 
