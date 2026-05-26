--[=[
    Framework.luau
    Framework for a plugin
]=]

-- IMPORTED MODULES
local Toolbar = require(script.classes.Toolbar)
local Config = require(script.internal.Config)
local Types = require(script.Types)
local Display = require(script.classes.Display)

-- TYPES
type Config = Types.Config

type InitOptions = {
	Name: string,
}

-- PRIVATE STATE
local _plugin = script:FindFirstAncestorWhichIsA("Plugin") :: Plugin

local Framework = {}

Framework.Toolbar = Toolbar
Framework.Display = Display

function Framework.init(opts: InitOptions)
	Config.setConfig(function(state: Config)
		state.Name = opts.Name
		return state
	end)
end

return Framework
