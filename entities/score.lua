score = class:new({
  x = 0,
  y = 0,
  clr = 0,

  h = 0, --hundreds
  t = 0, --thousands
  m = 0, --millions

  update = function(self) end,
  draw = function(self) end,
  add = function(self, n) end,

  eq = function(self, n) end,
  gt = function(self, n) end,

  tonum=function(self) end,

  tostr = function(self) 
    return pad(tostr(m),3) .. pad(tostr(t),3) .. pad(tostr(h),3)
  end
})