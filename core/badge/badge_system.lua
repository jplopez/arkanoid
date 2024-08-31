
-- Variable to track whether the dialog is open
_is_dialog_open = false
_sel_aspect = 1

-- Function to draw the dialog
function draw_bdg_dialog()
  -- Draw the dialog background
  rectfill(10, 10, 118, 118, 15) -- White background
  --rect(10, 10, 118, 118, 0) -- Black border
  -- Title
  print("badges", 20, 13, 0)
  -- List game aspects and their status
  for i, aspect in ipairs(_aspects) do
    local status = aspect.enabled and "on" or "off"
    local color = (i == _sel_aspect) and 3 or 0 -- Highlight selected aspect
    print(aspect.name .. ": " .. status, 20, 22 + (i-1)*7, color)
  end
  -- Instructions
  print("⬆️⬇️ to select", 20, 96, 0)
  print("🅾️ to toggle", 20, 103, 0)
  print("❎ to close", 20, 110, 0)
end

-- Function to toggle an aspect
function toggle_aspect()
  _aspects[_sel_aspect].enabled = not _aspects[_sel_aspect].enabled
end

-- Function to handle input in the dialog
function handle_dialog_input()
  if btnp(2) then -- Up
      _sel_aspect-=1
      if _sel_aspect < 1 then _sel_aspect = #_aspects end
  elseif btnp(3) then -- Down
      _sel_aspect+=1
      if _sel_aspect > #_aspects then _sel_aspect = 1 end
  elseif btnp(4) then -- "O" button
      toggle_aspect()
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
