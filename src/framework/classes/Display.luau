-- SERVICES
const CoreGui = game:GetService("CoreGui")

-- IMPORTED MODULES
const Config = require(script.Parent.Parent.internal.Config)

-- TYPES
type DisplayType = "DockWidget" | "Overlay"

type DisplayImpl = {
	__index: DisplayImpl,
	new: () -> Display,
	createDockWidget: (self: Display, info: DockWidgetPluginGuiInfo) -> DockWidgetPluginGui,
	createOverlay: (self: Display) -> ScreenGui,
	destroy: (self: Display) -> (),
}

type DisplayProto = {
	_widget: DockWidgetPluginGui?,
	_overlay: ScreenGui?,
}

export type Display = setmetatable<DisplayProto, DisplayImpl>

-- PRIVATE STATE
const _plugin = script:FindFirstAncestorWhichIsA("Plugin") :: Plugin

const Display = {} :: DisplayImpl
Display.__index = Display

function Display.new(displayType: DisplayType)
	return setmetatable({}, Display)
end

function Display.createDockWidget(self: Display, info: DockWidgetPluginGuiInfo)
	const config = Config.getConfig()
	const root = _plugin:CreateDockWidgetPluginGuiAsync(`Template-{config.Name}`, info)

	root.Title = config.Name
	root.Name = config.Name

	self._widget = root

	return root
end

function Display.createOverlay(self: Display)
	const config = Config.getConfig()
	const root = Instance.new("ScreenGui")

	root.Name = config.Name
	root.Parent = CoreGui

	self._overlay = root

	return root
end

function Display.destroy(self: Display)
	if self._overlay then
		self._overlay:Destroy()
	end
end

return Display
