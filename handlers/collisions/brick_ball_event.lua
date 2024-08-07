--brick ball event
brick_ball_event = event:new({
  dx_next = "",
  dy_next = "",

  brick = nil,

  eval = function(self)
    self.dx_next = ""
    self.dy_next = ""

    local b = _players["p1"]["ball"]
    local bricks = _cur_lvl.grid

    log("brick_ball eval ")

    for r = 1, _cur_lvl.max_row do
      for c = 1, _cur_lvl.max_col do
        local br = bricks[r][c]

        if br ~= nil and br:visible() then

          local is_colliding, side = _col_eng:is_circle_rect_collision_side(b, br)
          if is_colliding then  
            -- log("brick_ball eval collision detected: ")
            -- log("           br:("..r..","..c..") tol:".._col_eng.tol)
            -- log(" side(u,d,l,r):"..tostr(side["top"])..
            --     ","..tostr(side["bottom"])..
            --     ","..tostr(side["left"])..
            --     ","..tostr(side["right"]))
            -- TEMPORARY
            if(side["top"]) then self.dy_next="up" end
            if(side["bottom"]) then self.dy_next = "down" end
            if(side["left"]) then self.dx_next = "left" end 
            if(side["right"]) then self.dx_next = "right" end
            
            if (self.dx_next ~= "") or (self.dy_next ~= "") then
              -- log("brick_ball eval dx_next: "..self.dx_next)
              -- log("brick_ball eval dy_next: "..self.dy_next)
              -- log("brick_ball eval pos(x,y) ("..self.x_pos..","..self.y_pos..")")
              self.brick = br
              return true
            end
            log("brick_ball eval false")
            return false
          end --is_colliding
        end --if visible
      end --for col loop
    end
    --for row loop

    return false
  end,

  update = function(self)
    local b = _players["p1"]["ball"]
    b.dx = self:calc_dx(self.brick, b)
    b.dy = self:calc_dy(self.brick, b)

    --brick collision event
    self.brick:on_collision()
    if not self.brick:visible() then
      _cur_lvl.br_left -= 1
    end
  end,

  calc_dx = function(self, br, b)
    if self.dx_next == "left"
        or self.dx_next == "right" then
      return -b.dx
    end
    return b.dx
  end,

  calc_dy = function(self, br, b)
    if self.dy_next == "up"
        or self.dy_next == "down" then
      return -b.dy
    end
    return b.dy
  end,

  to_string = function(self)
    return "brick_ball_event\n"
        .. " " .. event:to_string(self) .. "\n"
        .. " n(x,y):("
        .. tostr(self.dx_next) .. ","
        .. tostr(self.dy_next) .. ")"
    --   .."  br:"..tostr(self.brick) --:to_string()
  end
})