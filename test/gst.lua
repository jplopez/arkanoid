

function gsttest()
  _gstc = {cur=nil}
  print("\n=== gst() test ===\n")
  print("gst()==nil -> true : ")
  print(tostr(gst()==nil))
  print("gst('start')->'start':")
  print(gst('start'))
  print("gst()=='start'->true : ")
  print(tostr(gst()=='start'))
  print("gst('over')->'over'")
  print(gst('over'))
  print("gst()->'over' : ")
  print(gst())
  print("gst()=='start'->false : ")
  print(tostr(gst()=='start'))
end

function gstttest()
  _gstc = {cur=nil}
  local f = function()end
  print("\n=== gstt() test ===\n")
  print("gstt()==nil : ")
  print(tostr(gstt()==nil))
  print("gstt('start', f, f)->'start' : ")
  print(gstt('start',f,f))
  print("gstt('over', f, f)->'over'")
  print(gstt('over',f,f))

end

function trtest1()
  _gstc = {cur=nil}

  print("\n=== gstt() triggers test ===\n")
  print("on_fn=print(state .. 'on')")
  print("off_fn=print(state .. 'off')")

  local on_fn = function(off, on) print(on .. " on") end
  local off_fn = function(off,on) print(off.. " off") end

  print("gstt('start',on_fn,off_fn)->p('start on')->'start':")
  print(gstt('start',on_fn,off_fn))
  print("gstt('over',on_fn,off_fn)->p('start off')->p('over on')->'over':")
  print(gstt('over',on_fn,off_fn))
  print("gst('start')->p('over off')->p('start on')->'start':") 
  print(gst('start'))
  print("gst('over')->p('start off')->p('over on')->'over':") 
  print(gst('over'))

end

function trtest2()
  _gstc = {cur=nil}
  local f = function()end
  print("\n=== gstt() triggers test 2 ===\n")
  local on_fn = function(off, on) print(on .. " on") end
  local off_fn = function(off,on) print(off.. " off") end
  print("gstt('start',on_fn,off_fn)->p('start on'):")
  print("gstt('over',on_fn,off_fn)->p('start off')->p('over on'):")
  gstt('start',on_fn,off_fn)
  gstt('over',on_fn,off_fn)
  print("gst('start')->p('over off')->p('start on')->'start':") 
  print(gst('start'))
  print("gstt('over',f,f)->p('start off')->'over':") 
  print(gstt('over',f,f))

end


-- function gsttest2() 
--   _gstc = { cur=""}
--   local on_fn = function(off, on) print(on .. " on") end
--   local off_fn = function(off,on) print(off.. " off") end
--   local start,over=1,0

--   print("gstt(start,on_fn,off_fn)->p('1 on')->1:")
--   print(gstt(start,on_fn,off_fn))
--   print("gstt(over,on_fn,off_fn)->p('1 off')->p('0 on')->0:")
--   print(gstt(over,on_fn,off_fn))
  
--   --if(lives==0) gst(over)
--   --if(gst()==over) print("gameover")
-- end

-- function gstif(cond,t,f)
--   return(cond) and gst(t)or((f) and gst(f) or false)
-- end

-- function isgst(key) return gst()==key end

-- function gsttest3() 
--   _gstc={cur=""}
--   local on_fn = function(off, on) print(on .. " on") end
--   local off_fn = function(off,on) print(off.. " off") end
--   local start,over=1,0

--   print("gstt(start,on_fn,off_fn)->p('1 on')->1:")
--   print(gstt(start,on_fn,off_fn))
--   print("gstt(over,on_fn,off_fn)->p('1 off')->p('0 on')->0:")
--   print(gstt(over,on_fn,off_fn))

--   gst(start)
--   local lives=1
--   print("gstif(lives==0,over)->1:")
--   print(gstif(lives==0,over))
--   print("isgst(over)->false:")
--   print(tostr(isgst(over)))

--   lives = 0
--   print("gstif(lives==0,over)->p('1 off')->p('0 on')->0:")
--   print(gstif(lives==0,over))
--   print("isgst(over)->true:")
-- end
