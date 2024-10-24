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

-- adds life cycle, update/draw and state machine
object=class2:extend({
	-- class
	pool={},

	update=_noop,
	draw=_noop,

	extend=function(_ENV,tbl)tbl=class2.extend(_ENV,tbl)tbl.pool={}return tbl	end,
	each=function(_ENV,method,...)for e in all(pool)do if(e[method])e[method](e,...)end end,
	init=function(_ENV)add(entity.pool,_ENV) if(pool!=entity.pool)add(pool,_ENV)end,
	destroy=function(_ENV)del(entity.pool,_ENV)if(pool!=entity.pool)del(pool,_ENV)end,

	_st={}, -- state container
	_cur=nil,
	sett=function(_ENV,k,on,off)
		if(k!=nil) then
			--local f=function()end
			_st[k]=_st[k]or{key=k,on=_noop,off=_noop}
			if(on)_st[k].on=on 
			if(off)_st[k].off=off 
			local o=_cur
			if(_st[o] and _st[o].off)_st[o]:off(o,k)
			_cur=k
			if(_st[k].on)_st[k]:on(o,k)
		end
		return _cur
	end,
	set=function(_ENV,k)return sett(_ENV,k)end,
	is=function(_ENV,k)return _cur==k end,

})

-- adds collision detection
-- TODO: basic anim or movement
entity=object:extend({
	-- instance
	x=0,
	y=0,
	-- w=8,
	-- h=8,
	col_side=nil,

	on_collision=function(_ENV,other,side) end,

	detect=function(_ENV,other,callback)
		callback=callback or on_collision
		local col,side=collide(_ENV,other)
		if(col)then
			col_side=side
			callback(_ENV,other,side)
		end 
	end,

	collide=function(_ENV,other) return collision_engine:collide(_ENV,other) end,
})

