local MASH = {"cmd", "alt", "ctrl"}
local MASH_SHIFT = {"cmd", "alt", "ctrl", "shift"}

local focusedWindow
local focusedWindowFrame
local screenFrame

hs.grid.MARGINX = 0
hs.grid.MARGINY = 0



--------------------------------------------------------------------------------
-- Hotkeys

hs.hotkey.bind(MASH, "W", function() hs.alert.show("The Game") end)
hs.hotkey.bind(MASH, "E", function() showSpotifyInfo() end)
hs.hotkey.bind(MASH, "D", function() hs.grid.pushWindowNextScreen() end)
hs.hotkey.bind(MASH, "F", function() operateFrame(maximize) end)
hs.hotkey.bind(MASH, "Z", function() operateFrame(resizeAndCenterHorizontallyAndMoveCompletelyToBottom, 0.6, 0.8) end)
hs.hotkey.bind(MASH, "X", function() operateFrame(resizeWidthAndMaximizeHeightAndCenter, 0.7) end)
hs.hotkey.bind(MASH, "C", function() operateFrame(resizeWidthAndMaximizeHeightAndCenter, 0.6) end)
hs.hotkey.bind(MASH, "V", function() operateFrame(resizeWidthAndMaximizeHeightAndCenter, 0.5) end)
hs.hotkey.bind(MASH, "B", function() operateFrame(resizeAndCenter, 0.7) end)
hs.hotkey.bind(MASH, "N", function() operateFrame(resizeAndCenter, 0.6) end)
hs.hotkey.bind(MASH, "M", function() operateFrame(resizeAndCenter, 0.5) end)
hs.hotkey.bind(MASH, "o", function() operateFrame(increaseHeightAtTop, 0.1) end)
hs.hotkey.bind(MASH, "l", function() operateFrame(increaseHeightAtBottom, 0.1) end)
hs.hotkey.bind(MASH, "k", function() operateFrame(increaseWidthAtLeft, 0.1) end)
hs.hotkey.bind(MASH, "ñ", function() operateFrame(increaseWidthAtRight, 0.1) end)
hs.hotkey.bind(MASH_SHIFT, "o", function() operateFrame(decreaseWidthAtTop, 0.1) end)
hs.hotkey.bind(MASH_SHIFT, "l", function() operateFrame(decreaseWidthAtBottom, 0.1) end)
hs.hotkey.bind(MASH_SHIFT, "k", function() operateFrame(decreaseWidthAtLeft, 0.1) end)
hs.hotkey.bind(MASH_SHIFT, "ñ", function() operateFrame(decreaseWidthAtRight, 0.1) end)
hs.hotkey.bind(MASH_SHIFT, "Up", function() operateFrame(moveToTopKeepingVisibility, 0.1) end)
hs.hotkey.bind(MASH_SHIFT, "Down", function() operateFrame(moveToBottomKeepingVisibility, 0.1) end)
hs.hotkey.bind(MASH_SHIFT, "Left", function() operateFrame(moveToLeftKeepingVisibility, 0.1) end)
hs.hotkey.bind(MASH_SHIFT, "Right", function() operateFrame(moveToRightKeepingVisibility, 0.1) end)
hs.hotkey.bind(MASH, "Up", function() operateFrame(adjustToTopHalf) end)
hs.hotkey.bind(MASH, "Down", function() operateFrame(adjustToBottomHalf) end)
hs.hotkey.bind(MASH, "Left", function() operateFrame(adjustToLeftHalf) end)
hs.hotkey.bind(MASH, "Right", function() operateFrame(adjustToRightHalf) end)



--------------------------------------------------------------------------------
-- High level functions

function showSpotifyInfo()
    hs.spotify.displayCurrentTrack()

    local positionTotalSeconds = hs.spotify.getPosition()
    local positionMinutes = math.floor(positionTotalSeconds / 60)
    local positionSeconds = math.floor(positionTotalSeconds - positionMinutes * 60)

    local durationTotalSeconds = hs.spotify.getDuration()
    local durationMinutes = math.floor(durationTotalSeconds / 60)
    local durationSeconds = math.floor(durationTotalSeconds - durationMinutes * 60)

    hs.alert.show(string.format('%02d', positionMinutes) .. ':' .. string.format('%02d', positionSeconds) .. ' - ' .. string.format('%02d', durationMinutes) .. ':' .. string.format('%02d', durationSeconds))
end

function operateFrame(operation, optionalRatio1, optionalRatio2)
    initFrames()
    operation(optionalRatio1, optionalRatio2)
    applyFrameChanges()
end

function maximize()
    maximizeWidth()
    maximizeHeight()
end

function resizeAndCenterHorizontallyAndMoveCompletelyToBottom(ratioWidth, ratioHeight)
    resizeWidth(ratioWidth)
    resizeHeight(ratioHeight)
    centerHorizontally()
    moveCompletelyToBottom()
end

function resizeWidthAndMaximizeHeightAndCenter(ratio)
    resizeWidth(ratio)
    maximizeHeight()
    centerHorizontally()
end

function resizeAndCenter(ratio)
    resizeWidth(ratio)
    resizeHeight(ratio)
    centerHorizontally()
    centerVertically()
end

function adjustToRightHalf()
    maximizeHeight()
    resizeWidth(0.5)
    moveCompletelyToRight()
end

function adjustToLeftHalf()
    maximizeHeight()
    resizeWidth(0.5)
    moveCompletelyToLeft()
end

function adjustToTopHalf()
    maximizeWidth()
    resizeHeight(0.5)
    moveCompletelyToTop()
end

function adjustToBottomHalf()
    maximizeWidth()
    resizeHeight(0.5)
    moveCompletelyToBottom()
end



--------------------------------------------------------------------------------
-- Low level functions

function initFrames()
    focusedWindow = hs.window.focusedWindow()
    focusedWindowFrame = focusedWindow:frame()
    screenFrame = focusedWindow:screen():frame()
end

function applyFrameChanges()
    focusedWindow:setFrame(focusedWindowFrame)
end

function maximizeWidth()
    focusedWindowFrame.w = screenFrame.w
    focusedWindowFrame.x = screenFrame.x
end

function maximizeHeight()
    focusedWindowFrame.h = screenFrame.h
    focusedWindowFrame.y = screenFrame.y
end

function resizeWidth(ratio)
    focusedWindowFrame.w = screenFrame.w * ratio
end

function resizeHeight(ratio)
    focusedWindowFrame.h = screenFrame.h * ratio
end

function centerHorizontally()
    focusedWindowFrame.x = screenFrame.x + (screenFrame.w - focusedWindowFrame.w) / 2
end

function centerVertically()
    focusedWindowFrame.y = screenFrame.y + (screenFrame.h - focusedWindowFrame.h) / 2
end

function increaseWidthAtRight(ratio)
    focusedWindowFrame.w = focusedWindowFrame.w + screenFrame.w * ratio
end

function increaseWidthAtLeft(ratio)
    local increment = math.min(focusedWindowFrame.x, screenFrame.w * ratio)
    focusedWindowFrame.x = focusedWindowFrame.x - increment
    focusedWindowFrame.w = focusedWindowFrame.w + increment
end

function increaseHeightAtBottom(ratio)
    focusedWindowFrame.h = focusedWindowFrame.h + screenFrame.w * ratio
end

function increaseHeightAtTop(ratio)
    local increment = math.min(focusedWindowFrame.y - getMinY(), screenFrame.h * ratio)
    focusedWindowFrame.h = focusedWindowFrame.h + increment
    focusedWindowFrame.y = focusedWindowFrame.y - increment
end

function decreaseWidthAtRight(ratio)
    focusedWindowFrame.w = focusedWindowFrame.w - screenFrame.w * ratio
end

function decreaseWidthAtLeft(ratio)
    local decrement = screenFrame.w * ratio
    if (decrement < focusedWindowFrame.w) then
        focusedWindowFrame.x = focusedWindowFrame.x + decrement
        focusedWindowFrame.w = focusedWindowFrame.w - decrement
    end
end

function decreaseWidthAtTop(ratio)
    local decrement = screenFrame.h * ratio
    if (decrement < focusedWindowFrame.h) then
        focusedWindowFrame.y = focusedWindowFrame.y + decrement
        focusedWindowFrame.h = focusedWindowFrame.h - decrement
    end
end

function decreaseWidthAtBottom(ratio)
    focusedWindowFrame.h = focusedWindowFrame.h - screenFrame.h * ratio
end

function moveCompletelyToLeft()
    focusedWindowFrame.x = screenFrame.x
end

function moveCompletelyToRight()
    focusedWindowFrame.x = screenFrame.x + (screenFrame.w - focusedWindowFrame.w)
end

function moveCompletelyToTop()
    focusedWindowFrame.y = screenFrame.y
end

function moveCompletelyToBottom()
    focusedWindowFrame.y = screenFrame.y + (screenFrame.h - focusedWindowFrame.h)
end

function moveToTopKeepingVisibility(ratio)
    focusedWindowFrame.y = focusedWindowFrame.y - screenFrame.h * ratio
end

function moveToBottomKeepingVisibility(ratio)
    local newY = focusedWindowFrame.y + screenFrame.h * ratio
    focusedWindowFrame.y = math.min(newY, getMinY() + screenFrame.h - focusedWindowFrame.h)
end

function moveToLeftKeepingVisibility(ratio)
    local newX = focusedWindowFrame.x - screenFrame.w * ratio
    focusedWindowFrame.x = math.max(0, newX)
end

function moveToRightKeepingVisibility(ratio)
    local newX = focusedWindowFrame.x + screenFrame.w * ratio
    focusedWindowFrame.x = math.min(newX, screenFrame.w - focusedWindowFrame.w)
end

-- Min coordinate Y isn't 0 because of the Mac's menu bar.
function getMinY()
    return hs.window.focusedWindow():screen():frame().y
end



--------------------------------------------------------------------------------
-- Reload config after saving

function reload_config(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.alert.show("[Hammerspoon] Config reloaded")