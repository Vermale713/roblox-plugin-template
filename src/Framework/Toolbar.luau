-- IMPORTED MODULES
const Types = require "./Types"

-- TYPES
type ToolbarImpl = Types.ToolbarImpl
type ToolbarProto = Types.ToolbarProto
type ToolbarSettings = Types.ToolbarSettings
type Toolbar = Types.Toolbar

-- ALIASES
const plugin = script:FindFirstAncestorWhichIsA "Plugin" :: Plugin

-- PUBLIC MODULE
const Toolbar = {} :: ToolbarImpl
Toolbar.__index = Toolbar

function Toolbar.new(settings: ToolbarSettings)
	return setmetatable({
		_toolbar = plugin:CreateToolbar(settings.Name),
		_buttons = {},
	}, Toolbar)
end

function Toolbar.CreateButton(self, id, tooltip, icon, text)
	const button = self._toolbar:CreateButton(id, tooltip, icon, text)

	self._buttons[id] = button

	return button
end

return Toolbar
