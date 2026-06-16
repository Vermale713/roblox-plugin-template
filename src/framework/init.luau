--[=[
    Framework.luau
    Framework for a plugin
]=]

-- IMPORTED MODULES
-- const Toolbar = require(script.classes.Toolbar)
const Types = require("@self/Types")
const Display = require("@self/classes/Display")
const Toolbar = require("@self/classes/Toolbar")
const Config = require("@self/internal/Config")

-- TYPES
type Config = Types.Config

type InitOptions = {
	Name: string,
}

-- PRIVATE STATE
const _plugin = script:FindFirstAncestorWhichIsA("Plugin") :: Plugin

const Framework = {}

Framework.Toolbar = Toolbar
Framework.Display = Display

function Framework.init(opts: InitOptions)
	Config.setConfig(function(state: Config)
		state.Name = opts.Name
		return state
	end)
end

return Framework
