-- IMPORTED MODULES
const Config = require(script.Parent.Parent.internal.Config)

-- TYPES
type ToolbarImpl = {
	__index: ToolbarImpl,
	new: () -> Toolbar,
	createButton: (self: Toolbar, id: string, tooltip: string, icon: string, text: string?) -> PluginToolbarButton,
}

type ToolbarProto = {
	_toolbar: PluginToolbar,
	_buttons: { [string]: PluginToolbarButton },
}

export type Toolbar = setmetatable<ToolbarProto, ToolbarImpl>

-- PRIVATE STATE
const _plugin = script:FindFirstAncestorWhichIsA("Plugin") :: Plugin

const Toolbar = {} :: ToolbarImpl
Toolbar.__index = Toolbar

function Toolbar.new(): Toolbar
	const config = Config.getConfig()

	const toolbar = _plugin:CreateToolbar(config.Name)

	return setmetatable({
		_toolbar = toolbar,
		_buttons = {},
	}, Toolbar)
end

function Toolbar.createButton(self: Toolbar, id: string, tooltip: string, icon: string, text: string?)
	const button = self._toolbar:CreateButton(id, tooltip, icon, text)

	self._buttons[id] = button

	return button
end

return Toolbar
