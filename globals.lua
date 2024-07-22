-----------
--globals
-----------

noop=function()end

--screen
_screen_margin=4
_screen_left=_screen_margin
_screen_right=127-_screen_margin  
_screen_top=_screen_margin*3
_screen_bot=127

--level
_cur_lvl= nil

--states
_states={
 start={"game"},
 levelup={"game"},
 game={"levelup","gameover"},
 gameover = {"start"} 
}
_init_state="start"
_state=""

_timers={ }

--palletes
_pals = {
  bg = {1,2,3},
  paddle = {12,13,14,15},
  ball ={8,9,10,11}
}

--players
_players = { p1={}, p2={} }