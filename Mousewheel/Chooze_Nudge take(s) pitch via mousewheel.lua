function Check(it)
if it == nil then return -1 end

 if reaper.IsMediaItemSelected(it) == false then return 0 
 else return reaper.CountSelectedMediaItems(0) end
 
end

-----------------------------------------------------------

function MainOne(it)
     if it then
     take =  reaper.BR_GetMouseCursorContext_Take()
     pitch = reaper.GetMediaItemTakeInfo_Value(take, "D_PITCH")
     reaper.SetMediaItemTakeInfo_Value(take, "D_PITCH", pitch + step)
     end
end

----------------------------------------------------------

function MainSeveral(it)
     if it then
     take =  reaper.GetActiveTake(it)
     pitch = reaper.GetMediaItemTakeInfo_Value(take, "D_PITCH")
     reaper.SetMediaItemTakeInfo_Value(take, "D_PITCH", pitch + step)
     end
end

---------------------------------------------------------

reaper.Undo_BeginBlock()

step = 1

       m_wheel_delta = ({reaper.get_action_context()})[7]
       if m_wheel_delta < -1 then
       step = -step
       end

windowOut, segmentOut, detailsOut = reaper.BR_GetMouseCursorContext()
item =  reaper.BR_GetMouseCursorContext_Item()

if Check(item) < 0 then return nil
elseif Check(item) == 0 then MainOne(item)
elseif Check(item) > 0 then for i = 0, Check(item)-1 do
it2 = reaper.GetSelectedMediaItem(0,i) MainSeveral(it2) end
end

reaper.UpdateArrange()
reaper.Undo_EndBlock("Nudge item(s) pitch via mousewheel", -111)
