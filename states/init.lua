-- init
function init_players()
    _players["p1"]["ball"] = ball:new({
        x = rnd(127),
        dx = 0.51,
        y = rnd(127),
        dy = 0.51, --+rnd(2),
        clr = rnd(_pals.ball)
    })
    add_states(_players["p1"]["ball"], 
        {"idle", "move", "sticky"})

    _players["p1"]["paddle"] = paddle:new({
        clr = rnd(_pals.paddle)
    })
    add_states(_players["p1"]["paddle"], 
        {"idle", "move", "hit"})

    _players["p1"]["score"] = 0
    _players["p1"]["level"] = 1
    _players["p1"]["lives"] = 3
    _players["p1"]["serves"]= 2
end

function init_objects()
    logger:log("Init Game " .. time(), true)

    --level
    _cur_lvl = level:new()

    --collision engine
    _col_eng = col_eng:new()

    --collision enginve v2
    _col_eng_v2 = collision_engine:new(2)
    _col_eng_v2:add_circle_rect("paddle", 
            _players["p1"]["ball"],
            _players["p1"]["paddle"],
            paddle_ball_collision_handler)
    _col_eng_v2:add_circle_screen("ball", 
            _players["p1"]["ball"],
            ball_screen_collision_handler)

    --initial state
    _state = _init_state

    --bonus - extra 1up
    init_bonus()

    --timers
    local start_timer = timer:new60(
        30, noop,
        function()
            startgame(_players["p1"]["level"])
        end
    )
    start_timer:init()
    _timers["start_timer"] = start_timer

    local levelup_timer = timer:new60(
        30, noop,
        function()
            levelup()
        end
    )
    levelup_timer:init()
    _timers["levelup_timer"] = levelup_timer
end