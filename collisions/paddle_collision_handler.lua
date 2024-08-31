pb_handler = collision_handler:new({

  handle=function(self, b, p)
    if(b:is_state("sticky")) return false
    
    --paddle resets current combo
    _pcombo=1

    local top_dist = abs(p.y - (b.y+b.r))
    local bot_dist = abs((b.y-b.r) - (p.y+p.h))
    local left_dist = abs(p.x - (b.x+b.r))
    local right_dist = abs((b.x-b.r) - (p.y+p.w))
    min_dist = min(top_dist, bot_dist, left_dist, right_dist)
    
    if top_dist == min_dist then 
      --flip DY to up, calc new DX
      self:handle_top_bounce(b, p)
    elseif bot_dist == min_dist then
      b.dy = abs(b.dy)--flip DY to down
    end

    if left_dist == min_dist then
      b.dx = -2.5
      b.dy = -abs(b.dy) 
      --flip both DX and Dy, wide angle and more speed
    elseif right_dist == min_dist then
      b.dx = -2.5
      b.dy = -abs(b.dy) 
    end
  end,

  handle_top_bounce=function(self, b, p)
    local x_pos = flr(b.x-p.x)
    local seg = flr(p.w / 6)
    b.dy = -(abs(b.dy) + rnd(_bacc*0.05))
    for i=1,6 do
      if (x_pos <= i*seg and x_pos > (i-1)*seg) then
        if i <= 3 then
          b.dx = -((4-i)*_bacc)
        else
          b.dx = (i-3)*_bacc
        end
      end
    end
    --paddle hit
    if(b:power() == _pwr_fury) then
      b:state("sticky")
      b.pwr=0 
      sfx(8)
    else
      b.pwr = max(0, b.pwr - _paddle_pen)
      sfx(1)
    end
  end
})