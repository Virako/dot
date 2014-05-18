-- pomodoro timer widget
pomodoro = {}
-- tweak these values in seconds to your liking
pomodoro.pause_duration = 300
pomodoro.work_duration = 1200
pomodoro.change = 30
 
pomodoro.pause_title = "Pause finished."
pomodoro.pause_text = "Get back to work!"
pomodoro.work_title = "Pomodoro finished."
pomodoro.work_text = "Time for a pause!"
pomodoro.working = true
pomodoro.left = pomodoro.work_duration
pomodoro.widget = widget({ type = "textbox" })
pomodoro.timer = timer { timeout = 1 }
 
function pomodoro:settime(t)
  if t >= 3600 then -- more than one hour!
    t = os.date("%X", t-3600)
  else
    t = os.date("%M:%S", t)
  end
  self.widget.text = string.format("<b>%s</b>", t)
end
 
function pomodoro:notify(title, text, duration, working)
  naughty.notify {
    bg = "#000000",
    fg = "#ff0000",
    title = title,
    text  = text,
    timeout = 60
  }
 
  pomodoro.left = duration
  pomodoro:settime(duration)
  pomodoro.working = working
end
 
pomodoro:settime(pomodoro.work_duration)
 
pomodoro.widget:buttons(
  awful.util.table.join(
    awful.button({ }, 1, function()
      pomodoro.last_time = os.time()
      pomodoro.timer:start()
    end),
    awful.button({ }, 2, function()
      pomodoro.timer:stop()
    end),
    awful.button({ }, 3, function()
      pomodoro.timer:stop()
      pomodoro.left = pomodoro.work_duration
      pomodoro:settime(pomodoro.work_duration)
    end),
    awful.button({ }, 4, function()
      pomodoro.timer:stop()
      pomodoro:settime(pomodoro.work_duration+pomodoro.change)
      pomodoro.work_duration = pomodoro.work_duration+pomodoro.change
      pomodoro.left = pomodoro.work_duration
    end),
    awful.button({ }, 5, function()
    pomodoro.timer:stop()
    if pomodoro.work_duration > pomodoro.change then
        pomodoro:settime(pomodoro.work_duration-pomodoro.change)
        pomodoro.work_duration = pomodoro.work_duration-pomodoro.change
        pomodoro.left = pomodoro.work_duration
    end
end)
))

pomodoro.timer:add_signal("timeout", function()
  local now = os.time()
  pomodoro.left = pomodoro.left - (now - pomodoro.last_time)
  pomodoro.last_time = now
 
  if pomodoro.left > 0 then
    pomodoro:settime(pomodoro.left)
  else
    if pomodoro.working then
      pomodoro:notify(pomodoro.work_title, pomodoro.work_text,
        pomodoro.pause_duration, false)
    else
      pomodoro:notify(pomodoro.pause_title, pomodoro.pause_text,
        pomodoro.work_duration, true)
    end
    pomodoro.timer:stop()
  end
end)
