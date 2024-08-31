-- init
function init_gamestates()
    add_gamestate(
        "start", 
        start_gamestate,
        { "start", "game" })

    add_gamestate(
        "game", 
        game_gamestate,
        { "start", "game", "gameover", "levelup" })

    add_gamestate(
        "gameover", 
        gameover_gamestate,
        { "game", "gameover" })

    add_gamestate(
        "levelup", 
        levelup_gamestate,
        { "game", "levelup" })

    set_default("start")
end

function init_players()
    _players["p1"]["ball"] = ball:new({
        x = rnd(127),
        dx = 0.51,
        y = rnd(127),
        dy = 0.51, --+rnd(2),
        clr = 7}) --rnd(_pals.ball) })

    add_states(
        _players["p1"]["ball"],
        { "idle", "move", "sticky" })

    _players["p1"]["paddle"] = paddle:new({
        clr = rnd(_pals.paddle) })
    add_states(
        _players["p1"]["paddle"],
        { "idle", "move", "hit" })

    --power bar
    _players["p1"]["powerbar"] = powerbar:new()
    _players["p1"]["powerbar"].bars=0
 
    _players["p1"]["score"] = 0
    _players["p1"]["level"] = 1
    _players["p1"]["lives"] = 3
    _players["p1"]["serves"] = 99
end

function init_objects()
    log("Init Game " .. time(), true)
   
    --level
    _cur_lvl = level:new()

    --collision enginve v2
    _col_eng_v2 = collision_engine:new(2)
    _col_eng_v2:add_circle_rect(
        "paddle",
        _players["p1"]["ball"],
        _players["p1"]["paddle"],
        paddle_ball_collision_handler)

        _col_eng_v2:add_circle_screen(
        "ball",
        _players["p1"]["ball"],
        ball_screen_collision_handler)

    -- this circle-rectangle collision handler 
    -- uses the area where bricks can appear within 
    -- a level
    _col_eng_v2:add_circle_rect(
        "brick",
        _players["p1"]["ball"],
        {
            x = _screen_left,
            y = _screen_top,
            w = _screen_left + (brick.w + level.pad_col) * _max_cols,
            h = _screen_top + (brick.h + level.pad_row) * _max_rows
        },
        brick_collision_handler)

    -- this rectangle-rectangle collision handler 
    -- uses the area where the paddle moves to detect
    -- collision with powerups  
    _col_eng_v2:add_rect_rect(
        "powerup",
        _players["p1"]["paddle"],
        {
            x = _screen_left,
            y = paddle.y,
            w = _screen_right,
            h = paddle.h
        },
        paddle_pup_collision_handler)
  

    --bonus - extra 1up
    init_bonus()

    --timers
    local start_timer = timer:new60(
        30, _noop,
        function()
            startgame(_players["p1"]["level"])
        end
    )
    start_timer:init()
    _timers["start_timer"] = start_timer

    local levelup_timer = timer:new60(
        30, _noop,
        function()
            levelup()
        end
    )
    levelup_timer:init()
    _timers["levelup_timer"] = levelup_timer

    local tt = timer:new60(30, function() end,
    function() 
        _begin_anim_title=true 
    end)
    tt:init()
    _timers["anim_title"] = tt

end

function init_sys()
    cartdata("parkanoid")
    _high_score = dget(_high_score_index)
    
    -- Add the menu item for "badges"
    menuitem(1, "badges", function()
        _is_dialog_open = true
    end)
end

