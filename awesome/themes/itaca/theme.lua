-- itaca, awesome3 theme, by joedicastro

--{{{ Main
require("awful.util")

theme = {}

home          = os.getenv("HOME")
config        = awful.util.getdir("config")
shared        = "/usr/share/awesome"
if not awful.util.file_readable(shared .. "/icons/awesome16.png") then
    shared    = "/usr/share/local/awesome"
end
sharedicons   = shared .. "/icons"
sharedthemes  = shared .. "/themes"
themes        = config .. "/themes"
themename     = "/itaca"
if not awful.util.file_readable(themes .. themename .. "/theme.lua") then
       themes = sharedthemes
end
themedir      = themes .. themename
themedir_sky = "~/.config/awesome/themes/sky"

-- {{{ Background.
wallpaper1    = themedir .. "/snake.jpeg"
wallpaper2    = themedir .. "/scorpion.jpg"

if awful.util.file_readable(wallpaper1) then
	theme.wallpaper_cmd = { "awsetbg " .. wallpaper1 }
else
	theme.wallpaper_cmd = { "awsetbg " .. wallpaper2 }
end

if awful.util.file_readable(config .. "/vain/init.lua") then
    theme.useless_gap_width  = "3"
end
--}}}
--}}}

--awesome colors
green="#7fb219"
cyan="#7f4de6"
orange="#e04613"
red="#ff0000"
lblue="#6c9eab"
dblue="#00ccff"
black="#000000"
lgrey="#d2d2d2"
dgrey="#333333"
white="#ffffff"

theme.color_green="#7fb219"
theme.color_cyan="#7f4de6"
theme.color_orange="#e04613"
theme.color_red="#ff0000"
theme.color_lblue="#6c9eab"
theme.color_dblue="#00ccff"
theme.color_black="#000000"
theme.color_lgrey="#d2d2d2"
theme.color_dgrey="#333333"
theme.color_white="#ffffff"

-- {{{ Miscellaneous
theme.font          = "sans 8"
theme.taglist_font  = "sans 8"
theme.tasklist_font = "sans 8"

theme.bg_normal     = black
theme.bg_focus      = lgrey
theme.bg_urgent     = red
theme.bg_minimize   = dgrey

theme.fg_normal     = "#999999"
theme.fg_focus      = red
theme.fg_urgent     = black
theme.fg_minimize   = "#000000"

theme.border_width  = 1
theme.border_normal = "#333333"
theme.border_focus  = orange
theme.border_marked = "#91231c"


theme.bg_widget        = dgray
theme.fg_widget        = red
theme.fg_center_widget = "#636363"
theme.fg_end_widget    = "#ffffff"
theme.fg_off_widget    = "#22211f"

theme.notify_font   = orange
theme.notify_fg     = orange
theme.notify_bg     = black

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.taglist_squares_sel         = themedir .. "/tasklist_f.png"
theme.taglist_squares_unsel       = themedir .. "/tasklist_u.png"
theme.tasklist_floating_icon      = themedir .. "/floating.png"

theme.titlebar_close_button_normal = sharedthemes .. "/default/titlebar/close.png"
theme.titlebar_close_button_focus  = sharedthemes .. "/default/titlebar/closer.png"

theme.menu_submenu_icon = sharedthemes .. "/default/submenu.png"
theme.menu_height   = 16
theme.menu_width    = 180

theme.awesome_icon = themedir .. "/awesome16.png"
-- }}}

-- {{{ Layout icons
theme.layout_tile       = themedir .. "/layouts/tile.png"
theme.layout_tileleft   = themedir .. "/layouts/tileleft.png"
theme.layout_tilebottom = themedir .. "/layouts/tilebottom.png"
theme.layout_tiletop    = themedir .. "/layouts/tiletop.png"
theme.layout_fairv      = themedir .. "/layouts/fairv.png"
theme.layout_fairh      = themedir .. "/layouts/fairh.png"
theme.layout_spiral     = themedir .. "/layouts/spiral.png"
theme.layout_dwindle    = themedir .. "/layouts/dwindle.png"
theme.layout_max        = themedir .. "/layouts/max.png"
theme.layout_fullscreen = themedir .. "/layouts/fullscreen.png"
theme.layout_magnifier  = themedir .. "/layouts/magnifier.png"
theme.layout_floating   = themedir .. "/layouts/floating.png"
-- }}}


-- Define the image to load
theme.mpdicon = config .. "/themes/black_blue/icons/note-48x48.png"
theme.shortcut = config .. "/themes/black_blue/icons/keyboard_shortcut.png"
theme.shutdown = config .. "/themes/black_blue/icons/shutdown.png"
theme.reboot = config .. "/themes/black_blue/icons/reboot.png"
theme.accept = config .. "/themes/black_blue/icons/accept.png"
theme.cancel = config .. "/themes/black_blue/icons/cancel.png"
theme.calendar = config .. "/themes/black_blue/icons/calendar.png"
theme.task = config .. "/themes/black_blue/icons/task.png"
theme.tasks = config .. "/themes/black_blue/icons/tasks.png"
theme.task_done = config .. "/themes/black_blue/icons/task_done.png"
theme.project = config .. "/themes/black_blue/icons/project.png"
theme.udisks_glue = config .. "/themes/black_blue/icons/udisk-glue.png"
theme.usb = config .. "/themes/black_blue/icons/usb.png"
theme.cdrom = config .. "/themes/black_blue/icons/cdrom.png"
--font colors for textbox widget
theme.text_font_color_1 = green
theme.text_font_color_2 = dblue
theme.text_font_color_3 = white


-- Delightful Widget icons
-- Generic icons
theme.delightful_error                          = '/usr/share/icons/gnome/16x16/status/dialog-error.png'
theme.delightful_not_found                      = '/usr/share/icons/gnome/16x16/status/dialog-question.png'

-- CPU widget
theme.delightful_cpu                            = '/usr/share/icons/hicolor/22x22/devices/sensors-applet-cpu.png'

-- Memory widget
theme.delightful_memory                         = '/usr/share/icons/hicolor/22x22/devices/sensors-applet-memory.png'

-- Battery widget
theme.delightful_battery_ac                     = '/usr/share/icons/gnome/16x16/actions/help-about.png'
theme.delightful_battery_full                   = '/usr/share/icons/gnome/16x16/devices/battery.png'
theme.delightful_battery_medium                 = '/usr/share/icons/gnome/16x16/status/battery-low.png'
theme.delightful_battery_low                    = '/usr/share/icons/gnome/16x16/status/battery-caution.png'

-- IMAP widget
theme.delightful_imap_mail_read                 = '/usr/share/icons/gnome/32x32/status/stock_mail-open.png'
theme.delightful_imap_mail_unread               = '/usr/share/icons/gnome/32x32/status/stock_mail-unread.png'

-- Network widget
theme.delightful_network_dialup                 = '/usr/share/icons/gnome/16x16/devices/modem.png'
theme.delightful_network_wired                  = '/usr/share/icons/gnome/16x16/devices/network-wired.png'
theme.delightful_network_wireless               = '/usr/share/icons/gnome/16x16/devices/network-wireless.png'

-- Volume widget
theme.delightful_vol                            = '/usr/share/icons/gnome/16x16/status/audio-volume-high.png'
theme.delightful_vol_max                        = '/usr/share/icons/gnome/16x16/status/audio-volume-high.png'
theme.delightful_vol_med                        = '/usr/share/icons/gnome/16x16/status/audio-volume-medium.png'
theme.delightful_vol_min                        = '/usr/share/icons/gnome/16x16/status/audio-volume-low.png'
theme.delightful_vol_zero                       = '/usr/share/icons/gnome/16x16/status/audio-volume-low.png'
theme.delightful_vol_mute                       = '/usr/share/icons/gnome/16x16/status/audio-volume-muted.png'

-- Weather widget
theme.delightful_weather_clear                  = '/usr/share/icons/gnome/16x16/status/weather-clear.png'
theme.delightful_weather_clear_night            = '/usr/share/icons/gnome/16x16/status/weather-clear-night.png'
theme.delightful_weather_clear_night_000        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-000.png'
theme.delightful_weather_clear_night_010        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-010.png'
theme.delightful_weather_clear_night_020        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-020.png'
theme.delightful_weather_clear_night_030        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-030.png'
theme.delightful_weather_clear_night_040        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-040.png'
theme.delightful_weather_clear_night_050        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-050.png'
theme.delightful_weather_clear_night_060        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-060.png'
theme.delightful_weather_clear_night_070        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-070.png'
theme.delightful_weather_clear_night_080        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-080.png'
theme.delightful_weather_clear_night_090        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-090.png'
theme.delightful_weather_clear_night_100        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-100.png'
theme.delightful_weather_clear_night_110        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-110.png'
theme.delightful_weather_clear_night_120        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-120.png'
theme.delightful_weather_clear_night_130        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-130.png'
theme.delightful_weather_clear_night_140        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-140.png'
theme.delightful_weather_clear_night_150        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-150.png'
theme.delightful_weather_clear_night_160        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-160.png'
theme.delightful_weather_clear_night_170        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-170.png'
theme.delightful_weather_clear_night_190        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-190.png'
theme.delightful_weather_clear_night_200        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-200.png'
theme.delightful_weather_clear_night_210        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-210.png'
theme.delightful_weather_clear_night_220        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-220.png'
theme.delightful_weather_clear_night_230        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-230.png'
theme.delightful_weather_clear_night_240        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-240.png'
theme.delightful_weather_clear_night_250        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-250.png'
theme.delightful_weather_clear_night_260        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-260.png'
theme.delightful_weather_clear_night_270        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-270.png'
theme.delightful_weather_clear_night_280        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-280.png'
theme.delightful_weather_clear_night_290        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-290.png'
theme.delightful_weather_clear_night_300        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-300.png'
theme.delightful_weather_clear_night_310        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-310.png'
theme.delightful_weather_clear_night_320        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-320.png'
theme.delightful_weather_clear_night_330        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-330.png'
theme.delightful_weather_clear_night_340        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-340.png'
theme.delightful_weather_clear_night_350        = '/usr/share/icons/gnome/16x16/status/weather-clear-night-350.png'
theme.delightful_weather_few_clouds             = '/usr/share/icons/gnome/16x16/status/weather-few-clouds.png'
theme.delightful_weather_few_clouds_night       = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night.png'
theme.delightful_weather_few_clouds_night_000   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-000.png'
theme.delightful_weather_few_clouds_night_010   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-010.png'
theme.delightful_weather_few_clouds_night_020   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-020.png'
theme.delightful_weather_few_clouds_night_030   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-030.png'
theme.delightful_weather_few_clouds_night_040   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-040.png'
theme.delightful_weather_few_clouds_night_050   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-050.png'
theme.delightful_weather_few_clouds_night_060   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-060.png'
theme.delightful_weather_few_clouds_night_070   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-070.png'
theme.delightful_weather_few_clouds_night_080   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-080.png'
theme.delightful_weather_few_clouds_night_090   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-090.png'
theme.delightful_weather_few_clouds_night_100   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-100.png'
theme.delightful_weather_few_clouds_night_110   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-110.png'
theme.delightful_weather_few_clouds_night_120   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-120.png'
theme.delightful_weather_few_clouds_night_130   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-130.png'
theme.delightful_weather_few_clouds_night_140   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-140.png'
theme.delightful_weather_few_clouds_night_150   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-150.png'
theme.delightful_weather_few_clouds_night_160   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-160.png'
theme.delightful_weather_few_clouds_night_170   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-170.png'
theme.delightful_weather_few_clouds_night_190   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-190.png'
theme.delightful_weather_few_clouds_night_200   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-200.png'
theme.delightful_weather_few_clouds_night_210   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-210.png'
theme.delightful_weather_few_clouds_night_220   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-220.png'
theme.delightful_weather_few_clouds_night_230   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-230.png'
theme.delightful_weather_few_clouds_night_240   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-240.png'
theme.delightful_weather_few_clouds_night_250   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-250.png'
theme.delightful_weather_few_clouds_night_260   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-260.png'
theme.delightful_weather_few_clouds_night_270   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-270.png'
theme.delightful_weather_few_clouds_night_280   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-280.png'
theme.delightful_weather_few_clouds_night_290   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-290.png'
theme.delightful_weather_few_clouds_night_300   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-300.png'
theme.delightful_weather_few_clouds_night_310   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-310.png'
theme.delightful_weather_few_clouds_night_320   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-320.png'
theme.delightful_weather_few_clouds_night_330   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-330.png'
theme.delightful_weather_few_clouds_night_340   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-340.png'
theme.delightful_weather_few_clouds_night_350   = '/usr/share/icons/gnome/16x16/status/weather-few-clouds-night-350.png'
theme.delightful_weather_fog                    = '/usr/share/icons/gnome/16x16/status/weather-fog.png'
theme.delightful_weather_overcast               = '/usr/share/icons/gnome/16x16/status/weather-overcast.png'
theme.delightful_weather_showers                = '/usr/share/icons/gnome/16x16/status/weather-showers.png'
theme.delightful_weather_scattered_showers      = '/usr/share/icons/gnome/16x16/status/weather-showers-scattered.png'
theme.delightful_weather_snow                   = '/usr/share/icons/gnome/16x16/status/weather-snow.png'
theme.delightful_weather_strom                  = '/usr/share/icons/gnome/16x16/status/weather-storm.png'
theme.delightful_weather_alert                  = '/usr/share/icons/gnome/16x16/status/weather-severe-alert.png'

return theme

-- {{{ Folding for Vim
-- This fold the sections in vim, for a better handling
-- vim:foldmethod=marker
-- }}}
