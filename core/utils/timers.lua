-- timers
timer=class:new({

    elapsed=0,
    fr=30,
    length=30, -- 30 frames, aka one second
    active=false,
    step_fn=nil,
    end_fn=nil,
    last_time=0,
     
    new=function(self,length,step_fn,end_fn)
     local tbl = class.new(self)
     tbl.length=length
     tbl.active=false
     tbl.step_fn=step_fn
     tbl.end_fn=end_fn
     tbl.last_time=0
     return tbl
    end,
    
    new60=function(self, length, 
      step_fn, end_fn)
     local tbl= timer.new(self, length,
        step_fn, end_fn)
     tbl.fr=60
     return tbl
    end,
    
    init=function(self)
     self.last_time=0
    end,
     
    update=function(self)
     self.last_time=elapsed
     
     if self.active then
      self.elapsed+=1
      local elapsed=self.elapsed
      local length=self.length
   
      if elapsed < length then
       if self.step_fn then
        self:step_fn(elapsed,length)
       end
      else
       self.active=false
       if self.end_fn then
        self:end_fn(elapsed,length) 
       end
      end
   
     end
    end,
    
    pause=function(self)
     self.active=false
    end,
    
    resume=function(self)
     self.active=true
    end,
   
    restart=function(self)
     self.elapsed=0
     self.active=true
    end 
})
   