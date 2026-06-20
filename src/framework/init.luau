-- SERVICES

-- IMPORTED MODULES
const Display = require("@self/Display")
const Toolbar = require("@self/Toolbar")
const Types = require("@self/Types")
const Promise = require("./Packages/Promise")

-- TYPES
export type Service = Types.Service
export type PluginConfig = Types.PluginConfig
export type Toolbar = Types.Toolbar
export type Display = Types.Display

-- ALIASES

-- CONSTANTS

-- PRIVATE STATE
local _config: PluginConfig = {
	Name = "Plugin",
	Version = "0.0.0",
}
const _services: { Service } = {}

-- PRIVATE FUNCTIONS
const function createPromiseCleanupFunction(method: "OnUnload" | "OnDeactivate")
	return Promise.new(function(resolve)
		for _, service in _services do
			task.spawn(function()
				const callback = service[method]
				if callback then
					-- Type system bs
					(callback :: () -> ())()
				end
			end)
		end

		resolve()
	end)
end

-- PRIVATE MODULE

-- PUBLIC MODULE
const Framework = {}

Framework.Toolbar = Toolbar

function Framework.SetConfig(config)
	_config = config
end

function Framework.GetConfig()
	return _config
end

function Framework.Load(dir: Instance)
	return Promise.new(function(resolve)
		const children = dir:GetChildren()

		for _, child in children do
			if not child:IsA("ModuleScript") then
				continue
			end

			const mod: Service = (require)(child)
			table.insert(_services, mod)
		end

		resolve()
	end)
end

function Framework.Start()
	return Promise.new(function(resolve)
		table.freeze(_config)
		table.freeze(_services)

		const toolbar = Toolbar.new({
			Name = _config.Name,
		})
		const display = Display.new()

		for _, service in _services do
			if service.OnInit then
				service.OnInit(toolbar, display)
			end
		end

		for _, service in _services do
			task.spawn(function()
				if service.OnStart then
					service.OnStart(toolbar, display)
				end
			end)
		end
	end)
end

function Framework.Deactivate()
	return createPromiseCleanupFunction("OnDeactivate")
end

function Framework.Unload()
	return createPromiseCleanupFunction("OnUnload")
end

return Framework
