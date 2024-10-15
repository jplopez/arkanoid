-- source: https://github.com/kevinthompson/object-oriented-pico-8/blob/main/heartseeker.p8#L293
-- author: https://github.com/kevinthompson 
class2=setmetatable({
  extend=function(self,tbl)
    tbl=tbl or {}
    tbl.__index=tbl
    return setmetatable(
      tbl,{__index=self,__call=function(self,...)
        return self:new(...)end})
  end,
  new=function(self,tbl)tbl=setmetatable(tbl or {},self)tbl:init()return tbl end,
  init=_noop
},{__index=_ENV})

entity=class2:extend({
	-- class
	pool={},
	-- instance
	x=0,
	y=0,
	w=8,
	h=8,

	extend=function(_ENV,tbl)tbl=class2.extend(_ENV,tbl)tbl.pool={}return tbl	end,
	each=function(_ENV,method,...)for e in all(pool)do if(e[method])e[method](e,...)end end,
	init=function(_ENV)add(entity.pool,_ENV) if(pool!=entity.pool)add(pool,_ENV)end,
	detect=function(_ENV,other,callback)if(collide(_ENV,other)) callback(_ENV)end,
	destroy=function(_ENV)del(entity.pool,_ENV)if(pool!=entity.pool)del(pool,_ENV)end,
	collide=function(_ENV,other)
		return x<other.x+other.w and
			x+w>other.x and
			y<other.y+other.h and
			h+y>other.y
	end,

	_st={}, -- state container
	_cur=nil,
	sett=function(_ENV,k,on,off)
		if(k!=nil) then
			--local f=function()end
			_st[k]=_st[k]or{key=k,on=_noop,off=_noop}
			if(on)_st[k].on=on 
			if(off)_st[k].off=off 
			local o=_cur
			if(_st[o] and _st[o].off)_st[o].off(o,k)
			_cur=k
			if(_st[k].on)_st[k].on(o,k)
		end
		return _cur
	end,
	set=function(_ENV,k)return sett(_ENV,k)end,
	is=function(_ENV,k)return _cur==k end,
})


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

object=class:new()
object.states={}
-- object.states_constraints={}
object.current_state = nil

object.is_state=function(self,st)return self.current_state==st end

object.state = function(self,new_st)
	if(new_st!=nil and get(self.states,new_st)!=nil) self.current_state=new_st
	return self.current_state
end

object.add_state = function(self,st) if(st!=nil)add(self.states,st)end

object.add_states=function(self, sts)	for st in all(sts) do self:add_state(st) end end

-- object.del_state = function(self, st)
-- 	if(st!=nil) del(self.states, st)
-- end

-- object.add_state_constraint=function(self, from, to, allowed)
-- 	if(get(self.states, from) == nil) return false
-- 	if(get(self.states, to) == nil) return false
-- 	if(type(allowed) != 'boolean') return false
-- 	self.state_constraints[from..to] = allowed
-- end

-- object.del_state_constraint=function(self,from,to)
-- 	self.state_constraint[from..to]=nil
-- end

-- object.check_constraint=function(self, from, to)
-- 	local ch = self.state_constraint[from..to]
-- 	-- absense of constraint == allowed
-- 	if(ch==nil) return true
-- 	return ch
-- end