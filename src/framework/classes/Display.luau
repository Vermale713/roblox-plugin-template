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
}

type DisplayProto = {}

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

	return root
end

function Display.createOverlay(self: Display)
	local config = Config.getConfig()
	local root = Instance.new("ScreenGui")

	root.Name = config.Name
	root.Parent = CoreGui

	return root
end

return Display
