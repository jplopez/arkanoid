-- _aspects are defined in globals.lua
-- Function to toggle an aspect
function toggle_aspect_by_name(name,enable)
  local a =_aspects[name]
  if(a)a.enabled=enable
  if(a.enabled)then
    if(a.disables)then
      for d in all(a.disables)do
        if(_aspects[d].enabled)then
          _aspects[d].exit()
          _aspects[d].enabled=false
        end
      end
    end
    a.enter()
  else a.exit()end
end

function disable_all_aspects()
  for k,v in pairs(_aspects)do toggle_aspect_by_name(k,false)end
end

function init_aspects()
  _aspects["web"].enter=function()_pweb:set(idle)end
  _aspects["web"].exit=function()_pweb:set(hidden)end

  _aspects["paddle_expand"].enter=function()sfx(34)_ppaddle.w=mid(24,_ppaddle.w+4,32)end
  _aspects["paddle_expand"].exit=function()_ppaddle.w=paddle.w end

  _aspects["paddle_shrink"].enter=function()sfx(35)
    _ppaddle.w=mid(16,_ppaddle.w-4,24)
    _pwrbar_increment=mid(1,_pwrbar_increment+1,3)
    _pwrbar_combo_factor=mid(1,_pwrbar_combo_factor-1,3)
  end
  _aspects["paddle_shrink"].exit=function() 
    _ppaddle.w=paddle.w
    _pwrbar_increment=1
    _pwrbar_combo_factor=3
  end

  _aspects["extra_ball"].enter=function() 
    if(#_colle.balls>_max_balls)return false
    local b = ball(_ENV,{main=false})
    -- add(_pup_extra_balls,b)
    -- add(_colle.balls,b) 
    b:serve()
  end
  _aspects["extra_ball"].exit=function()
    -- _pup_extra_balls={}
    -- _colle.balls={_pball}
    ball:each("destroy") --won't destroy _pball
  end

  _aspects["paddle_glue"].enter=function()sfx(33)end 
end

--[[
  MENU DIALOG METHODS
]]

-- Variable to track whether the dialog is open
_is_dialog_open=false
_sel_aspect=1
_length=0
function toggle_selected_aspect()
  local i=1
  for k,v in pairs(_aspects) do
    if(v.id==_sel_aspect) then 
      toggle_aspect_by_name(k,not v.enabled)
    else i+=1 end
  end
end

-- Function to draw the dialog
function draw_bdg_dialog()
  -- Draw the dialog background
  rectfill(10,10,118,118,15) -- White background
  -- Title
  print("badges",20,13,0)
  -- List game aspects and their status
  local y_pos=1
  for k,aspect in pairs(_aspects)do
    local status=aspect.enabled and"on"or"off"
    local color=(aspect.id==_sel_aspect) and 3 or 0 -- Highlight selected aspect
    print(tostr(k)..": ".. status,20,22+(y_pos-1)*7,color)
    y_pos+=1
  end
  _length=y_pos
  -- Instructions
  print("⬆️⬇️ to select",20,96,0)
  print("🅾️ to toggle",20,103,0)
  print("❎ to close",20,110,0)
end

-- Function to handle input in the dialog
function handle_dialog_input()
  if btnp(2)then -- Up
    _sel_aspect-=1
    if(_sel_aspect<1)then _sel_aspect=_length end
  elseif btnp(3)then -- Down
    _sel_aspect+=1
    if(_sel_aspect>_length)_sel_aspect=1
  elseif btnp(4)then toggle_selected_aspect() --"O" button
  elseif btnp(5)then _is_dialog_open=false --"X" button
  end
end

function upd_bdg_menu()if(_is_dialog_open)handle_dialog_input()end

function draw_bdg_menu()if(_is_dialog_open) draw_bdg_dialog()end