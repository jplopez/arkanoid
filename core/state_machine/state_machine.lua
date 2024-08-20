function init_state_machine(sm, c)
  sm = sm or __sm__
  sm:init_states(c)
end

--[[
  Adds 'st' to the state machine. If 'st' exists already, this
  function will override it.
  - Parameters
    - st : state key. Usually a string or number
    - sh : state handler. A table with functions supported by the state
      Supported state handler functions:
        update
        draw
        enter
        exit
]]
function add_state(st, sh)
  __sm__:add_state(st, sh)
end

--[[
  Removes 'st' from the state machine
  If 'st' isn't present, this function does nothing

  Returns boolean. True if a state was deleted. False otherwise
]]
function del_state(st)
  return __sm__:del_state(st)
end

--[[
  define a valid transition between 'from' and 'to' states
  
]]
function state_transition(from, to)
  return __sm__:state_transition(from, to)
end

--[[
  Returns the state handler for the current state. 
  The available methods are defined during the 'add_state' call
]]
function current_state()
  return __sm__.state_container[__sm__.current_state]
end

--[[
  Set the state to 'st'. If successful, returns the 'st'. nil otherwise
  If 'st' is nil, this method returns the current state 

  Returns the key of the new state. The current state otherwise.
]]
function state(st)
  if(st==nil) return __sm__.current_state
  if(__sm__:state(st)) return st
end

--[[
  Returns true if the current state has the key 'st'.
  False otherwise.
]]
function is_state(st)
  return __sm__.current_state == st
end

--[[
  Returns an array with all the states added so far. 
  This only returns the state keys, not the handlers
]]
function all_states()
  return __sm__:all_states()
end

__sm__ = setmetatable(
  {
    new = function(self, tbl)
      tbl = tbl or {}

      setmetatable(tbl, {
        __index = self  })

      return tbl
    end,

    init = function() end
  }, { __index = self }
)

__sm__.init_states = function(base, c)
  base.state_container = c or {}
  base.current_state = nil

  base.is_state = function(self, st)
    return self.current_state == st
  end

  base.state = function(base, new_st)
    -- execute triggers
    local new = base.state_container[new_st]
    local old = base.state_container[base.current_state]
    --validate new_state exists in object
    if(new == nil) return false    

    if (old != nil and old.exit) old.exit(base)
    base.current_state = new_st
    if (new.enter) new.enter(base)
    return true
  end

  base.add_state = function(base, st, sh) 
    if(st != nil) then 
      sh = sh or {}
      sh["key"] = st 
      base.state_container[st] = sh
    end
  end
  
  base.del_state = function(base, st)
    if(st!=nil and base.state_container[st]) then
      base.state_container[st] = nil
    end
  end
  
  base.state_transition = function(base, from, to)
  
    if(base.state_container[from] == nil) return false
    if(base.state_container[to] == nil) return false
  
    allow = base.state_container[from]["allow_to"]
    -- if there are no transitions defined,
    --  we assume all transitions are allowed
    if(allow == nil) return true
  
    for a in all(allow) do
      if (a==to) return false
    end
    add(allow, to)
    return true
  end
  
  base.all_states = function(base)
    local keys = {}
    for k,v in pairs(base.state_container) do
      add(keys, k)
    end
    return keys
  end

end