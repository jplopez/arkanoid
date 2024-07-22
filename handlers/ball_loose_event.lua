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
 