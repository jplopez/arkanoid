-- base event object
event = class:new({
  x_pos=0,
  y_pos=0,
  
  -- eval if event occurred
  -- check is executed at the 
  -- update method, before 
  -- anything else
  eval=noop,
 
  -- applies the changes 
  -- triggered by the event
  update=noop,
  
  to_string=function(self)
   return " (x,y):("
     ..self.x_pos..","
     ..self.y_pos..")"
  end
 })
 