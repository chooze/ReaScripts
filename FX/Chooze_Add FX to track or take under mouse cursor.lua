--[[
 * ReaScript Name: Add FX
 * Instructions:
      1.1 to add FX to track - move mouse cursor over track control panel or mixer control panel
      1.2 to add FX to item/take - move mouse cursor over item/take
      2. run this script by shortcut
 * Author: Chooze
 * Author URI: http://vk.com/podushampublic http://choozeyoursound.com
 * Licence: GPL v3
 * Version: 1.2
 * Version Date: 2016-08-26
--]]
         
  --[[  Change FX name here:      ]] fx_name = "ReaEQ"
  --[[  Change preset name here:  ]] preset_name = "chooze - shelves"
    
------------------------------------------------
wn, sg, dt = reaper.BR_GetMouseCursorContext()
take = reaper.BR_GetMouseCursorContext_Take()
track = reaper.BR_GetMouseCursorContext_Track()
------------------------------------------------

function AddFX_Take(take)
     if  reaper.TakeIsMIDI(take) == false then
         reaper.TakeFX_AddByName(take, fx_name, -1)         -- Add FX
         local fxid = reaper.TakeFX_GetCount(take) - 1      -- Count number of fx
         reaper.TakeFX_SetPreset( take, fxid, preset_name)  -- Set preset
         reaper.TakeFX_Show(take, fxid, 3)                  -- Show last fx floating
     end
end

------------------------------------------------
function AddFX_Track(track)
   reaper.TrackFX_AddByName(track, fx_name, 0, -1)     -- Add FX
   local fxid = reaper.TrackFX_GetCount(track) - 1     -- Count number of fx
   reaper.TrackFX_SetPreset(track, fxid, preset_name)  -- Set preset
   reaper.TrackFX_Show(track, fxid, 3)                 -- Show last fx floating
end

------------------------------------------------

reaper.Undo_BeginBlock()

if take~=nil then AddFX_Take(take)
else
   if track ~=nil then if wn == "tcp" then AddFX_Track(track) end
   end
end

reaper.UpdateArrange()
reaper.Undo_EndBlock("Add "..fx_name, -1)
