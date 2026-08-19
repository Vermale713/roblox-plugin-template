-- IMPORTED MODULES
const Framework = require "../Framework"
const Scythe = Framework.Scythe

-- TYPES
type Toolbar = Framework.Toolbar

-- PRIVATE STATE
const _scope = Scythe.scope()

-- PUBLIC MODULE
const Hi = {}

function Hi.OnInit(toolbar: Toolbar)
	const pluginConfig = Framework.GetConfig()
	const pluginName = pluginConfig.Name

	const button =
		toolbar:CreateButton(`Hi_{pluginName}`, "Print 'hi' on click", "rbxassetid://12348119032", "Simple Print")
	button.ClickableWhenViewportHidden = true

	const clickConn = button.Click:Connect(function()
		print "hi"
	end)

	Scythe.add(_scope, clickConn)
end

function Hi.OnStart()
	-- start stuff
end

function Hi.OnUnload()
	if Scythe.isAlive(_scope) then
		Scythe.destroy(_scope)
	end
end

function Hi.OnDeactivate()
	if Scythe.isAlive(_scope) then
		Scythe.destroy(_scope)
	end
end

return Hi
