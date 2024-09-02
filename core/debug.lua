
-- Variable to track whether the dialog is open
_is_debug_open = false
_sel_dbg = 1

_debugs = { }

-- Function to draw the dialog
function draw_dbg_dialog()
  -- Draw the dialog background
  rectfill(10, 10, 118, 118, 15) -- White background
  --rect(10, 10, 118, 118, 0) -- Black border
  -- Title
  print("badges", 20, 13, 0)
  -- List game aspects and their status
  for i, aspect in ipairs(_debugs) do
    local status = aspect.enabled and "on" or "off"
    local color = (i == _sel_dbg) and 3 or 0 -- Highlight selected aspect
    print(aspect.name .. ": " .. status, 20, 22 + (i-1)*7, color)
  end
  -- Instructions
  print("⬆️⬇️ to select", 20, 96, 0)
  print("🅾️ to toggle", 20, 103, 0)
  print("❎ to close", 20, 110, 0)
end

-- Function to toggle an aspect
function toggle_aspect()
  _debugs[_sel_dbg].enabled = not _debugs[_sel_dbg].enabled
end

-- Function to handle input in the dialog
function handle_dbg_input()
  if btnp(2) then -- Up
      _sel_dbg-=1
      if _sel_dbg < 1 then _sel_dbg = #_debugs end
  elseif btnp(3) then -- Down
      _sel_dbg+=1
      if _sel_dbg > #_debugs then _sel_dbg = 1 end
  elseif btnp(4) then -- "O" button
      toggle_aspect()
  elseif btnp(5) then -- "X" button
      _is_dialog_open = false
  end
end

-- Main update function
function upd_dbg_menu()
  if _is_debug_open then
    handle_dbg_input()
  end
end

-- Main draw function
function draw_dbg_menu()
  --cls()
  if _is_dialog_open then
      draw_dbg_dialog()
  else
      -- Your regular game drawing code here
  end
end
