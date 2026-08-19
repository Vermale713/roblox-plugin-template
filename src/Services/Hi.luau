-- IMPORTED MODULES
const Framework = require "../Framework"

-- TYPES
type Toolbar = Framework.Toolbar

-- PRIVATE STATE
const _cleaner = Framework.Janitor.new()

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

	_cleaner:Add(clickConn)
end

function Hi.OnStart()
	-- start stuff
end

function Hi.OnUnload()
	_cleaner:Destroy()
end

function Hi.OnDeactivate()
	_cleaner:Destroy()
end

return Hi
