__hit_on_fn = function(br)
  br.raw_draw = br.draw
  br.draw = function(br, x_pos, y_pos)
    x_pos = x_pos or br.x
    y_pos = y_pos or br.y
    if br.hit_spr == #_brick_hit_spr then
      br:state("hidden")
    else
      if br.hit_frs >= _brick_hit_frs then
        spr(_brick_hit_spr[br.hit_spr], x_pos, y_pos)
        br.hit_spr += 1
        br.hit_frs = 0
      else
        br.hit_frs += 1
      end
    end
  end
end

__hit_off_fn = function(br)
  br.draw = br.raw_update
end