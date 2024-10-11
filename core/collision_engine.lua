collision_handler=class:new({handle=function(self,obj1,obj2)end})

collision_engine=class:new({
  tolerance=1,

  new = function(self, tolerance)
    local tbl=class:new(self)
    tbl.tolerance=tolerance
    return tbl
  end,

  update=_noop,

  is_circle_colliding=function(self,c1,c2)
    local dx=c1.x-c2.x
    local dy =c1.y-c2.y
    local distance=sqrt(dx*dx + dy*dy)
    return distance<c1.r+c2.r+self.tolerance
  end,

  -- Check if circle is withing the screen
  -- Returns boolean for collision and side of collision
  -- side values are defined in globals
  is_circle_screen_colliding = function(self, c)
    local tol,side=self.tolerance+c.r,nil
    if(c.y-_screen_top<=tol) side=_top
    if(_screen_bot-c.y<=tol) side=_bottom
    if(side==nil) then
      if(c.x-_screen_left<=tol) side=_left
      if(_screen_right-c.x<=tol) side=_right
    end
    return side!=nil, side
  end,

  --[[
    Checks if a circle and a rectangle are colliding.
    c: circle
    rec:rectanble

    Returns boolean for collision, and a number representing
    the side of the collision on the rectangle.
    side values are defined in globals
  ]]
  is_circle_rect_colliding = function(self, c, rec)
    local closest_x=mid(rec.x,c.x,rec.x+rec.w)
    local closest_y=mid(rec.y,c.y,rec.y+rec.h)
    local tol=c.r+self.tolerance

    local dx=c.x-closest_x
    local dy=c.y-closest_y
    local coll=dx*dx + dy*dy < tol*tol
    local side=nil --,vside,hside=nil,nil,nil
    --determine side of collision in rect
    if coll then
      if(dx<0)side=_left
      if(dx>0)side=_right
      if(dx==0 or abs(dy)<abs(dx))then
        if(dy<0)side=_top
        if(dy>0)side=_bottom
      else  --corner
        if(dy<0)side=_top+side
        if(dy>0)side=_bottom+side
      end
    end
    return coll,side
  end,

  is_rect_colliding=function(self,rect1,rect2)
    return rect1.x < rect2.x+rect2.w+self.tolerance
        and rect1.x+rect1.w > rect2.x-self.tolerance
        and rect1.y<rect2.y + rect2.h+self.tolerance
        and rect1.y+rect1.h > rect2.y-self.tolerance
  end
})