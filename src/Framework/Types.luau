export type ToolbarImpl = {
	__index: ToolbarImpl,
	new: (ToolbarSettings) -> Toolbar,
	CreateButton: (Toolbar, string, string, string, string) -> PluginToolbarButton,
}
export type ToolbarProto = {
	_toolbar: PluginToolbar,
	_buttons: { [string]: PluginToolbarButton },
}

export type ToolbarSettings = {
	SharedToolbar: boolean?,
	Name: string,
}

export type Toolbar = setmetatable<ToolbarProto, ToolbarImpl>

export type DisplayImpl = {
	__index: DisplayImpl,
	new: () -> Display,
	CreateOverlay: (Display, string) -> ScreenGui,
	CreateDockWidget: (Display, string, DockWidgetPluginGuiInfo) -> DockWidgetPluginGui,
}
export type DisplayProto = {
	_displays: {},
}

export type Display = setmetatable<DisplayProto, DisplayImpl>

export type PluginConfig = {
	Name: string,
	Version: string,
}

export type Service = {
	[keyof<Service>]: index<Service, keyof<Service>>,
	OnInit: (Toolbar, Display) -> (),
	OnStart: (Toolbar, Display) -> (),
	OnUnload: () -> (),
	OnDeactivate: () -> (),
}

return nil
