
dialog=object:extend({

  open=false,
  printer=printer(),

  x0=10,
  y0=10,
  x1=118,
  y1=118,
  bgcol=15,
  border=true,
  bclr=0,
  tclr=0,

  inputs={
    close=❎,
  },

  p=function(_ENV, str,...)printer:p(str,...)end,

  input=function(_ENV) 
    if btnp(inputs.close) open=false 
  end,

  rawupdate=function(_ENV)inputs(_ENV)end,
  update=function(_ENV)rawupdate(_ENV)end,

  rawdraw=function(_ENV)rectfill(x0,y0,x1,y1,bgcol)p(_ENV,inputs.close.." close",'left','bottom',tclr)end,
  draw=function(_ENV)rawdraw(_ENV)end,

})