gst_handler=object:extend({on=_noop,off=_noop,update=_noop,draw=_noop})
_gamestates=object:extend({
  _cur=intro,
  update=function(_ENV)_st[_cur]:update()end,
  draw=function(_ENV)_st[_cur]:draw()end,
})
function gset(key)return _gamestates:set(key)end