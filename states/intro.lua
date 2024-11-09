intro_gst=gst_handler:extend({
  ty=10,-- 'arkanoid' title y coordinate
  _t=0, -- timer count to animate
  ph=0, -- hight of 'pico' logo for animation
  
  spark_count=20,
  sparkles={},

  on=function(_ENV)
    ty,_t,ph,_begin_anim_title=16,0,0,false 
    show_hs=false 
    create_sparkles(_ENV)
  end,
  
  update=function(_ENV)
    --slide down anim for title
    if _begin_anim_title then
      _t=(_t+1)%4
      if(_t==0)then
        ty=mid(10,ty+1,24)
        ph=mid(0,ph+2,32)
      end
    end
    update_sparkles(_ENV)
    if(btnp(❎))sfx(3)delay(6,function()gset(game)end)
  end,

  draw=function(_ENV)
    cls(1)palt(1)
    draw_sparkles(_ENV)
    draw_splash_screen(_ENV)
    printoc("press ❎ to start",60,_pal_h1,_pal_h1o)
    printc("2024 made with ♥ by jp v.".._version,122,13)  
    --draw_highscores(70)
    pal()
  end,

  draw_splash_screen=function(_ENV) 
    draw_title(0,ty,128,32)
    draw_p(0,8,16,ph)
    if(not _begin_anim_title)delay(6,function()_begin_anim_title=true end)
  end,

  --sparkles
  create_sparkles=function(_ENV)
    for i=1,spark_count do
      add(sparkles,{x=rnd(127),y=rnd(127),
          r=rnd(1)+1,clr=rnd(2)+5, 
          sp=rnd({0.2,0.4,0.5})})
    end
  end,

  update_sparkles=function(_ENV)
    for spark in all(sparkles) do
      if(spark.x<=0 or spark.y>=127)spark.x=(rnd(127)+1)spark.y=rnd(127)
      spark.x-=0.5*spark.sp
      spark.y+=1*spark.sp
    end
  end,

  draw_sparkles=function(_ENV) 
    for s in all(sparkles)do circfill(s.x,s.y,s.r,s.clr)end
  end,

})

function draw_title(dx,dy,tw,th) sspr(0,64,128,32,dx,dy,tw,th,false,false) end

function draw_p(dx,dy,tw,th)
  -- Letter P
  sspr(16,64,8,16,dx,dy,tw/2,th/2,false,false)
  sspr(120,32,8,24,dx+8,dy,tw/2,th*0.75,false,false)
  sspr(112,48,8,16,dx,dy+16,tw/2,th/2,false,false)
  --Pico-8 logo
  local pth=0.3125*th
  sspr(40,32,5,5,dx+15,dy+3,pth,pth,false,false)
end