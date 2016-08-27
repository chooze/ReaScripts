--[[
   * ReaScript Name: Split and half
   * Lua script for Cockos REAPER
   * GIF demo: https://github.com/chooze/ReaScripts/blob/master/Items/Chooze_Split%20and%20half.gif
   * Author: Chooze
   * Author URI: http://vk.com/podushampublic http://choozeyoursound.com
   * Licence: GPL v3
   * Version: 1.3
  ]]


scriptname = "Split and half"


reaper.Undo_BeginBlock()

reaper.Main_OnCommand("40932", 0)

  Item_No = reaper.CountSelectedMediaItems(0)
  
    for i = 0, Item_No - 1 do
      Item = reaper.GetSelectedMediaItem(0, i)
      Item_Len = reaper.GetMediaItemInfo_Value(Item, "D_LENGTH") 
      Item_Len_Half = reaper.SetMediaItemLength(Item, Item_Len / 2, 0)
    end
  reaper.UpdateArrange()
  
reaper.Undo_EndBlock(scriptname, 0)
