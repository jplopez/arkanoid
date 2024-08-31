-----------
--globals
-----------

_version="0.2.0"

-- Cart Data
_high_score_index=0

_noop=function()end

--screen
_screen_margin=4
_screen_left=_screen_margin
_screen_right=127-_screen_margin  
_screen_top=_screen_margin*3
_screen_bot=127

-- Levels

-- level definitions
-- items in _lvl_def are
-- a 2d [10][10] array with
-- the brick_type in each cell
_lvl_def = {}

_pups = {}

-- current level
_cur_lvl= nil

-- level brick grid
_max_rows = 10
_max_cols = 16


-- timers
_timers={ }
_begin_anim_title = false

--[[
  shake tells the draw function if the screen needs to shake. 
  The larger the value of shake, the longer the shake.
]]
_shake = 0

_high_score=0

--palletes
_pals = {
  bg = {1,2,3},
  paddle = {12,13,14,15},
  ball = {8,9,10,11},
  h1  = 0,
  h1o = 8,
  h2  = 13,
  h2o = 2,
  h3  = 15,
  h3o = 7,

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

-- power ball
_pwr_off=0
_pwr_ball=35
_pwr_fury=47
_pwr_max =50

_paddle_pen=2
_pwr_off_hit=1
_pwr_ball_hit=2
_pwr_fury_hit=10

_pwr_spr = {
  ["empty"] = {
    sxb=32, 
    syb=48, 
    paltb=11,
    sx=36, 
    sy=40,  
    palt=11
  },

  [_pwr_off] = {
    sxb=24, 
    syb=32, 
    paltb=0,
    sx=32, 
    sy=32,  
    palt=0
  },
  [_pwr_ball] = {
    sxb=24, 
    syb=40, 
    paltb=0,
    sx=36, 
    sy=32,  
    palt=0
  },
  [_pwr_fury] = {
    sxb=24, 
    syb=48, 
    paltb=0,
    sx=32, 
    sy=40,  
    palt=11
  }
}

-- powerup cooldown
-- to prevent too many pups to
-- appear at once.
-- 3 seconds = 3 * fps
_pup_cooldown = 0
function pup_cd_reset()
  _pup_cooldown = 3*60
end
function pup_cd_next()
  _pup_cooldown = max(0, _pup_cooldown-1)
  return _pup_cooldown
end

-- powerups
-- the number corresponds to the sprite
-- and is also an id to distinguish them
_pup_1up = 8
_pup_large = 9
_pup_small = 10
_pup_fireball = 11
_pup_3balls = 12
_pup_speed3 = 13
_pup_speed2 = 14
_pup_speed1 = 15
_pup_score = 24
_pup_web = 25
_pup_glue = 26
_pup_fire = 27


-- Table to store game aspects that can be enabled/disabled
_aspects = {
  -- {name="paddle_fire", enabled=false},
  -- {name="paddle_fireball", enabled=false},
  -- {name="paddle_web", enabled=false},
  {name="paddle_large", enabled=false},
  {name="paddle_small", enabled=false},
  -- {name="paddle_speed3", enabled=false},
  -- {name="paddle_speed2", enabled=false},
  -- {name="paddle_speed1", enabled=false},
  -- {name="paddle_3balls", enabled=false},
  -- {name="paddle_glue", enabled=false}
  -- Add more aspects as needed
}
