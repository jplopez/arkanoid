-- start


start_gamestate = gamestate:new({

  ty = 16,
  _t = 0,
  _h1o = _pals["h1o"],

  ph=0,

  update=function(self)

    local tt = _timers["anim_title"]
    if(tt.active) then 
      tt:update()
    else 
      tt:restart()
    end
    
    --slide down anim for title
    if _begin_anim_title then
      local __t,__ty,__ph = self._t, self.ty,self.ph
      __t = (__t + 1) %  4
      if (__t==0) then
        __ty = mid(16, __ty+1, 32)
        __ph = mid(0, __ph+2 ,32)
      end
      self._t, self.ty, self.ph = __t,__ty,__ph 
    end

    -- start game delay
    local timer = _timers["start_timer"]
    if timer.active then
      timer:update()
    else
      if btn(5) then
        sfx(3)
        self._h1o = 7
        timer:restart()
      end
    end
  end,

  draw=function(self)
    cls(_pals.bg[1])
    palt(_pals.bg[1])

    --stamp_title(0, self.ty, 128, 32)
    self:draw_title()

    local str = "press ❎ to start"
    local x = 64-(#str*4)/2
    printo(str, x, 72, _pals["h1"], self._h1o)

    str="2024. made with ♥ by jp"
    x = 127-(#str*4)
    printc(str, 110, _pals["h3"])
    
    str="v." .. _version
    printc(str, 118, _pals["h3"])
    pal()
  end,

  draw_title=function(self) 
    palt(_pals.bg[1])
    stamp_title(0, self.ty, 128, 32)
    stamp_pico(0, 12, 16, self.ph)
    pal()
  end

})

function startgame(l)
  l = l or 1
 
  -- reset paddle and ball
  local p = _players["p1"]["paddle"]
  local b = _players["p1"]["ball"]

  p:init()
  b:serve()

  -- reset player data
  _players["p1"]["lives"] = 3
  _players["p1"]["score"] = 0
  _players["p1"]["level"] = l
  _players["p1"]["combo"] = 0
  init_bonus()

  _cur_lvl:init(l)
  -- log("Game state: start -> game - level: "..tostr(l))
  -- _state = "game"
  set_gamestate("game")
end

function stamp_title(dx,dy,tw,th)
  sspr(0,64,128,32,dx,dy,tw,th,false, false)
end

function stamp_pico(dx,dy,tw,th)
  -- Letter P
  sspr(16,64,8,16,dx,dy,tw/2,th/2,false, false)
  sspr(120,32,8,24,dx+8,dy,tw/2,th*0.75,false, false)
  sspr(112,48,8,16,dx,dy+16,tw/2,th/2,false, false)

  --Pico-8 logo
  local pth = 0.3125*th
  sspr(40,32,5,5,dx+15,dy+3,pth,pth,false,false)
end