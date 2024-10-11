br_handler = collision_handler:new({

  handle = function(self, b, grid, side)
    if(b:is_state("sticky")) return false

    --obtain vecinity of bricks potentially hit
    local first_col, first_row, last_col, last_row =
        self:near_bricks(b, grid)
    local brick_block = composite_brick()
    
    -- local log_sep = " | "
    -- local log_head = "    | "
    -- local logstr   =  ""

    for r = first_row, last_row do
      -- logstr = logstr .. pad(r,3) .. log_sep 
      for c = first_col, last_col do
        -- local log_c = ""
        -- if(r==first_row) log_head = log_head .. pad(c, 3) .. log_sep
        local br = _lvl.grid[r][c]
        if(br==nil) then
          -- log_c = "NIL"
        elseif br:is_state("visible") then
          --if(br!=nil and br:visible()) then
          local col = collision_engine:is_circle_rect_colliding(b, br)
          if(col) then
            -- log_c = "COL"
            brick_block = brick_block:union(br, false)
          else
            -- log_c = "OOB"
            brick_block = brick_block:union(br, true)
          end
        else 
          -- log_c = "HID"
        end
        -- logstr = logstr .. log_c .. log_sep
        -- if(c==last_col) logstr = logstr .. "\n"
      end -- end for cols
    end -- end for rows
    --log("hit? " .. tostr(#brick_block.bricks > 0) .. " bricks: " .. tostr(#brick_block.bricks))
    if(#brick_block.bricks > 0) then 
      -- log(log_head)
      -- log(logstr)
      self:handle_brick_block(b, brick_block)
    end
  end,

  handle_brick_block=function(self,b,brick_block)
    local col, s = collision_engine:is_circle_rect_colliding(b, brick_block)
    if col then
      local hit_c = brick_block:on_collision(b)
      _lvl.br_left -= hit_c
      self:ball_dir(b, s) 
      --powerup
      if(hit_c>0) self:pup(brick_block.x, brick_block.y)
    end  
  end,

  pup=function(self,pup_x,pup_y)
    if(_pup_cooldown==0) then
      local pup_id = pup_gatcha_pull()
      if(pup_id) then 
        local pup = powerup:new({s=pup_id, 
          x=pup_x,
          y=pup_y
        })
        pup:state("visible")
        pup_cd_reset()
        add(_pups, pup)
      end
    end
  end,

  ball_dir=function(self, b, s)
    -- log("b direction s: "..print_side(s))
    -- log("   b pre (dx,dy)=("..b.dx..","..b.dy..")")
    if(b:power()==_pwr_fury) return false
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
