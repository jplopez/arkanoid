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

--sides
_top_left = 1
_top      = 2
_top_right= 3
_left     = 4
_right    = 6
_bottom_left = 7
_bottom      = 8
_bottom_right= 9

function print_side(side)
  if(side == nil) return ""
  if(side == _top_left) return "top-left"
  if(side == _top) return "top"
  if(side == _top_right) return "top-right"
  if(side == _left) return "left"
  if(side == _right) return "right"
  if(side == _bottom_left) return "bottom-left"
  if(side == _bottom) return "bottom"
  if(side == _bottom_right) return "bottom-right"
end
