-- SERVICES
local CoreGui = game:GetService("CoreGui")

-- IMPORTED MODULES
local Config = require(script.Parent.Parent.internal.Config)

-- TYPES
type DisplayType = "DockWidget" | "Overlay"

type DisplayImpl = {
	__index: DisplayImpl,
	new: () -> Display,
	createDockWidget: (self: Display, info: DockWidgetPluginGuiInfo) -> DockWidgetPluginGui,
	createOverlay: (self: Display) -> ScreenGui,
	destroy: () -> (),
}

type DisplayProto = {
	_widget: DockWidgetPluginGui?,
	_overlay: ScreenGui?,
}

export type Display = setmetatable<DisplayProto, DisplayImpl>

-- PRIVATE STATE
local _plugin = script:FindFirstAncestorWhichIsA("Plugin") :: Plugin

local Display = {} :: DisplayImpl
Display.__index = Display

function Display.new(displayType: DisplayType)
	return setmetatable({}, Display)
end

function Display.createDockWidget(self: Display, info: DockWidgetPluginGuiInfo)
	local config = Config.getConfig()
	local root = _plugin:CreateDockWidgetPluginGuiAsync(`Template-{config.Name}`, info)

	root.Title = config.Name
	root.Name = config.Name

	self._widget = root

	return root
end

function Display.createOverlay(self: Display)
	local config = Config.getConfig()
	local root = Instance.new("ScreenGui")

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
