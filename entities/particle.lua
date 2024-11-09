-- particle skeleton
particle=entity:extend({
  rad=0,
  dx=rnd(2)-1,
  dy=rnd(2)-1,
  clr=9,
  clrs={8,9,10,7},
  life=30,
  g=0.02,

  move=_noop,
  update=function(_ENV)
    move(_ENV)
    life-=1
    if(life<0)destroy(_ENV)
  end,
  draw=function(_ENV)circfill(x,y,rad,clr) end,
})
-- fireworks particle
function frwpart(tbl)
  tbl.move=function(_ENV) 
    x+=dx
    y+=dy
    dy+=g
    clr=rnd(clrs)
  end
  return particle(tbl)
end

function tailpart(tbl)
  tbl.move=function(_ENV)
    x+=dx
    y+=dy
    dx*=0.001
    dy*=0.001
    clr=rnd(clrs)
  end
  return particle(tbl)
end
