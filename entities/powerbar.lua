powerbar=class:new({
  x= _screen_left + 8,  --_screen_right - 38,
  y= _screen_bot - 5,
  bars=0,
  max=8,
  pwr="empty",
  pre_pwr=_pwr_off,

  update=function(self)
    self.bars = mid(0,ceil((_pball.pwr/_pwr_max)*self.max),self.max)
    self.pre_pwr=self.pwr
    self.pwr=_pball:power()
  end,

  draw=function(self)
    for i=1,self.max do
      if(self.bars<i) then self:draw_bar_item(i,_pwr_spr["empty"])
      else self:draw_bar_item(i,_pwr_spr[self.pwr])end
    end
    pal()

    if(_pwrbar_increment>1)then
      print("x".._pwrbar_increment,self.x+(self.max*4)+2,self.y,_pal_h2)
    end
  end,

  draw_bar_item=function(self,i,s)
    local sx,sy,sw,sh,dx,fl_x=
      s["sxb"],s["syb"],5,6,self.x+((i-1)*4),(self.max==i) 
    palt(s["paltb"])
    if(i>1 and i<self.max) then
      sx, sy= s["sx"], s["sy"]
      palt(s["palt"])
    end
    sspr(sx, sy, sw, sh, dx, self.y, sw, sh, fl_x, false)
  end

})