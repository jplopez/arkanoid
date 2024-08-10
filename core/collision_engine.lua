collision_handler = class:new({
  handle = function(self, obj1, obj2) end
})

collision_engine = class:new({
  
  tolerance = 2,
  collisions = {},

  new = function(self, tolerance)
    local tbl = class:new(self)
    tbl.tolerance = tolerance
    tbl.collisions = {
      rect_rect = {},
      circle_rect = {},
      circle_circle = {},
      circle_screen = {}
    }
    return tbl
  end,

  update = function(self) 
    self:update_collisions(self.collisions["rect_rect"], 
    collision_engine.is_rect_colliding)

    self:update_collisions(self.collisions["circle_rect"], 
    collision_engine.is_circle_rect_colliding)

    self:update_collisions(self.collisions["circle_circle"], 
    collision_engine.is_circle_colliding)

    self:update_collisions(self.collisions["circle_screen"], 
    collision_engine.is_circle_screen_colliding)

  end,

  update_collisions=function(self, collisions, collision_fn) 
    for k,v in pairs(collisions) do
      if v["obj2"] == nil then
        local col, side = collision_fn(self, v["obj1"])
        if col then
          v["handler"]:handle(v["obj1"], side)
        end
      else
        local col,side = collision_fn(self, v["obj1"], v["obj2"])
        if col then
          v["handler"]:handle(v["obj1"], v["obj2"], side)
        end
      end   
    end
  end,

  add_rect_rect = function(self, key, rect1, rect2, handler)
    self:add_collision(key, "rect_rect", rect1, rect2, handler)
  end,

  add_circle_rect = function(self, key, circle, rect, handler)
    self:add_collision(key, "circle_rect", circle, rect, handler)
  end,

  add_circle_circle = function(self, key, circle1, circle2, handler)
    self:add_collision(key, "circle_circle", circle1, circle2, handler)
  end,

  add_circle_screen = function(self, key, circle, handler)
    log("collision engine add circle_screen")
    self:add_collision(key, "circle_screen", circle, nil, handler)
  end,

  --TODO : validate key already exist
  add_collision = function(self, handler_key, collision_key, obj1, obj2, handler )
    if (obj1 == nil and obj2 == nil) then return false end
    if is_empty(handler_key) or is_empty(collision_key) then return false end
    self.collisions[collision_key] = self.collisions[collision_key] or {}
    self.collisions[collision_key][handler_key] = { 
      obj1 = obj1, 
      obj2 = obj2, 
      handler = handler }
  end,


  is_circle_colliding = function(self, circle1, circle2)
    
    local dx = circle1.x - circle2.x
    local dy = circle1.y - circle2.y
    local distance = sqrt(dx * dx + dy * dy)

    return distance < circle1.r + circle2.r + self.tolerance
  end,

  is_circle_screen_colliding = function(self, circle)
    local top_dist = ((circle.y-circle.r) - _screen_top) <= self.tolerance
    local bot_dist = (_screen_bot - (circle.y+circle.r)) <= self.tolerance
    local left_dist = ((circle.x-circle.r) - _screen_left) <= self.tolerance
    local right_dist = (_screen_right - (circle.x+circle.r)) <= self.tolerance

    local side = nil
    if(top_dist) side="top"
    if(bot_dist) side="bottom"
    if(left_dist) side="left"
    if(right_dist) side="right"
    return side!=nil, side
  end,

  is_circle_rect_colliding = function(self, circle, rec)
    local closest_x = mid(rec.x, circle.x, rec.x + rec.w)
    local closest_y = mid(rec.y, circle.y, rec.y + rec.h)

    local dx = circle.x - closest_x
    local dy = circle.y - closest_y

    return dx * dx + dy * dy < (circle.r + self.tolerance) * (circle.r + self.tolerance)
  end,

  is_circle_rect_collision_side = function(self, circle, rec)
    local collision = self:is_circle_rect_colliding(circle, rec)
    local side = {
      left = false,
      right = false,
      top = false,
      bottom = false
    }
    if collision then
      -- determine the side of collision
      side["left"] = (abs((circle.x + circle.r) - rec.x)) <= self.tolerance
      side["right"] = (abs((circle.x - circle.r) - (rec.x + rec.w))) <= self.tolerance
      side["top"] = (abs((circle.y + circle.r) - rec.y)) <= self.tolerance
      side["bottom"] = (abs((circle.y - circle.r )- (rec.y + rec.h))) <= self.tolerance
    end
    return collision, side
  end,

  is_rect_colliding = function(self, rect1, rect2)
    return rect1.x < rect2.x + rect2.w + self.tolerance
        and rect1.x + rect1.w > rect2.x - self.tolerance
        and rect1.y < rect2.y + rect2.h + self.tolerance
        and rect1.y + rect1.h > rect2.y - self.tolerance
  end
})