--
-- Usage example
-- prnt = printer({outline=true, outline_clr=8})
-- prnt:p("hola", 0, 0)
-- prnt:p("hola",'left',0)
-- prnt:p("hola",'left','top')
--
-- o2 = printer({h_align=printer.left, outline=true, outline_clr=8})
-- o2:p("hola",)
printer=class2:extend({

  --align constants
  left='left',
  center=-'center',
  right='right',
  top='top',
  middle='middle',
  bottom='bottom',

  outline=false,
  outline_clr=8,
  shadow=false,
  shadow_clr=8,
  clr=0,

  lpad=function(_ENV,str,pad) end,
  rpad=function(_ENV,str,pad) end,

  p=function(_ENV,str,_x,_y,_clr)
    local hconst,vconst={left,center,right},{top,middle,bottom}
    assert(type(_x)=='number' or one_of(hconst,_x),"invalid value for x pos")
    assert(type(_y)=='number' or one_of(vconst,_y),"invalid value for y pos")
    _x=_x or eval_x(_ENV,str,_x)
    _y=_y or eval_y(_ENV,str,_y)
    _clr=_clr or clr
    if(outline) return prnto(_ENV,str,_x,_y,_clr,outline_clr)
    if(shadow) return prnts(_ENV,str,_x,_y,_clr,shadow_clr)
    print(str, _x, _y,_clr)
  end,

  eval_x=function(_ENV,str,_x)
    if(_x==left)return 0
    if(_x==right)return max(0,127-(#str*3))
    if(_x==center)return 64-flr(#str/2)
    return _x
  end,

  eval_y=function(_ENV,str,_y)
    if(_y==top)return 0
    if(_y==bottom)return 119
    if(_y==middle)return 60
    return _y
  end,

  prnto=function(_ENV,str,_x,_y,clr,oclr)
    color(oclr)
    ?'\-f'..str..'\^g\-h'..str..'\^g\|f'..str..'\^g\|h'..str,_x,_y
    ?str,_x,_y,clr
  end,

  prnts=function(_ENV,str,_x,_y,clr,sclr)print(str,_x+1,_y+1,sclr)print(str,_x,_y,clr)end,
})