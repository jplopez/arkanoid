function composite_brick(_ENV)
  return brick:extend({
    bricks={},
    oob_bricks={},
    union=function(_ENV,other,oob)
      if other!=nil then
        if #bricks==0 then
          x,y,w,h=other.x,other.y,other.w,other.h
          set(_ENV,other:set())
        else join(_ENV,other) end
        if(oob)then add(oob_bricks,other)
        else add(bricks,other) end
      end
    end,

    on_collision=function(_ENV,b)
      local hit_count=0
      for br in all(bricks)do
        br:on_collision(b)
        if(br:is(hit) and (not br.unbreakable))hit_count+=1
      end
      return hit_count
    end,
  })
end
