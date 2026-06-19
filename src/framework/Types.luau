export type PluginConfig = {
	Name: string,
	Version: string,
}

export type Service = {
	OnInit: () -> (),
	OnStart: () -> (),
}

return nil
