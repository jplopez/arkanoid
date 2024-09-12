web=object:new({
  x1=_screen_left,
  y1=_screen_bot-11,
  x2=_screen_right,
  y2=_screen_bot-11,
  clr=3,
  shield=1,
  hit=0,
  _fc=0,
  states={"show","visible", "hidden"},
  -- sprites to animate the net lights
  spr_map={
  --{sx,sy,sw,sh,dx,dy}
    {53,33,3,3,2,1},
    {49,33,3,3,2,1},
    {48,32,5,5,3,2},
  },
  update=function(self)
    if(self.hit>=self.shield) then
      toggle_aspect_by_name("web", false)
      sfx(31)
      self.hit=0
    end
    self._fc=(self._fc+1)%30
  end,

  draw=function(self)
    if(self:is_state("show")) then
      sfx(10)
      self:state("visible")
    end
    if(self:is_state("visible")) then
      local px2=_ppaddle.x+_ppaddle.w
      line(self.x1,self.y1,_ppaddle.x,self.y2,self.clr)
      line(px2,self.y1,self.x2,self.y2,self.clr)

      --animates the net lights
      local s=self.spr_map[flr(self._fc/10)+1]
      sspr(s[1],s[2],s[3],s[4],_ppaddle.x-s[5],self.y1-s[6],s[3],s[4])
      sspr(s[1],s[2],s[3],s[4],px2-s[5],self.y1-s[6],s[3],s[4])
    end
  end,

  on_collision=function(self,b)
    self.hit+=b:hits()
    sfx(9)
  end
})