const LogService = game:GetService "LogService"

const Framework = require "@self/Framework"
const Vow = Framework.Vow

Framework.SetConfig {
	Name = "Test Plugin",
	Version = "0.0.1",
}

const function loadFramework(): (boolean, any)
	const loadId = Framework.Load(script.Services)
	const didLoad, loadError = Vow.await(loadId)
	Vow.destroy(loadId)

	if not didLoad then
		return false, loadError
	end

	const startId = Framework.Start()
	const didStart, startError = Vow.await(startId)
	Vow.destroy(startId)

	return didStart, startError
end

const didStart, startError = loadFramework()

if not didStart then
	LogService:Warn(
		"[{PluginName}] encountered an error while loading services: {Error}",
		{ PluginName = Framework.GetConfig().Name, Error = startError }
	)
end

plugin.Deactivation:Connect(function()
	Framework.Deactivate()
end)

plugin.Unloading:Connect(function()
	Framework.Unload()
end)
