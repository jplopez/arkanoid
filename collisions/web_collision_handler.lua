web_handler=collision_handler:extend({
  r={-0.125,-0.25,0,0.125,0.25},
  handle=function(_ENV, b, w)
    if(_aspects["web"].enabled and w:is(visible) and
      (abs(b.y - w.y1) <= global._colle.tolerance)) then
      w:on_collision(b)
      b.dy=-abs(b.dy)
      b.dx=b.dx+rnd(r)
    end
  end
})