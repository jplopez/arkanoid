--game state machine for the main pico8 cycle
gamestate = class:new({

  enter=function(self) end,

  exit=function(self) end,

  update=function(self) end,

  draw=function(self)  end

})

_gamestates = { }

function add_gamestate(key, new_state, allowed_transitions) 
  if(key==nil or new_state == nil) return false
  _gamestates = _gamestates or {}
  allowed_transitions = allowed_transitions or {}

  _gamestates[key] = {
    state = new_state,
    allow = allowed_transitions
  }
end

function current_gamestate() 
  local current_key = _gamestates["current"] 
  return _gamestates[current_key]["state"]
end

function set_default(key) 
  local default_state = _gamestates[key]
  if(default_state == nil) return false
  _gamestates["default"] = key
  if(_gamestates["current"] == nil) then
    _gamestates["current"] = key
  end
  return true
end

function set_gamestate(key) 
  if(key == nil) return false

  current_key = _gamestates["current"]
  current_key = current_key or _gamestates["default"]
  if(current_key == nil) return false
   
  current_state = _gamestates[current_key]
  
  if(allowed_transition(current_state, key)) then
    new_state = _gamestates[key]
    if(new_state == nil) return false

    _gamestates["current"] = key

    current_state["state"]:exit()
    new_state["state"]:enter()
    return true
  end
  return false

end

function allowed_transition(from_state, to_key) 
  for allow in all(from_state["allow"]) do
    if(allow == to_key) return true
  end
  return false
end