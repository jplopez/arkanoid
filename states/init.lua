-- init
function init_gamestates()
    add_gamestate("start", start_gamestate)
    add_gamestate("game", game_gamestate)
    add_gamestate("gameover", gameover_gamestate)
    add_gamestate("levelup", levelup_gamestate)
    gamestate("start")
end

function init_players()
    _pball = ball:new()
    _ppaddle = paddle:new()

    --power bar
    _ppwrbar = powerbar:new()
    _ppwrbar.bars=0
    _pscore = 0
    _plevel = 1
    _plives = 3
    _pserves = 99
end

function init_objects()
    _lvl = level:new()-- current level
    init_collisions() --collision engine
    init_bonus()      --bonus - extra 1up
    init_aspects()    -- aspects are used for powerups

    --timers
    local st = timer:new60(30, _noop,
        function() startgame(_plevel) end)
    local lt = timer:new60(30, _noop,
        function() levelup() end) 
    local tt = timer:new60(30, _noop,
        function() _begin_anim_title=true  end)
    st:init()
    lt:init()
    tt:init()
    _timers["start_timer"] = st
    _timers["levelup_timer"] = lt
    _timers["anim_title"] = tt
end

function init_collisions()
    _colle = collision_engine:new(_tol)

    -- brick area of collisions
    local br_area = {
        x = _screen_left,
        y = _screen_top,
        w = _screen_left + (brick.w * _max_cols),
        h = _screen_top + (brick.h * _max_rows)
    }
    -- powerup area colliding w/paddle 
    local pup_area={
        x = _screen_left,
        y = paddle.y,
        w = _screen_right,
        h = paddle.h
    }
    -- balls in play, starts w/_pball
    _colle.balls={ _pball }
    
    _colle.update=function(self) 
        for b in all(self.balls) do 
            --ball-paddle collision
            local col, side = self:is_circle_rect_collision_side(b, _ppaddle)
            if(col) pb_handler:handle(b, _ppaddle, side)
            --ball-screen edges collision
            col, side = self:is_circle_screen_colliding(b)
            if(col) bscr_handler:handle(b, side)
            --ball-brick collision
            col, side = self:is_circle_rect_collision_side(b, br_area)
            if(col) br_handler:handle(b, br_area, side)
        end
        --powerups-paddle collision
        if(self:is_rect_colliding(_ppaddle, pup_area)) pup_handler:handle(_ppaddle, pup_area)
    end
end

function init_sys()
    cartdata(_cdata_id)
    _high_score = dget(_high_score_index)
    
    if(_debug) then
        menuitem(1, "badges", function()
            _is_dialog_open = true
        end)
        menuitem(2, "levelup", function()
            gamestate("levelup")
        end)
        menuitem(3, "gameover", function()
            gamestate("gameover")
        end)

    end
end

