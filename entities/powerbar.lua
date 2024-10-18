powerbar=entity:extend({
  x=_screen_left+8,
  y=_screen_bot-5,

  draw=function(_ENV)
    rectfill(x,y,x+(_pwr_max/2),y+6,5)
    local col=11
    if(_pball.power==_pwr_ball) col=10
    if(_pball.power==_pwr_fury) col=8
    rectfill(x,y,x+ceil(_pball.pwr/2),y+6,col)

    if(_pwrbar_increment>1)print("x".._pwrbar_increment,x+(_pwr_max/2)+2,y,_pal_h2)
  end
})