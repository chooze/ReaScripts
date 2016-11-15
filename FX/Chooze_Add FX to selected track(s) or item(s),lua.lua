--[[
 * ReaScript Name: Apply Tape-stop effect to selected items
 * Instructions: 1. type FX Name in "fx_name" string, and preset name
   in "preset_name"
   2. select item(s) or track(s) 
   3. run the script
 * Author: Chooze
 * Author URI: http://vk.com/podushampublic http://choozeyoursound.com
 * Licence: GPL v3
 * Version: 1.0
 * Version Date: 2016-11-16
--]]



local r = reaper
fx_name = "ReaEQ"
preset_name = ""
float = 1 -- 1 = float; 0 = hide

------------------------------------------------
------------------------------------------------

function AddFX_Take(take)
     if  reaper.TakeIsMIDI(take) == false then
         reaper.TakeFX_AddByName(take, fx_name, -1)         -- Add FX
         local fxid = reaper.TakeFX_GetCount(take) - 1      -- Count number of fx
         reaper.TakeFX_SetPreset( take, fxid, preset_name)  -- Set preset
         reaper.TakeFX_Show(take, fxid, float+2)            -- Show last fx floating
     end
end

------------------------------------------------
------------------------------------------------

function AddFX_Track(track)
   reaper.TrackFX_AddByName(track, fx_name, 0, -1)     -- Add FX
   local fxid = reaper.TrackFX_GetCount(track) - 1     -- Count number of fx
   reaper.TrackFX_SetPreset(track, fxid, preset_name)  -- Set preset
   reaper.TrackFX_Show(track, fxid, float+2)           -- Show last fx floating
end

------------------------------------------------
------------------------------------------------

MouseX = r.GetCursorContext()
CountItems =  r.CountSelectedMediaItems(0)
CountTracks = r.CountSelectedTracks(0)

------------------------------------------------
------------------------------------------------

-- TAKE FX

if MouseX == 1 and CountItems > 0 then 

    r.Undo_BeginBlock()
    
    for i = 0, CountItems-1 do
    it =  r.GetSelectedMediaItem(0, i)
    tk =  r.GetActiveTake(it)
    AddFX_Take(tk)
    
    end    
    
    r.Undo_EndBlock("Add "..fx_name.." to selected items", 0)
    
end

-- END TAKE FX

------------------------------------------------
------------------------------------------------

-- TRACK FX

if MouseX == 0 and CountTracks > 0 then

    r.Undo_BeginBlock()
    
    for i = 0, CountTracks-1 do
    tr = r.GetSelectedTrack(0, i)
    AddFX_Track(tr)
    end
    
    --r.SetCursorContext(0)
    r.Undo_EndBlock("Add "..fx_name.." to selected tracks", 0)

end

-- END TRACK FX
------------------------------------------------
------------------------------------------------

r.UpdateArrange()


