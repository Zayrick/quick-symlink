# dmgbuild settings for the Quick Symlink installer window; used by Scripts/package-dmg.sh.
# Icon positions are icon centers in points from the window's top-left and must match background.swift.
import os

app = defines["app"]
app_name = os.path.basename(app)

format = "UDZO"
filesystem = "HFS+"
files = [app]
symlinks = {"Applications": "/Applications"}
icon = os.path.join(app, "Contents", "Resources", "AppIcon.icns")

background = defines["background"]
window_rect = ((200, 160), (640, 400))
icon_locations = {app_name: (160, 190), "Applications": (480, 190)}
default_view = "icon-view"
icon_size = 128
text_size = 13
show_status_bar = False
show_tab_view = False
show_toolbar = False
show_pathbar = False
show_sidebar = False
show_icon_preview = False
