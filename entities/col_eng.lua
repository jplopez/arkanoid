-- collision engine
col_eng = class:new({

  tol = 0.8,
  
  --collition events type
  event_types = {
    ball_paddle_event,
    ball_loose_event,
    brick_ball_event
    --powerup_event
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
 