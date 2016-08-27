--[[
 * ReaScript Name: Apply Tape-stop effect to item under mouse cursor
 * Instructions: drag mouse cursor to item and run the script by shortcut
 * Author: Chooze
 * Author URI: http://vk.com/podushampublic http://choozeyoursound.com
 * Licence: GPL v3
 * Version: 1.2
 * Version Date: 2016-08-24
--]]
           
function TapeStopItem(item)
    if item~=nil then
       local item_len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
       local tk =  reaper.GetActiveTake(item, 0)
             if reaper.TakeIsMIDI(tk) == false then
             reaper.SetMediaItemTakeInfo_Value(tk, "D_PLAYRATE", 0.5)
       local marker_first = reaper.SetTakeStretchMarker(tk, -1, 0)
       local marker_last = reaper.SetTakeStretchMarker(tk, -1, item_len*0.5)
             reaper.SetTakeStretchMarkerSlope(tk, marker_first, -1)
             reaper.SetMediaItemInfo_Value(item, "B_LOOPSRC", 0 )
             reaper.SetMediaItemTakeInfo_Value(tk, "B_PPITCH", 0 )
             end
    else return nil end
end
             
---------------------------------------------------------------------------
             
             reaper.Undo_BeginBlock()
             _,_,_ = reaper.BR_GetMouseCursorContext()
             item =  reaper.BR_GetMouseCursorContext_Item()
             --item_count = reaper.CountSelectedMediaItems(0)
             --[[if item_count >= 1 then
                for i = 0, item_count-1 do]]
                --item =  reaper.GetSelectedMediaItem(0, i)
                TapeStopItem(item)
               --[[ end
             end]]
             
             reaper.Undo_EndBlock("Tape-stop",-1)
             reaper.UpdateArrange()
