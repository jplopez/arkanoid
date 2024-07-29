--brick ball event
brick_ball_event = event:new({
  dx_next = "",
  dy_next = "",

  brick = nil,

  eval = function(self)
    self.dx_next = ""
    self.dy_next = ""

    local b = _players["p1"]["ball"]
    local b_x = b.x
    local b_y = b.y
    local b_y2 = b.y + b.r * 2
    local b_x2 = b.x + b.r * 2
    local bricks = _cur_lvl.grid

    log("brick_ball eval ")

    for r = 1, _cur_lvl.max_row do
      for c = 1, _cur_lvl.max_col do
        local br = bricks[r][c]

        if br != nil and br:visible() then
          local br_x = br.x
          local br_y = br.y
          local br_x2 = br.x + br.w
          local br_y2 = br.y + br.h
          local tol = _col_eng.tol
          if overlap(tol,
            b_x, b_x2, b_y, b_y2,
            br_x, br_x2, br_y, br_y2
          ) then
            log("brick_ball eval Overlap tol:"..tol)
            log("b: ("..b_x..","..b_y..") ("..b_x2..","..b_y2.. ")")
            log("br["..r.."]["..c.."]:("..br_x..","..br_y..") ("..br_x2..","..br_y2.. ")")

            --horizontal
            if near(tol, b_y2, br_y) then
              -- log("up b_y2:"..b_y2.." br_y:"..br_y)
              self.dy_next = "up"
              self.x_pos = abs(br_x - b_x + b.r)
              self.y_pos = abs(br_y - b_y2)
            elseif near(tol, b_y, br_y2) then
              -- log("down b_y:"..b_y.." br_y2:"..br_y2)
              self.dy_next = "down"
              self.x_pos = abs(br_x - b_x + b.r)
              self.y_pos = abs(br_y - b_y)
            end

            --vertical
            if near(tol, b_x, br_x2) then
              -- log("right b_x:"..b_x.." br_x2:"..br_x2)
              self.dx_next = "right"
              self.x_pos = abs(br_x - b_x)
              self.y_pos = abs(br_y - b_y + b.r)
            elseif near(tol, b_x2, br.x) then
              -- log("left b_x2:"..b_x2.." br_x:"..br_x)
              self.dx_next = "left"
              self.x_pos = abs(br_x - b_x2)
              self.y_pos = abs(br_y - b_y + b.r)
            end
            
            if (self.dx_next != "") or (self.dy_next != "") then
              log("brick_ball eval dx_next: "..self.dx_next)
              log("brick_ball eval dy_next: "..self.dy_next)
              log("brick_ball eval pos(x,y) ("..self.x_pos..","..self.y_pos..")")
              self.brick = br
              return true
            end
            log("brick_ball eval false")
            return false
          end --overlap
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
      powerup_event:notify(self.brick)
    end

    powerup_event:update(self.brick)
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