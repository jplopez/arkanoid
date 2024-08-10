

empty_fn = function() end

--[[
  Adds the state 'state' and  
  the following functions:
    - is_<state> : boolean
    Optional
    - on_<state> : triggered when 'base' 
      enters 'state'
    - off_<state>: triggered when 'base' 
      exits 'state'

  If this the first state added to 'base' this 
  method will also add the fields 'states' with all
  the valid states for 'base' and the field 'state'
  to hold the current state.
  'add_state' assumes base is a table and is not nil
]]
function add_state(base, state, on_fn, off_fn)
 
  if(base.states == nil) then init_states(base) end

  base.states[state] = {
      val = state,
      on_fn = on_fn or empty_fn,
      off_fn = off_fn or empty_fn
  }
end

--[[
  Adds all states listed in 'states' to 'base'
  For each state adds the following methods
    - is_<state> : boolean
  
  Optionally, if 'on_fn' and 'off_fn' are defined, 
  the following methods are added to 'base':
    - on_<state> : triggered when 'base' 
      enters 'state'
    - off_<state>: triggered when 'base' 
      exits 'state'

  If 'on_fn' and 'off_fn' are functions, 
    all states will share the same function
  If 'on_fn' and 'off_fn' are arrays, each
  state will have functions in the same index 
  are found in 'states'

]]
function add_states(base, states, on_fn, off_fn)
  
  if(base.states == nil) then init_states(base) end

  for i=1,#states do 
    local cur_state = states[i]
    local cur_on_fn = nil
    local cur_off_fn = nil

    if (on_fn ~= nil and type(on_fn) == 'table') then 
      cur_on_fn = on_fn[i]
    elseif (type(on_fn) == "function") then
      cur_on_fn = on_fn
    end

    if (off_fn ~= nil and type(off_fn) == 'table') then 
      cur_off_fn = off_fn[i]
    elseif (type(off_fn) == "function") then
      cur_off_fn = off_fn
    end
    add_state(base, cur_state, cur_on_fn, cur_off_fn)
  end
end

function init_states(base)
  base.states = {}
  base.states["current"] = nil

  base.is_state = function(self, st)
        return self.states["current"] == st
      end

  base.state = function(self, new_state, skip_triggers)
        --validate new_state exists in object
        if (self.states[new_state] == nil) then 
          return false 
        end

        --change to new_state
        local old_state = self.states["current"]
        self.states["current"] = new_state

        if skip_triggers then 
          return true 
        end

          -- execute triggers
        local old = self.states[old_state]
        local new = self.states[new_state]
        if(old != nil and old.off_fn) old.off_fn(self)
        if(new.on_fn)  new.on_fn(self)
    end   
end
