--entity: generic interative object 
-- other objects (ie metatables) should extend from this one

-- entity states
_entity_states = {
  visible = "visible",
  hidden = "hidden",
  idle = "idle"
}

entity = class:new({

  x = 0,
  y = 0,
  w = 0,
  h = 0,

  state = _entity_states.hidden,

  x2 = function(self)
    return self.x + self.w
  end,

  y2 = function(self)
    return self.y + self.h
  end,

  visible = function(self)
    return self.state == _entity_states.visible
  end,

  hidden = function(self)
    return self.state == _entity_states.hidden
  end,

  idle = function(self)
    return self.state == _entity_states.idle
  end, 

  init=function(self, ...) end,

  update = function(self)
    self:pre_update()
    if (self:visible()) self:update_visible()
    if (self:hidden()) self:update_hidden()
    if (self:idle()) self:update_idle()
    self:post_update()
  end,

  pre_update = function(self, ...) end,

  post_update = function(self, ...) end,


  draw = function(self)
    self:pre_draw()
    if (self.state == _entity_states.visible) self:draw_visible()
    if (self.state == _entity_states.hidden) self:draw_hidden()
    if (self.state == _entity_states.idle) self:draw_idle()
    self:post_draw()
  end,

  pre_draw = function(self, ...) end,

  post_draw = function(self, ...) end,

  on_collision = function(self, ...) end,

  -- metatables
  __eq = function(self, obj)
    if (obj == nil) return false

    if self ~= obj then
      return self.x == obj.x and
          self.y == obj.y and
          self.w == obj.w and
          self.h == obj.h and
          self.state == obj.state
    end
    return false
  end

})