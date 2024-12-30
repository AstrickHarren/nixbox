# pyright: reportIndexIssue=false, reportAttributeAccessIssue=false

from ignis.widgets import Widget
from ignis.services.hyprland import HyprlandService

hyprland = HyprlandService.get_default()

def workspace_btn(workspace: dict):
    css = ["workspace", "unset"]; 
    if workspace["id"] == hyprland.active_workspace["id"]:
        css.append("active")
    elif workspace["monitorID"] != hyprland.active_workspace["monitorID"]:
        css.append("inactive")

    return Widget.Button(
        css_classes=css,
        on_click=lambda x, id=workspace["id"]: hyprland.switch_to_workspace(id),
        halign="start",
        valign="center",
    )

def scroll_workspaces(direction: str) -> None:
    current = hyprland.active_workspace["id"]
    if direction == "up":
        target = current - 1
        hyprland.switch_to_workspace(target)
    else:
        target = current + 1
        if target == 11:
            return
        hyprland.switch_to_workspace(target)


def workspaces():
    return Widget.EventBox(
        on_scroll_up=lambda x: scroll_workspaces("up"),
        on_scroll_down=lambda x: scroll_workspaces("down"),
        css_classes=["workspaces"],
        visible=hyprland.is_available,
        child=hyprland.bind(
            "workspaces",
            transform=lambda value: [workspace_btn(i) for i in value],
        ),
    )

