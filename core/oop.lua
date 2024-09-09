class=setmetatable({
	new=function(self,tbl)
		tbl=tbl or {}
		setmetatable(tbl,{
			__index=self
		})
		return tbl
	end,
	init=_noop
},{__index=self})

class.extends=function(self,extension)
	return extend_table(self, extension, true)
end

object = class:new()
object.states = {}
object.states_constraints = {}
object.current_state = nil

object.is_state = function(self, st)
	return self.current_state == st
end

object.state = function(self, new_st)
	if(new_st != nil) then
		if(get(self.states,new_st) != nil) self.current_state = new_st
	end
	return self.current_state
end

object.add_state = function(self, st) 
	if(st != nil) add(self.states, st)
end

object.add_states=function(self, sts)
	for st in all(sts) do self:add_state(st) end
end

object.del_state = function(self, st)
	if(st!=nil) del(self.states, st)
end

object.add_state_constraint=function(self, from, to, allowed)
	if(get(self.states, from) == nil) return false
	if(get(self.states, to) == nil) return false
	if(type(allowed) != 'boolean') return false
	self.state_constraints[from..to] = allowed
end

object.del_state_constraint=function(self,from,to)
	self.state_constraint[from..to]=nil
end

object.check_constraint=function(self, from, to)
	local ch = self.state_constraint[from..to]
	-- absense of constraint == allowed
	if(ch==nil) return true
	return ch
end