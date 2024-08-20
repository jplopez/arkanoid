brick_collision_handler = collision_handler:new({

  handle = function(self, ball, grid)
    if ball:is_state("sticky") then
      return false
    end

    --obtain vecinity of bricks potentially hit
    local first_col, first_row, last_col, last_row =
        self:get_near_bricks(ball, grid)

    -- composite block tracking all hit bricks    
    local brick_block = composite_brick:new()

    -- loop through vecinity in search of 
    -- bricks colliding with ball
    for r = first_row, last_row do
      for c = first_col, last_col do
        local br = _cur_lvl.grid[r][c]
        if(br==nil) then
          log("["..r..","..c.."] NIL")
        elseif br:visible() then
--        if(br!=nil and br:visible()) then
          if(collision_engine:is_circle_rect_colliding(ball, br)) then
            log("["..r..","..c.."] COL")
            brick_block = brick_block:union(br)
          else
            log("["..r..","..c.."] OOR")
          end
        else 
          log("["..r..","..c.."] HID")
        end
      end
    end

    --TODO 
    -- Apply constraints by checking existing blocks
    -- next to the brick_block
    -- this will prevent corner bounces for
    -- bricks who have another brick next to it
  
    if(#brick_block.bricks > 0) then
      self:handle_brick_block(ball, brick_block)
    end
  end,

  handle_brick_block=function(self,ball,brick_block)
      log("is_circle_rect_collision_side")
      log("ball(x,y) ("..ball.x..","..ball.y..")")
      log("bb  (x,y,w,h) ("..brick_block.x..","..
          brick_block.y..","..
          brick_block.w..","..
          brick_block.h..")")
  
      local col, side = collision_engine:is_circle_rect_collision_side(ball, brick_block)
      if col then
        log("bb col side :".. print_side(side))
        brick_block:on_collision()
        log("bb hidden ".. brick_block:hidden_count())
        _cur_lvl.br_left -= brick_block:hidden_count()
        ball.pwr+=#brick_block.bricks
        self:ball_direction(ball, side) 
      end  
  
  end,

  ball_direction=function(self, ball, side)
   log("ball direction side: "..print_side(side))
   log("ball pre (dx,dy)=("..ball.dx..","..ball.dy..")")
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
  end
})
