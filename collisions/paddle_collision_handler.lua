
paddle_ball_collision_handler = collision_handler:new({

  -- ball acceleration every time the ball 
  -- hits the paddle.
  ball_acc = 0.7,

  handle=function(self, ball, paddle)

    --paddle resets current combo
    _players["p1"]["combo"]=1

    local top_dist = abs(paddle.y - (ball.y+ball.r))
    local bot_dist = abs((ball.y-ball.r) - (paddle.y+paddle.h))
    local left_dist = abs(paddle.x - (ball.x+ball.r))
    local right_dist = abs((ball.x-ball.r) - (paddle.y+paddle.w))
    min_dist = min(top_dist, bot_dist, left_dist, right_dist)

    --log("paddle ball dists min:"..min_dist)
    --log("top, bot, left, right "..
    --  top_dist..","..bot_dist..","..left_dist..","..right_dist)
    
    if top_dist == min_dist then 
      --flip DY to up, calc new DX
      self:handle_top_bounce(ball, paddle)
    elseif bot_dist == min_dist then
      ball.dy = abs(ball.dy)--flip DY to down
    end

    if left_dist == min_dist then
      ball.dx = -2.5
      ball.dy = -abs(ball.dy) 
      --flip both DX and Dy, wide angle and more speed
    elseif right_dist == min_dist then
      ball.dx = -2.5
      ball.dy = -abs(ball.dy) 
    end

    ball.pwr-=2
  end,

  handle_top_bounce=function(self, ball, paddle)

    log("\n\npaddle bounce: ball(dx,dy)=("..ball.dx..","..ball.dy..")")
    local x_pos = flr(ball.x-paddle.x)
    local seg = flr(paddle.w / 6)
    --log("x_pos "..x_pos.." seg "..seg)
    local dy_f = self.ball_acc
    log("x_pos "..x_pos)
    log("total seg "..seg)

    ball.dy = -(abs(ball.dy) + rnd(dy_f*0.05))
    log("new dy "..ball.dy)
    for i=1,6 do
      if (x_pos <= i*seg and x_pos > (i-1)*seg) then
        if i <= 3 then
          ball.dx = -((4-i)*dy_f)
        else
          ball.dx = (i-3)*dy_f
        end
        log("seg "..i.." new dx:"..ball.dx)
      end
    end

  end
})