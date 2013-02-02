-- awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Vicious library
require("vicious")
-- Load Debian menu entries
require("debian.menu")
require("blingbling")
require("menubar")

-- {{{ Run only one instance per program
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme ..
                              " > /dev/null || (" .. cmd .. ")")
end
-- }}}

config_dir = awful.util.getdir("config")
-- Themes define colours, icons, and wallpapers
beautiful.init( config_dir .. "/themes/itaca/theme.lua")

require("pomodoro")

-- {{{ Some initializations
-- start the composite manager to provide transparency support
-- run_once("xcompmgr -I1 -O1 -Ff")
-- Now these two programs are launched from .xinitrc
run_once('xcalib -c')
run_once('xcalib -co 96 -a')

-- set the local settings
os.setlocale('es_ES.UTF-8')
-- }}}


-- {{{ naughty theme
naughty.config.default_preset.font             = beautiful.notify_font
naughty.config.default_preset.fg               = beautiful.notify_fg
naughty.config.default_preset.bg               = beautiful.notify_bg

naughty.config.default_preset.timeout          = 15
-- naughty.config.default_preset.screen           = 1
-- naughty.config.default_preset.position         = "top_right"
naughty.config.default_preset.margin           = 20
-- naughty.config.default_preset.height           = 80
-- naughty.config.default_preset.width            = 400
naughty.config.default_preset.gap              = 20
-- naughty.config.default_preset.ontop            = true
-- naughty.config.default_preset.icon             = nil
naughty.config.default_preset.icon_size        = 28
naughty.config.default_preset.border_width     = 1
-- naughty.config.default_preset.hover_timeout    = nil

naughty.config.presets.normal.opacity = 0.8
naughty.config.presets.low.opacity = 0.8
naughty.config.presets.critical.opacity = 0.8

-- }}}
-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        -- Check if awesome encountered an error during startup and fell back to
        -- another config (This code will only ever execute for the fallback config)
        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}


-- This is used later as the default terminal and editor to run.
terminal = "roxterm"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Menubar
menubar.cache_entries = true
menubar.app_folders = { "/usr/share/applications/" }
menubar.show_categories = true   -- Change to false if you want only programs to appear in the menu
menubar.set_icon_theme("itaca")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating, --1
    awful.layout.suit.tile.left, --2
    awful.layout.suit.tile.top, --3
    awful.layout.suit.max.fullscreen, --4
}
-- }}}


-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "1","2","3","4","5","6","7","8","9",}, s,
                        layouts[2])
end
-- }}}


-- {{{ Menu
-- Create a laucher widget and a main menu
mydebugmenu = {
    --{ "create rc_test.lua", config_dir .. "/awdt.py new" },
    --{ "edit rc_test.lua", editor .. " " .. config_dir .. "/rc_test.lua" },
    { "CHECK", config_dir .. "/awdt.py check" },
    --{ "init test FullHD", config_dir .. "/awdt.py start -t -d 1"},
    --{ "init test WXGA+", config_dir .. "/awdt.py start -t -s 1440x900 -d 2"},
    { "INIT", config_dir .. "/awdt.py start -s 1440x900 -d 3"},
    --{ "restart awesome", config_dir .. "/awdt.py restart" },
    --{ "stop xephyr", config_dir .. "/awdt.py stop" },
}

myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "debug", mydebugmenu },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "Debian", debian.menu.Debian_menu.Debian },
        { "open terminal", terminal }
    }
})

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}


-- {{{ Wibox
--

-- {{{ Wibox Widgets
-- Widgets to show on Wibox

-- {{{ shutdown widget
shutdown=blingbling.system.shutdownmenu(beautiful.shutdown,
                                        beautiful.accept,
                                        beautiful.cancel)
-- }}}

-- {{{ Mem widget
-- Mem Widget
memwidget = blingbling.classical_graph.new()
memwidget:set_font_size(10)
memwidget:set_height(16)
memwidget:set_h_margin(2)
memwidget:set_width(40)
memwidget:set_filled(true)
memwidget:set_show_text(true)
memwidget:set_filled_color(beautiful.color_dgrey)
memwidget:set_rounded_size(0.6)
--We just want the line of the graph
memwidget:set_graph_color(beautiful.color_green)
--Use transparency on graph line color to reduce the width of line with low resolution screen
memwidget:set_graph_line_color(beautiful.color_green)
memwidget:set_background_color("#00000044")
vicious.register(memwidget, vicious.widgets.mem, "$1", 5)
-- }}}

-- {{{ Network usage widget
my_net=blingbling.net.new()
my_net:set_height(16)
 --activate popup with ip informations on the net widget
my_net:set_ippopup()
my_net:set_show_text(true)
--my_net:set_v_margin(3)
vicious.cache(vicious.widgets.net)
vicious.register(my_net, vicious.widgets.net,
                '<span color="#CC9393">${eth0 down_kb}</span>' ..
                ' <span color="#7F9F7F">${eth0 up_kb}</span>', 2)
-- }}}

-- {{{ Cpu widget
cpu=blingbling.classical_graph.new()
cpu:set_font_size(10)
cpu:set_height(16)
cpu:set_width(40)
cpu:set_show_text(true)
cpu:set_label("$percent %")
cpu:set_graph_color(beautiful.color_red)
--Use transparency on graph line color to reduce the width of line with low resolution screen
cpu:set_graph_line_color(beautiful.color_red)
cpu:set_filled(true)
cpu:set_background_color("#00000044")
cpu:set_filled_color(beautiful.color_dgrey)
cpu:set_rounded_size(0.6)
blingbling.popups.htop(cpu.widget,
       { title_color = beautiful.notify_font,
          user_color = beautiful.notify_fg,
          root_color = beautiful.notify_bg,
          terminal = "roxterm"})
vicious.register(cpu, vicious.widgets.cpu, '$1',2)

--Cores Widgets
mycore1 = blingbling.value_text_box.new()
mycore1:set_width(10)
mycore1:set_height(16)
mycore1:set_filled(true)
mycore1:set_filled_color(beautiful.color_dgrey)
mycore1:set_rounded_size(0.6)
mycore1:set_values_text_color({{"#88aa00ff",0},{"#d4aa00ff", 0.5},{beautiful.color_red,0.75}})
mycore1:set_font_size(10)
mycore1:set_background_color("#00000044")
mycore1:set_label("$percent%")
vicious.register(mycore1, vicious.widgets.cpu, "$2", 3)

mycore2 = blingbling.value_text_box.new()
mycore2:set_width(10)
mycore2:set_height(16)
mycore2:set_filled(true)
mycore2:set_filled_color(beautiful.color_dgrey)
mycore2:set_rounded_size(0.6)
mycore2:set_values_text_color({{"#88aa00ff",0},{"#d4aa00ff", 0.5},{beautiful.color_red,0.75}})
mycore2:set_font_size(10)
mycore2:set_background_color("#00000044")
mycore2:set_label("$percent%")
vicious.register(mycore2, vicious.widgets.cpu, "$3", 3)

mycore3 = blingbling.value_text_box.new()
mycore3:set_width(10)
mycore3:set_height(16)
mycore3:set_filled(true)
mycore3:set_filled_color(beautiful.color_dgrey)
mycore3:set_rounded_size(0.6)
mycore3:set_values_text_color({{"#88aa00ff",0},{"#d4aa00ff", 0.5},{beautiful.color_red,0.75}})
mycore3:set_font_size(10)
mycore3:set_background_color("#00000044")
mycore3:set_label("$percent%")
vicious.register(mycore3, vicious.widgets.cpu, "$4", 3)

mycore4 = blingbling.value_text_box.new()
mycore4:set_width(10)
mycore4:set_height(16)
mycore4:set_filled(true)
mycore4:set_filled_color(beautiful.color_dgrey)
mycore4:set_rounded_size(0.6)
mycore4:set_values_text_color({{"#88aa00ff",0},{"#d4aa00ff", 0.5},{beautiful.color_red,0.75}})
mycore4:set_font_size(10)
mycore4:set_background_color("#00000044")
mycore4:set_label("$percent%")
vicious.register(mycore4, vicious.widgets.cpu, "$5", 3)

mycore5 = blingbling.value_text_box.new()
mycore5:set_width(10)
mycore5:set_height(16)
mycore5:set_filled(true)
mycore5:set_filled_color(beautiful.color_dgrey)
mycore5:set_rounded_size(0.6)
mycore5:set_values_text_color({{"#88aa00ff",0},{"#d4aa00ff", 0.5},{beautiful.color_red,0.75}})
mycore5:set_font_size(10)
mycore5:set_background_color("#00000044")
mycore5:set_label("$percent%")
vicious.register(mycore5, vicious.widgets.cpu, "$6", 3)

mycore6 = blingbling.value_text_box.new()
mycore6:set_width(10)
mycore6:set_height(16)
mycore6:set_filled(true)
mycore6:set_filled_color(beautiful.color_dgrey)
mycore6:set_rounded_size(0.6)
mycore6:set_values_text_color({{"#88aa00ff",0},{"#d4aa00ff", 0.5},{beautiful.color_red,0.75}})
mycore6:set_font_size(10)
mycore6:set_background_color("#00000044")
mycore6:set_label("$percent%")
vicious.register(mycore6, vicious.widgets.cpu, "$7", 3)

mycore7 = blingbling.value_text_box.new()
mycore7:set_width(10)
mycore7:set_height(16)
mycore7:set_filled(true)
mycore7:set_filled_color(beautiful.color_dgrey)
mycore7:set_rounded_size(0.6)
mycore7:set_values_text_color({{"#88aa00ff",0},{"#d4aa00ff", 0.5},{beautiful.color_red,0.75}})
mycore7:set_font_size(10)
mycore7:set_background_color("#00000044")
mycore7:set_label("$percent%")
vicious.register(mycore7, vicious.widgets.cpu, "$8", 3)

mycore8 = blingbling.value_text_box.new()
mycore8:set_width(10)
mycore8:set_height(16)
mycore8:set_filled(true)
mycore8:set_filled_color(beautiful.color_dgrey)
mycore8:set_rounded_size(0.6)
mycore8:set_values_text_color({{"#88aa00ff",0},{"#d4aa00ff", 0.5},{beautiful.color_red,0.75}})
mycore8:set_font_size(10)
mycore8:set_background_color("#00000044")
mycore8:set_label("$percent%")
vicious.register(mycore8, vicious.widgets.cpu, "$9", 3)
-- }}}


-- {{{ Filesystem widget
fsroot = blingbling.value_text_box.new()
fsroot:set_width(25)
fsroot:set_height(16)
fsroot:set_filled(true)
fsroot:set_filled_color(beautiful.color_dgrey)
fsroot:set_rounded_size(0.6)
fsroot:set_values_text_color({{"#88aa00ff",0},{"#d4aa00ff", 0.5},{beautiful.color_red,0.75}})
fsroot:set_font_size(10)
fsroot:set_background_color("#00000044")
fsroot:set_label("/ $percent%")
vicious.register(fsroot, vicious.widgets.fs, "${/ used_p}", 120 )

fshome = blingbling.value_text_box.new()
fshome:set_width(25)
fshome:set_height(16)
fshome:set_filled(true)
fshome:set_filled_color(beautiful.color_dgrey)
fshome:set_rounded_size(0.6)
fshome:set_values_text_color({{"#88aa00ff",0},{"#d4aa00ff", 0.5},{beautiful.color_red,0.75}})
fshome:set_font_size(10)
fshome:set_background_color("#00000044")
fshome:set_label("~/ $percent%")
vicious.register(fshome, vicious.widgets.fs, "${/home used_p}", 120 )
-- }}}

-- {{{ task_warrior menu
 task_warrior=blingbling.task_warrior.new(beautiful.tasks)
 task_warrior:set_task_done_icon(beautiful.task_done)
 task_warrior:set_task_icon(beautiful.task)
 task_warrior:set_project_icon(beautiful.project)
-- }}}

-- Create a wifiwidget
 
-- Wifi widget!!!!
-- It displays the SSID of the net you are connected ( ${ssid} ), the percentage of connectivity ( ${link} )
-- Initialize widget
wifiwidget = widget({ type = "textbox" })
-- Register widget
vicious.register(wifiwidget, vicious.widgets.wifi, "${ssid} ${link}%", 5, "wlan0")
wifiwidget:buttons(awful.util.table.join( awful.button({}, 1,
    function()
        awful.util.spawn_with_shell(terminal .. " -e wicd-curses")
    end)
                    ))
-- {{{ Calendar widget
--my_cal =blingbling.calendar.new({type = "imagebox", image = beautiful.calendar})
--my_cal:set_cell_padding(2)
--my_cal:set_title_font_size(10)
--my_cal:set_font_size(10)
--my_cal:set_inter_margin(1)
--my_cal:set_columns_lines_titles_font_size(10)
--my_cal:set_columns_lines_titles_text_color("#d4aa00ff")
-- }}}

-- {{{ Pomodoro icon
pomodoro_icon = widget({ type = "imagebox" })
pomodoro_icon.image = image(config_dir .. "/pomodoro.png")
-- }}}

-- {{{ MPD
--Mpd widgets
my_mpd=blingbling.mpd_visualizer.new()
my_mpd:set_height(16)
my_mpd:set_width(80)
my_mpd:update()
my_mpd:set_line(true)
--my_mpd:set_h_margin(2)
my_mpd:set_mpc_commands()
my_mpd:set_launch_mpd_client(terminal .. " -e ncmpcpp")
my_mpd:set_show_text(true)
my_mpd:set_font_size(10)
my_mpd:set_graph_color("#d4aa00ff")
my_mpd:set_label("MPD: $artist > $title")
my_mpd_volume=blingbling.volume.new()
my_mpd_volume:set_height(16)
my_mpd_volume:set_width(20)
--my_mpd_volume:set_v_margin(3)
my_mpd_volume:update_mpd()
my_mpd_volume:set_bar(true)
vicious.register(my_mpd, vicious.widgets.mpd,
    function (widget, args)
        if args["{state}"] == "Stop" then
            return " - "
        else
            return args["{Artist}"]..' - '.. args["{Title}"]
        end
    end, 10)
-- }}}

-- {{{ Keyboard widget
kbdcfg = {}
kbdcfg.cmd = "setxkbmap -layout"
kbdcfg.layout = { "es","us" }
kbdcfg.current = 1
kbdcfg.widget = widget({ type = "textbox", align = "right" })
kbdcfg.widget.text = " " .. kbdcfg.layout[kbdcfg.current] .. " "
kbdcfg.switch = function ()
    kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
    local t = " " .. kbdcfg.layout[kbdcfg.current] .. " "
    kbdcfg.widget.text = t
    os.execute( kbdcfg.cmd .. t )
end
kbdcfg.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () kbdcfg.switch() end)
))
-- }}}

-- {{{ Space & Separator
space = widget({ type = "textbox" })
space.width = 10
separator = widget({ type = "imagebox" })
separator.image = image(beautiful.widget_sep)
-- }}}

-- {{{ Create a systray
mysystray = widget({ type = "systray" })
-- }}}


-- Date
datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, "<span color='#e04613'>%a %b %d, %R</span>", 60)
-- Calendar widget to attach to the textclock
require("calendar2")
calendar2.addCalendarToWidget(datewidget)


-- {{{ Wibox itself
-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytasklist = {}


mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )

mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))


for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = "16" })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        --shutdown,
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            mylayoutbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        datewidget,
        --my_cal.widget,
        --task_warrior.widget,
        s == 1 and mysystray or nil,
        kbdcfg.widget,
        fshome.widget,
        fsroot.widget,
        --mycore8.widget, mycore7.widget, mycore6.widget, mycore5.widget, mycore4.widget, mycore3.widget, mycore2.widget, mycore1.widget,
        cpu.widget,
        memwidget.widget,
        wifiwidget,space,
        pomodoro.widget,pomodoro_icon,
        --my_net.widget,
        --my_mpd.widget,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, }, "Up", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey, }, "Down", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Shift" }, "f", function () awful.util.spawn("pcmanfm") end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    --awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    --awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey, "Control" }, "h",     awful.tag.viewprev       ),
    awful.key({ modkey, "Control" }, "l",     awful.tag.viewnext       ),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Music
    awful.key({ }, "XF86AudioLowerVolume",  function () awful.util.spawn_with_shell("pacmd set-sink-volume 0 $(printf '0x%x' $(( $(pacmd dump|grep set-sink-volume|cut -f3 -d' ') - 0xf00))) > /dev/null") end),
    awful.key({ }, "XF86AudioRaiseVolume",  function () awful.util.spawn_with_shell("pacmd set-sink-volume 0 $(printf '0x%x' $(( $(pacmd dump|grep set-sink-volume|cut -f3 -d' ') + 0xf00))) > /dev/null") end),
    awful.key({ }, "XF86AudioMute",  function () awful.util.spawn("pacmd set-sink-volume 0 0") end),

    -- Keyboard extras
    awful.key({ }, "XF86Excel",  function () awful.util.spawn("libreoffice --calc") end),
    awful.key({ }, "XF86Word",  function () awful.util.spawn("libreoffice --writer") end),
    awful.key({ }, "XF86Messenger",  function () awful.util.spawn("xchat") end),
    awful.key({ }, "Scroll_Lock",  function () awful.util.spawn("i3lock -t -i " .. config_dir .. "/panic.png") end),
    awful.key({ }, "XF86TouchpadToggle",  function () awful.util.spawn("") end),
    awful.key({ }, "XF86Eject",  function () awful.util.spawn("eject") end),
    awful.key({ }, "XF86Search",  function () awful.util.spawn("") end),
    awful.key({ }, "XF86Mail",  function () awful.util.spawn("chromium") end),
    awful.key({ }, "XF86HomePage",  function () awful.util.spawn("") end),
    awful.key({ }, "XF86Calculator",  function () awful.util.spawn("") end),
    awful.key({ }, "XF86AudioPrev",  function () awful.util.spawn_with_shell("ncmpcpp prev") end),
    awful.key({ }, "XF86AudioNext",  function () awful.util.spawn_with_shell("ncmpcpp next") end),
    awful.key({ }, "XF86AudioStop",  function () awful.util.spawn_with_shell("ncmpcpp stop") end),
    awful.key({ }, "XF86AudioPlay",  function () awful.util.spawn_with_shell("ncmpcpp play") end),
    awful.key({ }, "XF86Tools",  function () awful.util.spawn(terminal .. " -e ncmpcpp") end),
    awful.key({ }, "XF86WebCam",  function () awful.util.spawn("shutter") end),
    awful.key({ }, "XF86Launch1",  function () awful.util.spawn("") end),


    -- Prompt
    awful.key({ modkey },    "r",     function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey },    "p",     function () menubar.show() end),
    awful.key({ modkey },    "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",
        function (c)
            c:kill()
           --TODO
           --zenity --question --title='Quit?' --text='Quit';
           --if awful.util.pread(" echo $?") == "1\n" then c:kill() end
        end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- xchat
    { rule = { class = "xchat" },
      properties = { tag = tags[1][1],switchtotag = true } },
    -- Chromium
    { rule = { class = "chromium" },
      properties = { tag = tags[1][3],switchtotag = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
