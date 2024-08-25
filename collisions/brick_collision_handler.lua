brick_collision_handler = collision_handler:new({

  handle = function(self, ball, grid)
    -- log("brick collision handle")
    if ball:is_state("sticky") then
      return false
    end

    --obtain vecinity of bricks potentially hit
    local first_col, first_row, last_col, last_row =
        self:get_near_bricks(ball, grid)
    -- log("near " .. tostr((last_row-first_row+1)*(last_col-first_col+1)) .. " bricks at [" .. first_row .. "," .. first_col .. "]:[" .. last_row .. "," .. last_col .. "]")
    -- composite block tracking all hit bricks    
    local brick_block = composite_brick:new()

    local log_sep = " | "
    local log_head = "    | "
    local logstr   =  ""

    for r = first_row, last_row do
      logstr = logstr .. pad(r,3) .. log_sep 
      for c = first_col, last_col do

        local log_c = ""
        if(r==first_row) log_head = log_head .. pad(c, 3) .. log_sep

        local br = _cur_lvl.grid[r][c]
        if(br==nil) then

          log_c = "NIL"

        elseif br:is_state("visible") then
          --if(br!=nil and br:visible()) then
          local col, side = collision_engine:is_circle_rect_colliding(ball, br)
          if(col) then

            log_c = "COL"
            brick_block = brick_block:union(br)

          else
            log_c = "OOB"
            brick_block = brick_block:union(br, true)

          end
        else 
          log_c = "HID"
        end

        logstr = logstr .. log_c .. log_sep
        if(c==last_col) logstr = logstr .. "\n"

      end -- end for cols
    end -- end for rows

    -- log(log_head)
    -- log(logstr)
    -- log("hit? " .. tostr(#brick_block.bricks > 0) .. " bricks: " .. tostr(#brick_block.bricks))

    if(#brick_block.bricks > 0) then
      self:handle_brick_block(ball, brick_block)
    end
  end,

  handle_brick_block=function(self,ball,brick_block)
      log("handle_brick_block")
      -- log("   ball(x,y) ("..ball.x..","..ball.y..")")
      -- log("   bb  (x,y,w,h) ("..brick_block.x..","..
      --     brick_block.y..","..
      --     brick_block.w..","..
      --     brick_block.h..")")
  
      local col, side = collision_engine:is_circle_rect_collision_side(ball, brick_block)
      if col then
        log("   bb col side :".. print_side(side))
        brick_block:on_collision()
        log("   bb hit count ".. brick_block:hidden_count())
        _cur_lvl.br_left -= brick_block:hidden_count()
        self:ball_direction(ball, side) 
      end  
  
  end,

  ball_direction=function(self, ball, side)
   log("ball direction side: "..print_side(side))
   log("   ball pre (dx,dy)=("..ball.dx..","..ball.dy..")")
    if(side == nil) then
      ball.dy*=-1
      ball.dx*=-1
    end 

    if(side == _top_left or side == _top_right or side==_top) then
      if ball.dy > 0 then
        ball.dy*=-1
      end
    end

    if(side == _bottom_left or side == _bottom_right or side==_bottom) then
      if ball.dy < 0 then
        ball.dy*=-1
      end
    end

    if(side == _top_left or side == _bottom_left or side==_left) then
      if ball.dx > 0 then
        ball.dx*=-1
      end
    end

    if(side == _top_right or side == _bottom_right or side==_right) then
      if ball.dx < 0 then
        ball.dx*=-1
      end
    end

--    log("ball post (dx,dy)=("..ball.dx..","..ball.dy..")")

  end,

  get_near_bricks=function(self, ball, grid)
    local col_w = level.pad_col + brick.w
    local row_h = level.pad_row + brick.h
    
    local first_col = flr((ball.x-ball.r-grid.x)/col_w) 
    local last_col = ceil((ball.x+ball.r-grid.x)/col_w) 
    local first_row = flr((ball.y-ball.r-grid.y)/row_h) 
    local last_row = ceil((ball.y+ball.r-grid.y)/row_h) 
    return mid(1, first_col, _max_cols), 
            mid(1, first_row, _max_rows),
            mid(1, last_col, _max_cols),
            mid(1, last_row, _max_rows)
  end,

  vecinity=function(self, br, r, c, side, grid)
    log("vecinity (r,c):(" .. r .."," .. c ..") side: "..print_side(side))

    v = {}
    if(side == nil) return v
 
    if((side == _top_left or side == _bottom_left) and c>1) add(v, grid[r][c-1])
    if((side == _top_right or side == _bottom_right) and c<_max_cols) add(v, grid[r][c+1])
       
    if((side == _top_left or side == _top_right) and r>1) add(v, grid[r-1][c])
    if((side == _bottom_left or side == _bottom_right) and r<_max_rows) add(v, grid[r+1][c])
  
    log2(v)
    return v
  end
})
