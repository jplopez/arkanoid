-----------
--globals
-----------

--System
_version="0.4.0"
_debug=true --debug mode

-- Cart Data
_cdata_id = "parkanoid"
_high_score_index=0
_high_score=0

--utils
_noop=function()end

--gamestates
_states = {"start", "game", "gameover", "levelup"}

--screen
_screen_margin=4 -- margin from edge of visible screen
_screen_left=_screen_margin
_screen_right=127-_screen_margin  
_screen_top=_screen_margin*3
_screen_bot=127

--pallete
_pal_h1  = 0
_pal_h1o = 8 
_pal_h2  = 6
_pal_h2o = 2
_pal_h3  = 6
_pal_h3o = 5

-- sfx and music
_sfx_channels=3   -- channels 0 and 1
_music_channels=12 -- channels 2 and 3

-- world definitions--
_begin_anim_title = false
_shake = 0 -- shake>0 shakes the screen. The larger shake's value, the longer the shake  
_timers={} -- timers
_lvl_def = {} --level definitions
-- level brick grid
_max_rows=10
_max_cols=16
_bacc=0.7        -- ball acceleration 
_bonus={}       -- score bonus

-- world objects
_pups={}        -- powerups
_lvl=nil         -- current level
_colle=nil      -- collision engine

_maps = {
  { x=0, y=2,m=1}, -- ice
  { x=16,y=2,m=3}, -- brick
  { x=32,y=2,m=6}  -- grass
}

-- toggleable aspects
_aspects = {
  paddle_expand = {
    id=1, 
    enabled=false, 
    enter=_noop, 
    exit=_noop,
    disables={"paddle_shrink","paddle_glue"}},
  paddle_shrink = {
    id=2, 
    enabled=false, 
    enter=_noop, 
    exit=_noop,
    disables={"paddle_expand","paddle_glue"}},
  web = {
    id=3, 
    enabled=false,
    enter=_noop, 
    exit=_noop,
    disables={"paddle_shrink","paddle_expand","paddle_glue"}
  },
  extra_ball = {
    id=4,
    enabled=false,
    enter=_noop, 
    exit=_noop,
    disables={"paddle_glue"}
  },
  paddle_glue = {
    id=5, 
    enabled=false,
    enter=_noop, 
    exit=_noop,
    disables={"paddle_shrink","paddle_expand"}
  },
}

--playable objects 

--player
_pball = nil
_ppaddle = nil
_pscore = 0
_plevel = 1
_plives = 3
_pserves = 99
_ppwrbar=nil
_pweb=nil
-- powerbar
_pwrbar_increment=1
_pwrbar_combo_factor=3

-- power ball
_pwr_off=0
_pwr_ball=35
_pwr_fury=47
_pwr_max =50
_paddle_pen=2  -- paddle power penalization
_pwr_off_hit=1
_pwr_ball_hit=2
_pwr_fury_hit=10

-- power ball sprites info
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

_pup_score_val=500

_pup_extra_balls = { }
_max_balls = 3

--collissions
_tol = 2 -- collision tolerance
--sides
_top      = 2
_bottom   = 3
_left     = 7
_right    = 11
_top_left    = 9  -- top + left
_top_right   = 13 -- top + right
_bottom_left = 10 -- bottom + left
_bottom_right= 14 -- bottom + right
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