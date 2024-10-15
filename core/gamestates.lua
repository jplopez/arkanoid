gst_handler=class2:extend({on=_noop,off=_noop,update=_noop,draw=_noop})
_gamestates=entity:extend({
  _cur=intro,
  update=function(_ENV)_st[_cur]:update()end,
  draw=function(_ENV)_st[_cur]:draw()end,
})
function gset(key)return _gamestates:set(key)end