-- SERVICES
const CoreGui = game:GetService("CoreGui")

-- IMPORTED MODULES
const Internal = require("./Internal")
const Types = require("./Types")

-- TYPES
type DisplayImpl = Types.DisplayImpl
type DisplayProto = Types.DisplayProto
type Display = Types.Display

-- ALIASES
const plugin = script:FindFirstAncestorWhichIsA("Plugin") :: Plugin

-- CONSTANTS

-- PRIVATE STATE

-- PRIVATE FUNCTIONS

-- PRIVATE MODULE

-- PUBLIC MODULE
const Display = {} :: DisplayImpl
Display.__index = Display

function Display.new()
	return setmetatable({
		_displays = {},
	}, Display)
end

function Display.CreateOverlay(self, id)
	const root = Instance.new("ScreenGui")

	root.Name = id
	root.Enabled = false
	root.Parent = CoreGui

	Internal.Janitor:Add(root)

	return root
end

function Display.CreateDockWidget(self, id, info)
	const root = plugin:CreateDockWidgetPluginGuiAsync(id, info)

	root.Name = id
	root.Title = id

	return root
end

return Display
