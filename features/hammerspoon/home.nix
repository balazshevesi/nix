{ lib, ... }: {
  home.file.".hammerspoon/init.lua".text = ''
    hs.allowAppleScript(true)
    hs.ipc.cliInstall()

    local scrollStateFile = "/tmp/karabiner-hyper-scroll"
    local scrollActive = false
    local scrollEvents = 0
    local scrollMultiplier = 2.0
    local scrollSteps = 3
    local scrollStepDelay = 1 / 180
    local ignoreNextEvents = 0
    local anchorPosition = nil

    local function postScroll(dx, dy)
      hs.eventtap.event.newScrollEvent({ dx, dy }, {}, "pixel"):post()
      scrollEvents = scrollEvents + 1
    end

    local function postSmoothScroll(dx, dy)
      local stepX = dx / scrollSteps
      local stepY = dy / scrollSteps

      postScroll(stepX, stepY)
      for i = 2, scrollSteps do
        hs.timer.doAfter(scrollStepDelay * (i - 1), function()
          if scrollActive then
            postScroll(stepX, stepY)
          end
        end)
      end
    end

    local function updateScrollActive()
      local nextActive = hs.fs.attributes(scrollStateFile) ~= nil
      if nextActive and not scrollActive then
        anchorPosition = hs.mouse.absolutePosition()
      elseif not nextActive then
        anchorPosition = nil
      end

      scrollActive = nextActive
    end

    hyperScrollStateTimer = hs.timer.doEvery(0.02, updateScrollActive)
    updateScrollActive()

    hyperScrollTap = hs.eventtap.new({
      hs.eventtap.event.types.mouseMoved,
      hs.eventtap.event.types.leftMouseDragged,
      hs.eventtap.event.types.rightMouseDragged,
      hs.eventtap.event.types.otherMouseDragged,
    }, function(event)
      if not scrollActive then
        return false
      end

      if ignoreNextEvents > 0 then
        ignoreNextEvents = ignoreNextEvents - 1
        return false
      end

      local dx = event:getProperty(hs.eventtap.event.properties.mouseEventDeltaX) or 0
      local dy = event:getProperty(hs.eventtap.event.properties.mouseEventDeltaY) or 0
      if dx == 0 and dy == 0 then
        return false
      end

      postSmoothScroll(dx * scrollMultiplier, dy * scrollMultiplier)

      if anchorPosition == nil then
        anchorPosition = hs.mouse.absolutePosition()
      end

      ignoreNextEvents = 1
      hs.mouse.absolutePosition(anchorPosition)

      return true
    end)

    hyperScrollTap:start()
    hyperScrollDebug = function()
      return {
        active = scrollActive,
        anchorPosition = anchorPosition,
        ignoreNextEvents = ignoreNextEvents,
        scrollEvents = scrollEvents,
        tapEnabled = hyperScrollTap:isEnabled(),
      }
    end
  '';

  home.activation.reloadHammerspoon = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    /usr/bin/open -a Hammerspoon >/dev/null 2>&1 || true
    /usr/bin/osascript -e 'tell application "Hammerspoon" to execute lua code "hs.reload()"' >/dev/null 2>&1 || true
  '';
}
