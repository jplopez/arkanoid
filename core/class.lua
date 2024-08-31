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
