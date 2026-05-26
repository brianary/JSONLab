# see https://docs.microsoft.com/powershell/scripting/developer/module/how-to-write-a-powershell-module-manifest
# and https://docs.microsoft.com/powershell/module/microsoft.powershell.core/new-modulemanifest
@{
RootModule = 'JSONLab.psm1'
ModuleVersion = '0.0.0.0' # placeholder to be overridden
CompatiblePSEditions = @('Core')
GUID = '13a65c45-772f-4f25-8917-2a0080221fd1'
Author = 'Brian Lalonde'
CompanyName = 'Unknown'
Copyright = 'Copyright © 2026 Brian Lalonde'
Description = 'Cmdlets to query, transform, and update JSON data.'
PowerShellVersion = '7.0'
# RequiredModules = ,'Microsoft.PowerShell.Utility'
FunctionsToExport = @('*') # '*'
CmdletsToExport = @() # '*'
VariablesToExport = @() # '*'
# AliasesToExport = @()
FileList = @('JSONLab.psd1','JSONLab.psm1')
PrivateData = @{
	PSData = @{
		Tags = @('JSON','JSONPointer','data')
		LicenseUri = 'https://github.com/brianary/JSONLab/blob/master/LICENSE'
		ProjectUri = 'https://github.com/brianary/JSONLab/'
		IconUri = 'http://webcoder.info/images/JSONLab.svg'
		# ReleaseNotes = ''
		# PS7: A list of external modules that this module is dependent upon.
		# ExternalModuleDependencies = ,'Microsoft.PowerShell.Utility'
	}
}
}
