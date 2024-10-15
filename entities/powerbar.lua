powerbar=entity:extend({
  x=_screen_left+8,  --_screen_right - 38,
  y=_screen_bot-5,
  --bars=0,
  --max_bars=8,
  --pwr="empty",
  --pre_pwr=_pwr_off,

  update=function(_ENV)
    --bars=mid(0,ceil((_pball.pwr/_pwr_max)*max_bars),max_bars)
    --pre_pwr=pwr
    --pwr=_pball.pwr
  end,

  draw=function(_ENV)
    rectfill(x,y,x+(_pwr_max/2),y+6,5)
    local col=11
    if(_pball.power==_pwr_ball) col=10
    if(_pball.power==_pwr_fury) col=8
    rectfill(x,y,x+ceil(_pball.pwr/2),y+6,col)

    if(_pwrbar_increment>1)print("x".._pwrbar_increment,x+(_pwr_max/2)+2,y,_pal_h2)
  end,
  -- draw_bar_item=function(_ENV,i,s)
  --   s=s or _pwr_spr["empty"]
  --   local sx,sy,sw,sh,dx,fl_x=
  --     s["sxb"],s["syb"],5,6,x+((i-1)*4),(max_bars==i) 
  --   palt(0,true)--palt(s["paltb"])
  --   if(i>1 and i<max_bars) then
  --     sx,sy=s["sx"],s["sy"]
  --     --palt(s["palt"])
  --   end
  --   sspr(sx,sy,sw,sh,dx,y,sw,sh,fl_x,false)
  -- end
})