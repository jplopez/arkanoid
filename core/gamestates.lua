state_handler=class:new({
  enter=function(self)end,
  exit=function(self)end,
  update=function(self)end,
  draw=function(self)end
})
_gamestates=object:new({
  states=_states,
  states_fn={}
})

function add_gamestate(key,new_state) 
  _gamestates:add_state(key)
  _gamestates.states_fn[key]=new_state 
end
-- if key==nil, returns current state
function gamestate(key)return _gamestates:state(key)end
function upd_gamestate()_gamestates.states_fn[_gamestates:state()]:update()end
function draw_gamestate()_gamestates.states_fn[_gamestates:state()]:draw()end