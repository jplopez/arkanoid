-- _aspects is defined in globals.lua

-- Function to toggle an aspect
function toggle_aspect_by_name(name, enable)
  local a = _aspects[name]
  if(a) a.enabled = enable

  if(a) and (a.enabled) then 
    if(a.disables) then
      for d in all(a.disables) do
        if(_aspects[d].enabled) then
          _aspects[d].exit()
          _aspects[d].enabled = false
        end
      end
    end
    a.enter()
  else a.exit() end
end

function disable_all_aspects()
  for k,v in pairs(_aspects) do 
    toggle_aspect_by_name(k, false)
  end
end

function init_aspects() 

  _aspects["paddle_expand"].enter=function() 
    _ppaddle.w = mid(24, _ppaddle.w+4, 32) 
  end
  _aspects["paddle_expand"].exit=function() 
    _ppaddle.w=paddle.w
  end

  _aspects["paddle_shrink"].enter=function() 
    _ppaddle.w = mid(16, _ppaddle.w-4, 24)
    _pwrbar_increment=mid(1, _pwrbar_increment+1, 3)
    _pwrbar_combo_factor=mid(1, _pwrbar_combo_factor-1, 3)
  end
  _aspects["paddle_shrink"].exit=function() 
    _ppaddle.w=paddle.w
    _pwrbar_increment=1
    _pwrbar_combo_factor=3
  end

  _aspects["extra_ball"].enter=function() 
    if(#_colle.balls > _max_balls) return false

    local b = ball:new()
    b.ball_spr=function(self) return 16,0 end
    b.power=function(self) return _pwr_off end
    b.hits=function(self) return _pwr_off_hit end
    -- add_states( b,
    --   { "idle", "move", "sticky", "hidden" })
 
    add(_pup_extra_balls, b)
    add(_colle.balls, b) 
    b:serve()
    log("extra_ball enter:" .. count(_pup_extra_balls))
  end

  _aspects["extra_ball"].exit=function()
    _pup_extra_balls={ }
    _colle.balls = { _pball }
    log("extra_ball exit:" .. count(_pup_extra_balls))
  end

end

--[[
  MENU DIALOG METHODS
]]

-- Variable to track whether the dialog is open
_is_dialog_open = false
_sel_aspect = 1

function toggle_selected_aspect()
  local i=1
  for k,v in pairs(_aspects) do
    if(v.id==_sel_aspect) then 
      toggle_aspect_by_name(k, not v.enabled)
    else
      i+=1
    end
  end
end

-- Function to draw the dialog
function draw_bdg_dialog()
  -- Draw the dialog background
  rectfill(10, 10, 118, 118, 15) -- White background
  --rect(10, 10, 118, 118, 0) -- Black border
  -- Title
  print("badges", 20, 13, 0)
  -- List game aspects and their status
  local y_pos=1
  for k, aspect in pairs(_aspects) do
    local status = aspect.enabled and "on" or "off"
    local color = (aspect.id == _sel_aspect) and 3 or 0 -- Highlight selected aspect
    print(tostr(k) .. ": " .. status, 20, 22 + (y_pos-1)*7, color)
    y_pos+=1
  end
  -- Instructions
  print("⬆️⬇️ to select", 20, 96, 0)
  print("🅾️ to toggle", 20, 103, 0)
  print("❎ to close", 20, 110, 0)
end

-- Function to handle input in the dialog
function handle_dialog_input()
  if btnp(2) then -- Up
      _sel_aspect-=1
      if _sel_aspect < 1 then _sel_aspect = count(_aspects) end
  elseif btnp(3) then -- Down
      _sel_aspect+=1
      if _sel_aspect > count(_aspects) then _sel_aspect = 1 end
  elseif btnp(4) then -- "O" button
      toggle_selected_aspect()
  elseif btnp(5) then -- "X" button
      _is_dialog_open = false
  end
end

-- Main update function
function upd_bdg_menu()
  if _is_dialog_open then
      handle_dialog_input()
  end
end

-- Main draw function
function draw_bdg_menu()
  --cls()
  if _is_dialog_open then
      draw_bdg_dialog()
  else
      -- Your regular game drawing code here
  end
end