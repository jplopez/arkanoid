__visible_on_fn=function(br)
  br.raw_draw = br.draw
  br.draw = function(br, n, y_pos, x_pos) 
      x_pos = x_pos or br.x
      y_pos = y_pos or br.y
      n = n or br.clr
      spr(n,x_pos,y_pos)
  end
end

__visible_off_fn=function(br)
  br.draw = br.raw_update
end
