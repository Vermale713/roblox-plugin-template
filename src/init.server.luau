const LogService = game:GetService("LogService")

const Framework = require("@self/Framework")

Framework.SetConfig({
	Name = "Test Plugin",
	Version = "0.0.1",
})

Framework.Load(script.Services):andThen(Framework.Start):catch(function(err)
	LogService:Warn(
		"[{PluginName}] has encountered and error while loading services: {Err}",
		{ PluginName = Framework.GetConfig().Name, Err = err }
	)
end)
