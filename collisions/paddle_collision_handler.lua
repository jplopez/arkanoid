pb_handler=collision_handler:extend({

  handle=function(_ENV,b,p,s)
    s=s or b.col_side
    if(b:is(sticky) or b:is(hidden))return false
    --paddle resets current combo
    _pcombo=1
    b.dx=calc_dx(_ENV,p,b,s)
    b.dy=calc_dy(_ENV,p,b,s)
    upd_ball(_ENV,p,b,s)
  end,

  calc_dy=function(_ENV,paddle,ball,side)
    if(one_of({_top,_left,_right},side)) return -(abs(ball.dy)+rnd(_bacc*0.05))
    if(one_of({_top_left,_top_right},side))return -abs(ball.dy)
    --if(one_of({_bottom,_bottom_left,_bottom_right},side))return abs(ball.dy)
    return abs(ball.dy)
  end,

  calc_dx=function(_ENV,paddle,ball,side)
    if(one_of({_top_left,_bottom_left},side))return -2.5
    if(one_of({_top_right,_bottom_right},side))return 2.5
    if(side==_top) return handle_top_bounce(_ENV,paddle,ball)
  end,

  upd_ball=function(_ENV,p,b,s)
    if(b.power==_pwr_fury)then
      b:set(sticky)sfx(8)b.pwr=0
    elseif(paddle_glue.enabled and s==_top)then
      b:set(sticky)
    else
      b.pwr=max(0,b.pwr-global._paddle_pen)
      sfx(1)end
    end,

  --calc ball dx angle when hitting the 
  --paddle in the top side
  handle_top_bounce=function(_ENV,p,b)
    local dx
    local x_pos=flr(b.x-p.x)
    local seg=flr(p.w/6)
    for i=1,6 do
      if (x_pos<=i*seg and x_pos>(i-1)*seg)then
        if i<=3 then dx=-((4-i)*global._bacc)
        else dx=(i-3)*global._bacc end
      end  
    end
    return dx
  end,
})