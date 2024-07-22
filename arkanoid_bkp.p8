pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--globals and game loop

-----------
--globals
-----------

noop=function()end

--screen
_screen_margin=4
_screen_left=_screen_margin
_screen_right=127-_screen_margin  
_screen_top=_screen_margin*3
_screen_bot=127

--level
_cur_lvl= nil

--states
_states={
 start={"game"},
 levelup={"game"},
 game={"levelup","gameover"},
 gameover = {"start"} 
}
_init_state="start"
_state=""

_timers={ }

--palletes
_pals = {
  bg = {1,2,3},
  paddle = {12,13,14,15},
  ball ={8,9,10,11}
}

--players
_players = { p1={}, p2={} }

#include states/init.lua
#include entities/class.lua
#include utilities/timers.lua
#include utilities/collisions.lua
#include utilities/utils.lua

-------------
--game loop
-------------

function _init()
 cls()
 init_players()
 init_objects()
end

-- called every frame
function _update60()
 if(_state=="start") update_start()
 if(_state=="game") update_game()
 if(_state=="gameover") update_gameover()
 if(_state=="levelup") update_levelup()
end

-- called every frame
function _draw()
 if(_state=="start") draw_start()
 if(_state=="game") draw_game()
 if(_state=="gameover") draw_gameover()
 if(_state=="levelup") draw_levelup()
end


----------
-- debug
----------

_debug=true
_debug_flags={
 ball   = false,
 paddle = false,
 events = false,
 timers = false,
 level  = false
}

function debug()
 if not _debug then 
   return false end

 local b = _players["p1"]["ball"]
 local p = _players["p1"]["paddle"]

 if _debug_flags["ball"] then
	 print ("b (x1,y1),(x2,y2)=\n " 
	     .."  ("..tostr(b.x)
	     ..","..tostr(b.y)..")"
	     ..",("..tostr(b.x+(b.r*2))
	     ..",:"..tostr(b.y+(b.r*2)),
	     _screen_left, 
	     _screen_top+2, b.clr)
	 print(" (dx,dy) =:"
	     .."("..tostr(b.dx)
	     ..","..tostr(b.dy)
	     ..")",
	     _screen_left, 
	     _screen_top+16, b.clr)
 end
 
 if _debug_flags["events"] then
	 print("e"..tostr(_debug_e_pos), 
	     _screen_left, 
	     _screen_top+23, 7)
	 print("b"..tostr(_debug_b_pos),
	     _screen_left, 
	     _screen_top+32, b.clr)
	 print("p"..tostr(_debug_p_pos),
	     _screen_left, 
	     _screen_top+41, p.clr)
	 print("d"..tostr(_debug_d_pos),
	     _screen_left, 
	     _screen_top+50, p.clr)
 end

 if _debug_flags["paddle"] then 
	 print ("p (x:y) ("..tostr(p.x)
	     ..","..tostr(p.y)..")"
	     .." state:"..tostr(p.state)
	     .." dx:"..tostr(p.dx)
	     ,p.clr)
 end
 
 if _debug_flags["events"] then
	 print("#e".. count(_col_eng.events),7)
	 for e in all(_col_eng.events) do
	  print(" "..e:to_string())
	 end
 end
 
 if _debug_flags["timers"] then
	 print("t:".. count(_timers),7)
	 t=_timers["start_timer"]
	 print("st: l:"..tostr(t.length)
	   .." fr:"..t.fr)
 end
 
 if _debug_flags["level"] then
	 print("lvl br:".. _cur_lvl.br_count
	   .." l:".._cur_lvl.br_left ,7)
  local i=1
  for brl in all(_cur_lvl.grid) do
   for br in all(brl) do
    print("br"..i.." "..br.x..","..br.y)
    i+=1
   end
  end
 end
 
 
 return true

end

-->8
-- utilities


-- class
-- class=setmetatable({
-- 	new=function(self,tbl)
-- 		tbl=tbl or {}
		
-- 		setmetatable(tbl,{
-- 			__index=self
-- 		})
		
-- 		return tbl
-- 	end,
	
-- 	init=noop
-- },{__index=self})

-- -- timer
-- timer=class:new({

--  elapsed=0,
--  fr=30,
--  length=30, -- 30 frames, aka one second
--  active=false,
--  step_fn=nil,
--  end_fn=nil,
--  last_time=0,
  
--  new=function(self,length,step_fn,end_fn)
--   tbl = class:new(self,tbl)
--   tbl.length=length
--   tbl.active=false
--   tbl.step_fn=step_fn
--   tbl.end_fn=end_fn
--   tbl.last_time=0
--   return tbl
--  end,
 
--  new60=function(self, length, 
--    step_fn, end_fn)
--   tbl= self.new(self, length,
--      step_fn, end_fn)
--   tbl.fr=60
--   return tbl
--  end,
 
--  init=function(self)
--   self.last_time=0
--  end,
  
--  update=function(self)
--   self.last_time=elapsed
  
--   if self.active then
--    self.elapsed+=1
--    local elapsed=self.elapsed
--    local length=self.length

--    if elapsed < length then
--     if self.step_fn then
--      self.step_fn(self,dt,elapsed,length)
--     end
--    else
--     self.active=false
--     if self.end_fn then
--      self.end_fn(self,dt,elapsed,length) 
--     end
--    end

--   end
--  end,
 
--  pause=function(self)
--   self.active=false
--  end,
 
--  resume=function(self)
--   self.active=true
--  end,

--  restart=function(self)
--   self.elapsed=0
--   self.active=true
--  end 
-- })

-- utils
-- save copied tables in `copies`, indexed by original table.
-- function deepcopy(orig, copies)
--  copies = copies or {}
--  local orig_type = type(orig)
--  local copy

--  if orig_type == 'table' then
--   if copies[orig] then
--    copy = copies[orig]
--   else
--    copy = {}
--    copies[orig] = copy
--    for orig_key, orig_value in next, orig, nil do
--     copy[deepcopy(orig_key, copies)] = deepcopy(orig_value, copies)
--    end
--    setmetatable(copy, deepcopy(getmetatable(orig), copies))
--   end
--  else -- number, string, boolean, etc
--   copy = orig
--  end

--  return copy
-- end

-- function outside(n, a, b, inclusive)
--  if inclusive then
--   return (n<=a or n>=b)
--  else
--   return (n<a or n>b)
--  end
-- end

-- function between(n,a,b,inclusive)
--  return not outside(n,a,b, not inclusive)
-- end

-- -- detects 2 objects are colliding
-- -- based based on the method
-- -- axis-aligned bounding boxes (aabb)
-- function overlap(tol, 
--     ax1,ax2,ay1,ay2,
--     bx1,bx2,by1,by2)
 
--  local d1x = bx1-ax2
--  local d1y = by1-ay2
--  local d2x = ax1-bx2
--  local d2y = ay1-by2
  
--  if (d1x>tol or d1y>tol) then
--   return false end
  
--  if (d2x>tol or d2y>tol) then
--    return false end
  
--  return true
-- end

-- -- are a and b near
-- -- tol=tolerance distance
-- function near(tol,a,b)
--  return abs(a-b)<(tol)
-- end

-- function side_col(tol,a1,a2,b1,b2)
--  return (near(tol,a2,b1) or
--          near(tol,a1,b2)) 
-- end

-- function tableconcat(t1,t2)
--  for i=1,#t2 do
--   t1[#t1+1] = t2[i]
--  end
--  return t1
-- end

-- -- print centered
-- function printc(str,y,clr)
-- 	local x=64-(#str*4)/2
-- 	print(str,x,y,clr)
-- end

-- -- print shadow
-- function prints(str,x,y,clr)
-- 	print(str,x+1,y+1,0)
-- 	print(str,x,y,clr)
-- end

-- -- left pad
-- function pad(str,len,char)
-- 	str=tostr(str)
-- 	char=char or "0"
-- 	if (#str==len) return str
-- 	return char..pad(str, len-1)
-- end
-->8
--playable objects

-- paddle
paddle=class:new({
 x=52,
 y=120,
 w=24,
 h=3,
 clr=12,
 
 dx=1,
 
 states = {
  idle="idle", 
  left="left",
  right="right"
 },
 
 state="idle",
 
 hit_clr=7,
 hit_frames=3,
 hit_count=0,
 
 new=function(self, tbl)
 	tbl=tbl or {}
 	setmetatable(tbl, {
 	  __index=self
 	})
 	return tbl
 end,
 
 move=function(self)
  if btn(0) then 
   self.left(self) 
  elseif btn(1) then
   self.right(self) 
  elseif self.state != 
      self.states.idle then
   self.brake(self)
  end 

 end,
 
 sndfx=function(self)
   if self.state==self.states.left
     or self.state==self.states.right then
     --sfx(3)
   end    
 end,
 
 update=function(self)
  self:move()
  self:sndfx()
 end,
 
 draw=function(self)
  rectfill(
   self.x,
   self.y,
   self.x+self.w,
   self.y+self.h,
   self.paddle_clr(self))
 end,
 
 left=function(self)
  if (self.x > _screen_left) then
   self.x-=self.dx
   self.state=self.states.left
  end
 end,
 
 right=function(self)
 	if (self.x < _screen_right-self.w) then
 	 self.x+=self.dx
 	 self.state=self.states.right
  end
 end,
 
 --not working
 brake=function(self)
  local dx = self.dx
  self.dx = self.dx/1.7
  if self.state == self.states.left then
   self:left()
  elseif self.state == self.states.right then
   self:right()
  else end
  self.dx=dx
  self.state=self.states.idle
 end,

 paddle_clr=function(self)
   local c = self.clr
   if _col_eng.ball_paddle then
    self.hit_count = self.hit_frames
    c = self.clr-4
   elseif self.hit_count>0 then
    self.hit_count-=1
    c = self.clr-4
   else
    c = self.clr
   end
   return c
 end
})

-- ball 
ball=class:new({
  
 x=_screen_left, --rnd(122),
 y=_screen_bot-20, --rnd(122),
 dx=0.5, --+rnd(6),
 dy=-1, --+rnd(6),
 r=2,
 clr=8,

 states = {
  idle="idle", 
  move="move",
  invert_x="invert_x",
  invert_y="invert_y",
  sticky="sticky"
 },
 state = "idle",  
 
 move=function(self) 
 
  if(self.state==self.states.sticky) do self:sticky_move()
  else
   self.state=self.states.move
    
   if outside(self.x, _screen_left, _screen_right) then
    self.dx*=-1
    self.state=self.states.invert_x
   end
 
   --if _col_eng.ball_paddle or 
   if self.y < _screen_top then
    self.dy*=-1
    self.state=self.states.invert_y
   end

   self.x+=self.dx
   self.y+=self.dy
  end --else
 end,   
  
 sticky_move=function(self)
  local p = _players["p1"]["paddle"]
  self.x=p.x+(p.w/2)
  self.y=p.y-(self.r*2)
 end,
 
 action=function(self)
  if self.state==self.states.sticky then
   if btn(5) then
    self.state=self.states.idle
   end
  end 
 end,
 
 sndfx=function(self)
  if(_col_eng.ball_paddle) then 
   sfx(1) end

  if (self.state==self.states.invert_y 
    or self.state==self.states.invert_x) then
 	 sfx(0) end
 end,

 update=function(self)
  self:move()
  self:action()
  self:sndfx()
 end,
  
 draw=function(self)
  circfill(
    self.x, 
    self.y, 
    self.r, 
    self.clr)
 end,
 
 serve=function(self)
  --resets paddle and ball
  local p = 
   _players["p1"]["paddle"]
 
	 self.x=p.x+(p.w/2)
	 self.y=p.y-(self.r*2)
	 self.dx=0.5
	 self.dy=-1
	 self.state=self.states.sticky
 end
})

-- brick
brick=class:new({

 x=_screen_left+12,
 y=_screen_top+10,
 w=10,
 h=4, 
 clr=14,
 visible=true,
  
 update=noop,
 
 draw=function(self)
  if self.visible then
   rectfill(self.x,
    self.y,
    self.x+self.w,
    self.y+self.h,
    self.clr)
  end
 end,

 on_collision=function(self)
  self.visible=false
  local combo = _players["p1"]["combo"]
  sfx(10+combo)  
 end,
 
 to_string=function(self)
  return "("..
    tostr(self.x)..","..
    tostr(self.y).."),"..
    tostr(self.visible)
 end

})

--unbreakable
god_brick=brick:new({

 clr=10,
 
 on_collision=function(self)
   sfx(6)
 end
})

--shielded brick
--can sustain 'shield' number
--of hits
shield_brick=brick:new({

 shield=2,
 hits=0,
 clr=13,

 on_collision=function(self)
  if(self.hits==self.shield) then
   brick.on_collision(self)
  else
   self.hits+=1
   sfx(5)
  end
 end
})
-->8
--game state functions

-- -- init
-- function init_players()
--  _players["p1"]["ball"]=
--    ball:new({
--     x=rnd(127),
--     dx=0.51,
--     y=rnd(127),
--     dy=0.51, --+rnd(2),
--     clr=rnd(_pals.ball) 
--    })
--  _players["p1"]["paddle"]=
--    paddle:new({
--     clr=rnd(_pals.paddle) 
--    })
-- end

-- function init_objects()
--  --level
--  _cur_lvl= level:new()

--  --collision engine   
--  _col_eng=col_eng:new()
 
--  --initial state
--  _state=_init_state

--  --bonus - extra 1up
--  init_bonus()
 
--  --timers
--  local start_timer = 
--    timer:new60(30,noop,
--      function() 
--       startgame(_players["p1"]["level"]) 
--      end)
--  start_timer:init()

--  _timers["start_timer"] =
--    start_timer

--  local levelup_timer = 
--    timer:new60(30,noop,
--      function() 
--       levelup() 
--      end)
--  levelup_timer:init()

--  _timers["levelup_timer"] =
--    levelup_timer

-- end

-- start
function draw_start()
 cls(_pals.bg[1])
 printc("pico-8 arkanoid",40,10)
 printc("press ❎ to start",60,11)
 printc("made with ♥ by jp",110,9)
end

function update_start()

 local timer = _timers["start_timer"]
 if timer.active then
  print(tostr(timer.length))
  timer.update(timer)
 else
  if btn(5) then
   sfx(3)
   timer.restart(timer)
  end
 end
end

-- game
function update_game()

 _cur_lvl:update()

 --apply changes to objects
 _col_eng:update(_col_eng)
 _players["p1"]["ball"]:update()
 _players["p1"]["paddle"]:update()

 if _cur_lvl.br_left <= 0 then
  _state="levelup"
 end

 update_bonus()

end

function draw_game()
 cls(0)
 draw_game_level()
 draw_game_ui()
 draw_players() 
 debug()
end

-- level
function update_levelup()

 local timer = _timers["levelup_timer"]
 if timer.active then
  print(tostr(timer.length))
  timer.update(timer)
 else
  if btn(5) then
   sfx(3)
   timer.restart(timer)
  end
 end
end

function draw_levelup()

 local l = _players["p1"]["level"]

 cls(_pals.bg[1])
 printc("level "..tostr(l)
   .." clear!",
     25,8)
 printc("lives : "..
   _players["p1"]["lives"],
     40,8)
 printc("current score:"..
   _players["p1"]["score"],
     55,10)
 printc("press ❎ to start next level",
     70,11)
end

-- gameover
function update_gameover()
 -- reset player data 
 _players["p1"]["lives"]=3
 _players["p1"]["score"]=0
 _players["p1"]["level"]=1 
 update_start()
end

function draw_gameover()
 cls(_pals.bg[1])
 printc("gameover",40,8)
 printc("score:"..
   _players["p1"]["score"],55,10)
 printc("press ❎ to start",70,11)
end

function startgame(l)
 l=l or 1

 print("startgame "..tostr(l))
 _state="game"

 -- reset paddle and ball
 local p = 
   _players["p1"]["paddle"]
 local b = 
   _players["p1"]["ball"]

 p.x=64-(p.w/2)
 p.dx=4
 p.state="idle"
 b:serve()

 -- reset player data 
 _players["p1"]["lives"]=3
 _players["p1"]["score"]=0
 _players["p1"]["level"]=l
 init_bonus()

 _cur_lvl:init(l)
end


--levelup
function levelup()
 _state="game"

 -- reset paddle and ball
 local p = 
   _players["p1"]["paddle"]
 local b = 
   _players["p1"]["ball"]

 p.x=64-(p.w/2)
 p.dx=4
 p.state="idle"
 b:serve()

 --load new level
 local lvl = 
   _players["p1"]["level"]
 lvl = lvl or 0
 _players["p1"]["level"]=lvl+1
 _cur_lvl:init(lvl+1)
 
end

function draw_game_level()
 
 --playable screen
 rect(
   _screen_left-1,
   _screen_top-1,
   _screen_right+1,
   _screen_bot+1,
   _pals.bg[2])
 rectfill(
   _screen_left,
   _screen_top,
   _screen_right,
   _screen_bot,
   _pals.bg[1])

 --level bricks
 _cur_lvl:draw()

end

function draw_game_ui()
 --player lives   
 local liv=pad(_players["p1"]["lives"],2)
 local next_x=print("p1X"..liv, 
   _screen_left,1,9)

 --level
 local lev=pad(_players["p1"]["level"],2)
 next_x=print("level "..lev,
   next_x+5,1,9)
 
 --score
 local score=pad(_players["p1"]["score"],6)
 next_x=print("score: "..score,
   _screen_right-50,1,9)
end

function draw_players()
 _players["p1"]["ball"]:draw()
 _players["p1"]["paddle"]:draw()
end


lives_bonus = {
 [1] = {score=1000 , claimed=false},
 [2] = {score=2000 , claimed=false},
 [3] = {score=5000 , claimed=false},
 [4] = {score=10000, claimed=false}
}

function init_bonus()
 for b in all(lives_bonus) do
  b["claimed"]=false
 end
end

function update_bonus()

 local p_score = _players["p1"]["score"]
 for n=1,#lives_bonus do 
  if not lives_bonus[n]["claimed"] then
   if p_score >= lives_bonus[n]["score"] then
    _players["p1"]["lives"]+=1
    lives_bonus[n]["claimed"]=true
    sfx(3)
    return false
   end
  end
 end
end
-->8
-- events handlers

-- base event object
event = class:new({
 x_pos=0,
 y_pos=0,
 
 -- eval if event occurred
 -- check is executed at the 
 -- update method, before 
 -- anything else
 eval=function(self)
  return false
 end,

 -- applies the changes 
 -- triggered by the event
 update=function(self)
 end,
 
 to_string=function(self)
  return " (x,y):("
    ..self.x_pos..","
    ..self.y_pos..")"
 end
})

-- ball hitting paddle
ball_paddle_event=event:new({
 
 dx_next="",
 dy_next="",
 
 eval=function(self)
  local ball= _players["p1"]["ball"]
  local paddle= _players["p1"]["paddle"]

  -- sticky ball
  if ball.state==ball.states.sticky then
   return false
  end
   
  self.dx_next=""
  self.dy_next=""

  local ball_x=ball.x
  local ball_y=ball.y
  local ball_x2=ball_x+(ball.r*2)
  local ball_y2=ball_y+(ball.r*2)

  local paddle_x=paddle.x
  local paddle_y=paddle.y
  local paddle_x2=paddle_x+paddle.w
  local paddle_y2=paddle_y+paddle.h
  
  if overlap(
        0.5, 
        ball_x,
        ball_x2,
        ball_y,
        ball_y2,
        paddle_x,
        paddle_x2,
        paddle_y,
        paddle_y2) then
    
   --to deprecate
   _col_eng.ball_paddle=true
    
   --horizontal
   if near(0.5,
      ball_y2,paddle_y) 
   then
    self.dy_next="up"
    self.x_pos=ball_x2-paddle_x
    self.y_pos=paddle_y-ball_y2

   elseif near(0.5,
    ball_y,paddle_y2) 
   then
    self.dy_next="down"
    self.x_pos=ball_x2-paddle_x
    self.y_pos=ball_y-paddle_y2
   end
    
   --vertical
   if near(0.5,
      ball_x,paddle_x2) 
   then
    self.dx_next="right"
    self.x_pos=ball_x-paddle_x
    self.y_pos=ball_y2-paddle_y
   elseif near(0.5,
    ball_x2,paddle_x) 
   then
    self.dx_next="left"
    self.x_pos=paddle_x-ball_x2
    self.y_pos=(ball_y+ball.r)-paddle_y
   end

   _debug_p_pos=
     "("..paddle.x..","..paddle.y..") "..
     "("..paddle_x2..","..paddle_y2..")"
   _debug_b_pos=
     "("..ball.x..","..ball.y..") "..
     "("..ball_x2..","..ball_y2..")"
   _debug_e_pos=
     "("--..self.x_pos..","..self.y_pos..") "
   _debug_d_pos=
     "next:("..
     self.dx_next..","..
     self.dy_next..")"

   return true
  else --no overlap
   --to deprecate
   _col_eng.ball_paddle=false
   return false
  end
 end,
 
 update=function(self)
   local ball= 
     _players["p1"]["ball"]
   local paddle= 
     _players["p1"]["paddle"]

   --upd ball's dx and dy  
   ball.dx, ball.dy = 
     self:upd_dx_dy(ball,paddle)

   _players["p1"]["combo"]=1
 end,
 
 upd_dx_dy=function(self,ball,paddle)
  local new_dx = ball.dx
  local new_dy = ball.dy

  local paddle_x=paddle.x
    
  if self.dy_next=="up" then
   local seg=paddle.w/6
   new_dy=-(abs(new_dy))
   
   if self.x_pos<=seg then
    new_dx=-2
   elseif self.x_pos<=(seg*2) then
    new_dx=-1.5
   elseif self.x_pos<=(seg*3) then
    new_dx=-1
   elseif self.x_pos<=(seg*4) then
    new_dx=1
   elseif self.x_pos<=(seg*5) then
    new_dx=1.5
   else  -- self.x_pos<=(seg*6)
    new_dx=2
   end
   
  elseif self.dy_next=="down" then
   new_dx = -1*(abs(new_dx))
   new_dy= (abs(new_dy))
  -- side hit gives extra speed 
  elseif self.dx_next=="left" then
   new_dx=-2.5
   new_dy=-1*(abs(new_dy))
  elseif self.dx_next=="right" then
   new_dx=2.5
   new_dy=-1*(abs(new_dy))
  end 

  self.dx_next=""
  self.dy_next=""
  return new_dx, next_dy
 end,
  
 to_string=function(self)
   return "ball_paddle_event\n"
    --event:string(self)..
    .." n(x,y):("
    ..tostr(self.dx_next)..","
    ..tostr(self.dy_next)..")"
 end
})

--brick ball event
brick_ball_event=event:new({

 dx_next="",
 dy_next="",

 brick=nil,
 
 eval=function(self)
 
  self.dx_next=""
  self.dy_next=""

  local b= 
    _players["p1"]["ball"]
  local b_y2=b.y+(b.r*2)
  local b_x2=b.x+(b.r*2)
  local bricks = _cur_lvl.grid
  
  for r=1,_cur_lvl.max_row do
	  for c=1,_cur_lvl.max_col do
	   
	   local br = bricks[r][c]
	   
	   if br!= nil and br.visible then
	    local br_x2=br.x+br.w
	    local br_y2=br.y+br.h
	
	    if overlap(0,
	        b.x,b_x2,b.y,b_y2,
	        br.x,br_x2,br.y,br_y2) 
	    then
	
	     local tol=0.5
		    --horizontal
		    if near(tol,b_y2,br.y) then
		     self.dy_next="up"
		     self.x_pos=abs(br.x-(b.x+b.r))
		     self.y_pos=abs(br.y-b_y2)
		    elseif near(tol,b.y,br_y2) then
		     self.dy_next="down"
		     self.x_pos=abs(br.x-(b.x+b.r))
		     self.y_pos=abs(br.y-b.y)
		    end
		     
		    --vertical
		    if near(tol,b.x,br_x2) then
		     self.dx_next="right"
		     self.x_pos=abs(br.x-b.x)
		     self.y_pos=abs(br.y-(b.y+b.r))
		    elseif near(tol,b_x2,br.x) then
		     self.dx_next="left"
		     self.x_pos=abs(br.x-b_x2)
		     self.y_pos=abs(br.y-(b.y+b.r))
		    end
		    
		    self.brick=br
		    return true

		   end --overlap

		  end  --if visible

   end   --for col loop
  end    --for row loop

  return false
 end,

 update=function(self)

  local b= 
    _players["p1"]["ball"]
  b.dx=self:calc_dx(self.brick,b)
  b.dy=self:calc_dy(self.brick,b) 
  
  --brick collision event
  self.brick:on_collision()

  local combo=_players["p1"]["combo"]+1
  _players["p1"]["combo"]=mid(1,combo,7)

  --score
  _players["p1"]["score"]+=5*combo

  if not self.brick.visible then
   _cur_lvl.br_left-=1
  end
 end,

 calc_dx=function(self,br,b)
  if self.dx_next=="left" or
     self.dx_next=="right" then
   return -(b.dx)
  end
  return b.dx
 end,

 calc_dy=function(self,br,b)
  if self.dy_next=="up" or
     self.dy_next=="down" then
   return -(b.dy)
  end
  return b.dy
 end,

 to_string=function(self)
  return "brick_ball_event\n"
   .." "..event:to_string(self).."\n"
   .." n(x,y):("
   ..tostr(self.dx_next)..","
   ..tostr(self.dy_next)..")"
--   .."  br:"..tostr(self.brick) --:to_string()
 end

})

--ball loose
ball_loose_event=event:new({

 eval=function(self)
  local b = _players["p1"]["ball"]
  self.y_pos=b.y
  self.x_pos=b.x
  if b then
   return b.y >= _screen_bot
  end
 end,

 update=function(self)
  sfx(4)
  local lives = 
    _players["p1"]["lives"]
  local b = 
    _players["p1"]["ball"]

  if lives<=0 then
   _state="gameover"
  else
   _players["p1"]["lives"]=lives-1
   b.serve(b)
  end
 end,
 
 to_string=function(self)
  return "ball_loose_event\n"
    .." "..event:to_string(self)
 end

})
-->8
-- collision engine
col_eng = class:new({

 tol = 2,
 
 --collition events type
 event_types = {
   ball_paddle_event,
   ball_loose_event,
   brick_ball_event
 },
 
 events = {},
 
 --to deprecate
 ball_paddle=false,
 
 new=function(self,tbl)
  tbl=class:new(self,tbl)

  for et in all(self.event_types) do
    add(tbl.events, et:new(et))
  end
  return tbl
 end,
 
 init=function(self)
  self.event_types={}
  for et in all(self.event_types) do
    add(self.events, et:new(et))
  end
 end,
 
 -- detects collisions
 -- aka events
 update=function(self) 
   for e in all(self.event_types) do
    if e:eval() then
     e:update()
    end
   end
 end

})
-->8
--levels

-- level definitions
-- items in _lvl_def are
-- a 2d [10][10] array with
-- the brick_type in each cell
_lvl_def = {}

--level1
_lvl_def[1]= {
 {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
 {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
 {nil,nil,nil,nil,brick,brick,nil,nil,nil,nil},
 {nil,nil,nil,brick,brick,brick,brick,nil,nil,nil},
 {nil,nil,brick,brick,brick,brick,brick,brick,nil,nil},
 {nil,nil,shield_brick,shield_brick,shield_brick,shield_brick,shield_brick,shield_brick,nil,nil},
 {nil,nil,brick,brick,brick,brick,brick,brick,nil,nil},
 {nil,nil,nil,brick,brick,brick,brick,nil,nil,nil},
 {nil,nil,nil,nil,brick,brick,nil,nil,nil,nil},
 {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}
}

_lvl_def[2]= {
 {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
 {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
 {shield_brick,shield_brick,shield_brick,shield_brick,shield_brick,shield_brick,shield_brick,shield_brick,shield_brick,shield_brick},
 {brick,brick,brick,brick,brick,brick,brick,brick,brick,brick},
 {brick,brick,brick,brick,brick,brick,brick,brick,brick,brick},
 {brick,brick,brick,brick,brick,brick,brick,brick,brick,brick},
 {brick,brick,brick,brick,brick,brick,brick,brick,brick,brick},
 {brick,brick,brick,brick,brick,brick,brick,brick,brick,brick},
 {brick,brick,brick,brick,brick,brick,brick,brick,brick,brick},
 {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}
}

level=class:new({

 max_row=10,
 max_col=10,
 
 pad_row=2,
 pad_col=2,
 
 br_clrs={8,9,11,12,13},
 grid = {},
 lvl=1,

 br_count=0,
 br_left=0,

 init=function(self,lvl)
  lvl=mid(1,lvl,#_lvl_def)
  local brick_types = _lvl_def[lvl]

  local br_x=_screen_left
  local br_y=_screen_top

  for r=1,self.max_row do
   self.grid[r] = {}
	  br_y+=brick.h+self.pad_row
   br_x=_screen_left
   for c=1,self.max_col do
    local br_type = brick_types[r][c]

    if br_type != nil then
     local br = br_type:new({
       x=br_x, y=br_y})
	    self.grid[r][c]=br
	    self.br_count+=1
	   end
    br_x+=brick.w+self.pad_col

   end
  end
  self.br_left=self.br_count
 end,
 
 __len=function(self)
  return self.br_count
 end,

 on_collision=function(self,r,c,col_func)
  local br=self.grid[r][c]
  if br != nil and br.visible then
   if col_func != nil then
    col_func(self,br)
   else
    br:on_collision()
   end  
  end
 end,

 update=function(self,upd_func)
  for r=1,self.max_row do
   for c=1,self.max_col do
    self:upd_br(r,c,upd_func)
   end
  end
 end,

 upd_br=function(self,r,c,upd_func)
  local br=self.grid[r][c]
  if br != nil and br.visible then
   if upd_func != nil then
    upd_func(self,br)
   else
    br:update()
   end
  end
 end,

 draw=function(self,draw_func)
  for r=1,self.max_row do
   for c=1,self.max_col do
    self:draw_br(r,c,draw_func)
   end
  end
 end,

 draw_br=function(self,r,c,draw_func)
  local br=self.grid[r][c]
  if br != nil then
   if draw_func != nil then
    draw_func(self,br)
   else
    br:draw()
   end
  end
 end

})
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000900090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700009600960000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000060000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000006888600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
4801000019320173201532013320123201032010320103201132015320173201e3201f32000300003000030000300003000030000300003000030000300013000130000300003000030000300003000030000300
000000001002112021140211600117001180311b0311e031230312a0312d031300313103126001250012500131001350013300132001000010000101001020010100100001000010100100001000010000100001
48020000123101331002700293202e3203032014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
000200001954215542135420e54207542005420a5420c5420f5421254215542185421a5421c5421d5421f5422354225542285422b5422e5423054232542345423554236542395423a5423b5423b5423a5423b542
000400001e0501f0501f0501e0501b0501805014050120500f0500d0500905007050040500205001050000500005000050070000c0000e0000c00008000050000400002000020000200002000020000000000000
60020000123101331002700293202e3203032014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
1901000033710377103871039730397300e7000e7000c7000b7003a7003c700077000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010200000e3100f310027001a3201d3202a32014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010200000f31010310027001e320233203032014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010200001031011310027001c3201e3203332014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010200001131012310027001d3201f320343503b3003a3003c3000730000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000000000000
010200001231013310027001e320203203532014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010200001331014310027001e320213203732014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
0102000014310153100270020320223203932014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
