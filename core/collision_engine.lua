collision_handler=class2:extend({
  handle=function(self,obj1,obj2)end})

collision_engine=class2:extend({
  tolerance=1,
  init=function(_ENV)tolerance=global._tol end,
 
  is_circle_colliding=function(_ENV,c1,c2)
    local dx=c1.x-c2.x
    local dy =c1.y-c2.y
    local dist=sqrt(dx*dx + dy*dy)
    return dist<c1.r+c2.r+tolerance
  end,

  -- Check if circle is withing the screen
  -- Returns boolean for collision and side of collision
  -- side values are defined in globals
  is_circle_screen_colliding = function(_ENV, c)
    local tol,side=tolerance+c.r,nil
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
    rec:rectangle

    Returns boolean for collision, and a number representing
    the side of the collision on the rectangle.
    side values are defined in globals
  ]]
  is_circle_rect_colliding = function(_ENV, c, rec)
    local closest_x=mid(rec.x,c.x,rec.x+rec.w)
    local closest_y=mid(rec.y,c.y,rec.y+rec.h)
    local tol=c.r+tolerance

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

  is_rect_colliding=function(_ENV,rect1,rect2)
    return rect1.x < rect2.x+rect2.w+tolerance
        and rect1.x+rect1.w > rect2.x-tolerance
        and rect1.y<rect2.y + rect2.h+tolerance
        and rect1.y+rect1.h > rect2.y-tolerance
  end
})