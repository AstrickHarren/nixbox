from ignis.services.bluetooth import BluetoothDevice, BluetoothService
from ignis.widgets import Widget, label
from modules.control_center.menu import Menu
from modules.control_center.qs_button import QSButton

bluetooth = BluetoothService.get_default()


class BluetoothItem(Widget.Button):
    def __init__(self, dev: BluetoothDevice):
        super().__init__(
            css_classes=["wifi-network_item", "unset"],
            on_click=lambda x: dev.connect_to(),
            child=Widget.Box(
                child=[
                    Widget.Icon(
                        image=dev.icon_name,
                    ),
                    Widget.Label(
                        label=dev.name,
                        halign="start",
                        css_classes=["wifi-network-label"],
                    ),
                    Widget.Icon(
                        image="object-select-symbolic",
                        halign="end",
                        hexpand=True,
                        visible=dev.bind("connected"),
                    ),
                ]
            ),
        )


class BluetoothMenu(Menu):
    def __init__(self, dev: BluetoothService):
        super().__init__(
            name="bluetooth",
            child=[
                Widget.Box(
                    vertical=True,
                    spacing=20,
                    child=dev.bind(
                        "devices",
                        transform=lambda devs: [
                            BluetoothItem(dev)
                            for dev in devs
                            if dev.name != "" and dev.name is not None
                        ],
                    ),
                )
            ],
        )


class BluetoothButton(QSButton):
    def __init__(self, service: BluetoothService):
        menu = BluetoothMenu(service)

        def toggle_list(x) -> None:
            service.setup_mode = True
            menu.toggle()

        super().__init__(
            label="bluetooth",
            icon_name="bluetooth-connected",
            on_activate=toggle_list,
            on_deactivate=toggle_list,
            active=bluetooth.bind("setup_mode"),
            content=menu,
        )


def bluetooth_control():
    return BluetoothButton(bluetooth)
