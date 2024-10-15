br_handler=collision_handler:new({
  handle=function(self,b,grid,side)
    if(b:is(sticky))return false
    --obtain vecinity of bricks potentially hit
    local first_col,first_row,last_col,last_row=
        self:near_bricks(b,grid)
    local hit_block=composite_brick(_ENV)
    -- check bricks colliding in the vecinity
    for r=first_row,last_row do
      for c=first_col,last_col do
        local br=_lvl.grid[r][c]
        if(br~=nil and br:is(visible))then
          local col=collision_engine:is_circle_rect_colliding(b,br)
          hit_block:union(br,(not col))
        end
      end -- end for cols
    end -- end for rows
    if(#hit_block.bricks>0)self:handle_hit_block(b,hit_block)
  end,

handle_hit_block=function(self,b,hit_block)
    local col,s=collision_engine:is_circle_rect_colliding(b,hit_block)
    if col then
      local hit_c=hit_block:on_collision(b)
      _lvl.br_left-=hit_c
      self:ball_dir(b,s) 
      --powerup
      if(hit_c>0)self:pup(hit_block.x,hit_block.y)
    end  
  end,

  pup=function(self,pup_x,pup_y)
    if(_pup_cooldown==0) then
      local pup_id=pup_gatcha_pull()
      if(pup_id)then 
        local pup=powerup({s=pup_id, 
          x=pup_x,y=pup_y })
        --pup:state("visible")
        pup_cd_reset()
        add(_pups,pup)
      end
    end
  end,

  ball_dir=function(self,b,s)
    if(b.power==_pwr_fury) return false
    if(s==nil) then
      b.dy*=-1
      b.dx*=-1
    end 
    if((s==_top_left or s==_top_right or s==_top)and(b.dy>0)) b.dy*=-1
    if((s==_bottom_left or s==_bottom_right or s==_bottom)and(b.dy<0)) b.dy*=-1
    if((s==_top_left or s==_bottom_left or s==_left)and(b.dx>0)) b.dx*=-1
    if((s==_top_right or s==_bottom_right or s==_right)and(b.dx<0)) b.dx*=-1
--    log("b post (dx,dy)=("..b.dx..","..b.dy..")")
  end,

  near_bricks=function(self, b, grid)
    local col_w = brick.w
    local row_h = brick.h
    
    local first_col = flr((b.x-b.r-grid.x)/col_w) 
    local last_col = ceil((b.x+b.r-grid.x)/col_w) 
    local first_row = flr((b.y-b.r-grid.y)/row_h) 
    local last_row = ceil((b.y+b.r-grid.y)/row_h) 
    return mid(1, first_col, _max_cols), 
            mid(1, first_row, _max_rows),
            mid(1, last_col, _max_cols),
            mid(1, last_row, _max_rows)
  end
})
