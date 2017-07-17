
function Check(it)
if it == nil then return -1 end

 if reaper.IsMediaItemSelected(it) == false then return 0 
 else return reaper.CountSelectedMediaItems(0) end
 
end


-----------------------------------------------------------

function MainOne(it)
     if it then
     take =  reaper.BR_GetMouseCursorContext_Take()
     vol = reaper.GetMediaItemTakeInfo_Value(take, "D_VOL")
     reaper.SetMediaItemTakeInfo_Value(take, "D_VOL", vol*10^(0.05*step))
     end
end

----------------------------------------------------------

function MainSeveral(it)
     if it then
     take =  reaper.GetActiveTake(it)
     vol = reaper.GetMediaItemTakeInfo_Value(take, "D_VOL")
     reaper.SetMediaItemTakeInfo_Value(take, "D_VOL", vol*10^(0.05*step))
     end
end

---------------------------------------------------------

function CheckTracks(track1)

e,f,g = reaper.BR_GetMouseCursorContext()
t = reaper.BR_GetMouseCursorContext_Track()
if t and e == "tcp" and f == "track" then
slc = reaper.IsTrackSelected(t)
  if slc == true then numtr = reaper.CountSelectedTracks(0) 
  
   for j = 0, numtr-1 do
   tttt = reaper.GetSelectedTrack(0, j)
   ttttvol = reaper.GetMediaTrackInfo_Value(tttt, "D_VOL" )
   reaper.SetMediaTrackInfo_Value( tttt, "D_VOL", ttttvol*10^(0.05*step))
   end
   
  elseif slc == false then  
  
  ttttvol = reaper.GetMediaTrackInfo_Value(t, "D_VOL" )  
  reaper.SetMediaTrackInfo_Value( t, "D_VOL", ttttvol*10^(0.05*step))
  
  end

end

end

--------------------------------------------------------

function RunItems()
 if Check(item) < 0 then return nil
 elseif Check(item) == 0 then MainOne(item)
 elseif Check(item) > 0 then for i = 0, Check(item)-1 do
 it2 = reaper.GetSelectedMediaItem(0,i) MainSeveral(it2) end
 end
end

--------------------------------------------------------

----------------------------------------------------------

reaper.Undo_BeginBlock()

step = 1

       m_wheel_delta = ({reaper.get_action_context()})[7]
       if m_wheel_delta < -1 then
       step = -step
       end

a,b,c = reaper.BR_GetMouseCursorContext()
item = reaper.BR_GetMouseCursorContext_Item()

if item then RunItems() else 
    if a == "tcp" and b == "track" then CheckTracks()  end 
end
reaper.UpdateArrange()
reaper.Undo_EndBlock("Nudge volume via mousewheel", -111)
