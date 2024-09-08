collision_handler = class:new({
  handle = function(self, obj1, obj2) end
})

collision_engine = class:new({
  
  tolerance = 1,

  new = function(self, tolerance)
    local tbl = class:new(self)
    tbl.tolerance = tolerance
    return tbl
  end,

  update=_noop,

  is_circle_colliding = function(self, c1, c2)
    local dx = c1.x - c2.x
    local dy = c1.y - c2.y
    local distance = sqrt(dx * dx + dy * dy)

    return distance < c1.r + c2.r + self.tolerance
  end,

  is_circle_screen_colliding = function(self, c)
    local top_dist = ((c.y-c.r) - _screen_top) <= self.tolerance
    local bot_dist = (_screen_bot - (c.y+c.r)) <= self.tolerance
    local left_dist = ((c.x-c.r) - _screen_left) <= self.tolerance
    local right_dist = (_screen_right - (c.x+c.r)) <= self.tolerance

    local side = nil
    if(top_dist) side=_top
    if(bot_dist) side=_bottom
    if(left_dist) side=_left
    if(right_dist) side=_right
    return side!=nil, side
  end,

  is_circle_rect_colliding = function(self, c, rec)
    local col, side = self:is_circle_rect_collision_side(c, rec)
    return col
  end,

  is_circle_rect_collision_side = function(self, c, rec)
    local closest_x = mid(rec.x, c.x, rec.x + rec.w)
    local closest_y = mid(rec.y, c.y, rec.y + rec.h)

    local dx = c.x - closest_x
    local dy = c.y - closest_y
    local coll = dx * dx + dy * dy < (c.r + self.tolerance) * (c.r + self.tolerance)
    
    --determine side of collision in rect
    local side = nil
    if coll then
      local tol = c.r + self.tolerance
      --left
      if abs(rec.x - c.x) <= tol then
        side = _left
      --end
      --right
      elseif abs(c.x  - (rec.x+rec.w)) <= tol then
        side = _right
      end

      -- top and top corners
      if abs(rec.y - c.y) <= tol then
        if side == _left then
          side = _top_left
        elseif side == _right then
          side = _top_right
        else
          side = _top 
        end
      -- bottom and bottom corners
      elseif abs(c.y - (rec.y+rec.h)) <= tol then
        if side == _left then
          side = _bottom_left
        elseif side == _right then
          side = _bottom_right
        else
          side = _bottom
        end
      end
    end
    return coll, side
  end,

  is_rect_colliding = function(self, rect1, rect2)
    return rect1.x < rect2.x + rect2.w + self.tolerance
        and rect1.x + rect1.w > rect2.x - self.tolerance
        and rect1.y < rect2.y + rect2.h + self.tolerance
        and rect1.y + rect1.h > rect2.y - self.tolerance
  end
})