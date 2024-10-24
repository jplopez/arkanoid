-- Variable to track whether the dialog is open
_is_dialog_open=false
_sel_aspect=1

function toggle_selected_aspect()
  local a=aspect.pool[_sel_aspect]
  if(a)a:toggle()
end

-- Function to draw the dialog
function draw_bdg_dialog()
  log(aspect.pool)
  -- Draw the dialog background
  rectfill(10,10,118,118,15) -- White background
  -- Title
  print("aspects",20,13,0)
  -- List game aspects and their status

  for i=1,#aspect.pool do
    local a=aspect.pool[i]
    local status=(a.enabled) and"on"or"off"
    local color=(i==_sel_aspect) and 3 or 0 -- Highlight selected aspect
    local name = a.name
    print(tostr(name)..": "..spaces(15-#name).. status,20,22+(i-1)*7,color)
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
    if(_sel_aspect<1)then _sel_aspect=#aspect.pool end
  elseif btnp(3)then -- Down
    _sel_aspect+=1
    if(_sel_aspect>#aspect.pool)_sel_aspect=1
  elseif btnp(4)then toggle_selected_aspect() --"O" button
  elseif btnp(5)then _is_dialog_open=false --"X" button
  end
end

function upd_bdg_menu()if(_is_dialog_open)handle_dialog_input()end

function draw_bdg_menu()if(_is_dialog_open) draw_bdg_dialog()end