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

--[[
  MENU DIALOG METHODS
]]

-- Variable to track whether the dialog is open
_is_dialog_open=false
_sel_aspect=1
_length=5
function toggle_selected_aspect()
  local a=_aspects[_sel_aspect]
  toggle_aspect_by_name(_sel_aspect,not a.enabled)
end

-- Function to draw the dialog
function draw_bdg_dialog()
  log(_aspects)
  -- Draw the dialog background
  rectfill(10,10,118,118,15) -- White background
  -- Title
  print("badges",20,13,0)
  -- List game aspects and their status
  local y_pos=1
  for i=1,_length do
--  for k,aspect in pairs(_aspects)do
    local status=(_aspects[i].enabled) and"on"or"off"
    local color=(i==_sel_aspect) and 3 or 0 -- Highlight selected aspect
    print(tostr(_aspects[i].name)..": ".. status,20,22+(y_pos-1)*7,color)
    y_pos+=1
  end
  --_length=y_pos
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