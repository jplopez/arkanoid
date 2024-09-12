web_handler=collision_handler:new({
  r={-0.125,-0.25,0,0.125,0.25},
  handle=function(self, b, w)
    if(_aspects["web"].enabled and w:is_state("visible") and
      (abs(b.y - w.y1) <= _colle.tolerance)) then
      w:on_collision(b)
      b.dy=-abs(b.dy)
      b.dx=b.dx+rnd(r)
    end
  end
})