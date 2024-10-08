pb_handler = collision_handler:new({

  handle=function(self, b, p, s)
    if(b:is_state("sticky")) return false
    --paddle resets current combo
    _pcombo=1
    
    --flip DY to up, calc new DX
    if(s==_top and b.dy>0) self:handle_top_bounce(b, p)
    --flip DY to down
    if(s==_bottom) b.dy=abs(b.dy)

    --flip both DX and Dy, wide angle and more speed
    if(s==_top_left) then
      b.dx=-2.5
      b.dy=-abs(b.dy) 
    elseif(s==_top_right) then
      b.dx=2.5
      b.dy=-abs(b.dy) 
    end
  end,

  handle_top_bounce=function(self,b,p)
    local x_pos=flr(b.x-p.x)
    local seg=flr(p.w/6)
    b.dy=-(abs(b.dy)+rnd(_bacc*0.05))
    for i=1,6 do
      if (x_pos<=i*seg and x_pos>(i-1)*seg) then
        if i<=3 then
          b.dx=-((4-i)*_bacc)
        else
          b.dx=(i-3)*_bacc
        end
      end  
    end
    --paddle hit
    if(b:power() == _pwr_fury) then
      b:state("sticky")
      b.pwr=0 
      sfx(8)
    elseif(_aspects["paddle_glue"].enabled) then
      b:state("sticky")  
    else
      b.pwr=max(0,b.pwr-_paddle_pen)
      sfx(1)
    end
  end
})