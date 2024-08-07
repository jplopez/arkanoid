-- collision engine
col_eng = class:new({
  -- default tolerance
  tol = 2,

  --collition events type
  event_types = {
    ball_paddle_event,
    ball_screen_event,
    ball_loose_event,
    brick_ball_event
  },

  events = {},

  --to deprecate
  ball_paddle = false,

  new = function(self, tbl)
    tbl = class:new(self, tbl)
    -- for et in all(self.event_types) do
    --   add(tbl.events, et:new(et))
    -- end
    return tbl
  end,

  init = function(self)
    self.event_types = {}
    for et in all(self.event_types) do
      add(self.events, et:new(et))
    end
  end,

  -- detects collisions
  -- aka events
  update = function(self)
    for e in all(self.event_types) do
      if e:eval() then
        e:update()
      end
    end
  end,

  is_circle_colliding = function(self, circle1, circle2, tolerance)
    tolerance = tolerance or self.tol
    -- Default to 0 if not provided
    local dx = circle1.x - circle2.x
    local dy = circle1.y - circle2.y
    local distance = sqrt(dx * dx + dy * dy)

    return distance < circle1.r + circle2.r + tolerance
  end,

  is_circle_inside_rect_colliding = function(self, circle, rec, tolerance)
    tolerance = tolerance or self.tol
    -- Default to 0 if not provided
    local dx = min(abs(circle.x - rec.x),abs(circle.x - (rec.x + rec.w)))
    local dy = min(abs(circle.y - rec.y),abs(circle.y - (rec.y + rec.h)))

    return dx * dx + dy * dy < (circle.r + tolerance) * (circle.r + tolerance)
  end,

  is_circle_inside_rect_collision_side = function(self, circle, rec, tolerance)
    tolerance = tolerance or self.tol

    local collision = self:is_circle_inside_rect_colliding(circle, rec, tolerance)
    local side = {
      left = false,
      right = false,
      top = false,
      bottom = false
    }
    if collision then
      log("is_circle_inside_rect_collision_side collision detected")
      -- determine the side of collision
      side["left"] = (abs((circle.x - circle.r) - rec.x)) <= tolerance
      side["right"] = (abs((circle.x + circle.r) - (rec.x + rec.w))) <= tolerance
      side["top"] = (abs((circle.y - circle.r) - rec.y)) <= tolerance
      side["bottom"] = (abs((circle.y + circle.r )- (rec.y + rec.h))) <= tolerance
    end
    return collision, side
  end,

  is_circle_rect_colliding = function(self, circle, rec, tolerance)
    tolerance = tolerance or self.tol
    -- Default to 0 if not provided
    local closest_x = mid(rec.x, circle.x, rec.x + rec.w)
    local closest_y = mid(rec.y, circle.y, rec.y + rec.h)

    local dx = circle.x - closest_x
    local dy = circle.y - closest_y

    return dx * dx + dy * dy < (circle.r + tolerance) * (circle.r + tolerance)
  end,

  is_circle_rect_collision_side = function(self, circle, rec, tolerance)
    tolerance = tolerance or self.tol

    local collision = self:is_circle_rect_colliding(circle, rec, tolerance)
    local side = {
      left = false,
      right = false,
      top = false,
      bottom = false
    }
    if collision then
      -- determine the side of collision
      side["left"] = (abs((circle.x + circle.r) - rec.x)) <= tolerance
      side["right"] = (abs((circle.x - circle.r) - (rec.x + rec.w))) <= tolerance
      side["top"] = (abs((circle.y + circle.r) - rec.y)) <= tolerance
      side["bottom"] = (abs((circle.y - circle.r )- (rec.y + rec.h))) <= tolerance
    end
    return collision, side
  end,

  is_rect_colliding = function(self, rect1, rect2, tolerance)
    tolerance = tolerance or self.tol
    -- Default to 0 if not provided
    return rect1.x < rect2.x + rect2.w + tolerance
        and rect1.x + rect1.w > rect2.x - tolerance
        and rect1.y < rect2.y + rect2.h + tolerance
        and rect1.y + rect1.h > rect2.y - tolerance
  end
})