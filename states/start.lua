start_gamestate={
  ty=16,-- 'arkanoid' title y coordinate
  _t=0, -- timer count to animate
  ph=0, -- hight of 'pico' logo for animation

  update=function(self)
    --slide down anim for title
    if _begin_anim_title then
      local __t,__ty,__ph=self._t, self.ty,self.ph
      __t=(__t+1)%4
      if(__t==0)then
        __ty=mid(16,__ty+1,32)
        __ph=mid(0,__ph+2,32)
      end
      self._t,self.ty,self.ph=__t,__ty,__ph 
    end
    -- start game delay
    if(btn(5))sfx(3)delay(6,startgame,_plevel)
  end,

  draw=function(self)
    cls(1)palt(1)
    stamp_title(0,self.ty,128,32)
    stamp_pico(0,15,16,self.ph)
    printoc("press ❎ to start",72,_pal_h1,_pal_h1o)
    printc("2024. made with ♥ by jp",110,_pal_h3)
    printc("v.".._version,118,_pal_h3)
    pal()
    if(not _begin_anim_title)delay(6,function()_begin_anim_title=true end)
  end
}

function startgame(l)
  l=l or 1 
  -- reset paddle and ball
  _ppaddle:init()
  _pball:serve({dy=-1,dx=0.5})
  -- reset player data
  _plives=3
  --_pscore = 0
  _score:reset()
  _plevel=l
  _pcombo=0
  --init_bonus()
  _lvl:init(l)
  _pups={}
  gameover_gamestate.snd=true
  gamestate("game")
  disable_all_aspects()
end

function stamp_title(dx,dy,tw,th) sspr(0,64,128,32,dx,dy,tw,th,false,false) end

function stamp_pico(dx,dy,tw,th)
  -- Letter P
  sspr(16,64,8,16,dx,dy,tw/2,th/2,false,false)
  sspr(120,32,8,24,dx+8,dy,tw/2,th*0.75,false,false)
  sspr(112,48,8,16,dx,dy+16,tw/2,th/2,false,false)
  --Pico-8 logo
  local pth=0.3125*th
  sspr(40,32,5,5,dx+15,dy+3,pth,pth,false,false)
end