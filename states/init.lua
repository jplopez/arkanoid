-- init
function init_gamestates()
    add_gamestate("start", 
        start_gamestate,
        { "start", "game" })

    add_gamestate("game", 
        game_gamestate,
        { "start", "game", "gameover", "levelup" })

    add_gamestate("gameover", 
        gameover_gamestate,
        { "game", "gameover" })

    add_gamestate("levelup", 
        levelup_gamestate,
        { "game", "levelup" })

    set_default("start")
end

function init_players()
    _pball = ball:new() 
    add_states( _pball,
        { "idle", "move", "sticky" })
    _ppaddle = paddle:new()
    add_states(_ppaddle,
        { "idle", "move", "hit" })

    --power bar
    _ppwrbar = powerbar:new()
    _ppwrbar.bars=0
    _pscore = 0
    _plevel = 1
    _plives = 3
    _pserves = 99
end

function init_objects()
    log("Init Game " .. time(), true)
    --level
    _lvl = level:new()

    --collision enginve v2
    _colle = collision_engine:new(_tol)
    _colle:add_circle_rect(
        "paddle",  _pball, _ppaddle, pb_handler)

    _colle:add_circle_screen(
        "ball", _pball, bscr_handler)

    -- this circle-rectangle collision handler 
    -- uses the area where bricks can appear within 
    -- a level
    _colle:add_circle_rect(
        "brick",  _pball,
        {
            x = _screen_left,
            y = _screen_top,
            w = _screen_left + (brick.w * _max_cols),
            h = _screen_top + (brick.h * _max_rows)
        }, br_handler)

    -- this rectangle-rectangle collision handler 
    -- uses the area where the paddle moves to detect
    -- collision with powerups  
    _colle:add_rect_rect(
        "powerup", _ppaddle,
        {
            x = _screen_left,
            y = paddle.y,
            w = _screen_right,
            h = paddle.h
        },pup_handler)
  
    --bonus - extra 1up
    init_bonus()

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

function init_sys()
    cartdata(_cdata_id)
    _high_score = dget(_high_score_index)
    menuitem(1, "badges", function()
        _is_dialog_open = true
    end)
end

