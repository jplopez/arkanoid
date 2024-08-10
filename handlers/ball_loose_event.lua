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
  --  sfx(4)
  --  local lives = 
  --    _players["p1"]["lives"]
  --  local b = 
  --    _players["p1"]["ball"]
 
  --  if lives<=0 then
  --   _state="gameover"
  --  else
  --   _players["p1"]["lives"]=lives-1
  --   b.serve(b)
  --  end
  end,
  
  to_string=function(self)
   return "ball_loose_event\n"
     .." "..event:to_string(self)
  end
 
 })
