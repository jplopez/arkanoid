anim_brick = brick:new({
  frame = 0,
  speed = 0.01,
  dx = 0,
  dy = 0,

  move_x = false,
  move_y = false,

  length_x = 10 + 3,
  length_y = 4 + 3,

  update = function(self)
    self.frame += self.speed
    self.dx = cos(self.frame) * self.length_x
    self.dy = sin(self.frame) * self.length_y
  end,

  draw_visible = function(self, n, x_pos, y_pos)
    local x_pos = self.x
    if self.move_x then
      x_pos = mid(_screen_left, x_pos + self.dx, _screen_right - self.w)
    end

    local y_pos = self.y
    if self.move_y then
      y_pos = mid(_screen_top, y_pos + self.dy, _screen_bot - self.h)
    end
    brick.draw_visible(self, self.s, x_pos, y_pos)
  end
})

slow_x_brick = anim_brick:new({
  move_x = true,
  move_y = false,
  speed = 0.01
})

mid_x_brick = anim_brick:new({
  move_x = true,
  move_y = false,
  speed = 0.013
})