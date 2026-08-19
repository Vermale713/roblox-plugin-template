-- IMPORTED MODULES
const Display = require "@self/Display"
const Internal = require "@self/Internal"
const Toolbar = require "@self/Toolbar"
const Types = require "@self/Types"
const Vow = require "./Packages/Vow"
const Scythe = require "./Packages/Scythe"

-- TYPES
export type Service = Types.Service
export type PluginConfig = Types.PluginConfig
export type Toolbar = Types.Toolbar
export type Display = Types.Display

-- PRIVATE STATE
local _config: PluginConfig = {
	Name = "Plugin",
	Version = "0.0.0",
}
const _services: { Service } = {}

-- PRIVATE FUNCTIONS
const function createVowCleanupFunction(method: "OnUnload" | "OnDeactivate")
	return Vow.new(function(id)
		for _, service in _services do
			task.spawn(function()
				const callback = service[method]
				if callback then
					(callback :: () -> ())()
				end
			end)
		end

		Vow.resolve(id)
	end)
end

-- PUBLIC MODULE
const Framework = {}

Framework.Toolbar = Toolbar
Framework.Display = Display
Framework.Scythe = Scythe
Framework.Vow = Vow

function Framework.SetConfig(config)
	_config = config
end

function Framework.GetConfig()
	return _config
end

function Framework.Load(dir: Instance)
	return Vow.new(function(id)
		const children = dir:GetChildren()

		for _, child in children do
			if not child:IsA "ModuleScript" then
				continue
			end

			const mod: Service = (require)(child)
			table.insert(_services, mod)
		end

		Vow.resolve(id)
	end)
end

function Framework.Start()
	return Vow.new(function(id)
		table.freeze(_config)
		table.freeze(_services)

		const toolbar = Toolbar.new {
			Name = _config.Name,
		}
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

		Vow.resolve(id)
	end)
end

function Framework.Deactivate()
	const id = createVowCleanupFunction "OnDeactivate"

	Vow.await(id)

	Vow.destroy(id)
end

function Framework.Unload()
	const id = createVowCleanupFunction "OnUnload"

	Vow.await(id)

	Scythe.destroy(Internal.Scythe)

	Vow.destroy(id)
end

return Framework
