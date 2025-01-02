from ignis.app import IgnisApp
from ignis.utils import Utils
from modules.bar import bar
from modules.control_center import control_center
from modules.notification import NotificationPopup

app = IgnisApp.get_default()
app.apply_css(f"{Utils.get_current_dir()}/style.scss")

control_center()
for monitor in range(Utils.get_n_monitors()):
    bar(monitor)
for monitor in range(Utils.get_n_monitors()):
    NotificationPopup(monitor)
