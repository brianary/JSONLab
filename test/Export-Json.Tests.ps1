<#
.SYNOPSIS
Tests exporting a portion of a JSON document, recursively importing references.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Export-Json' -Tag Export-Json -Skip:$skip {
	Context 'Exports a portion of a JSON document, recursively importing references' `
		-Tag ExportJson,Export,Json {
		$NL = [Environment]::NewLine
		It "Given '<InputObject>', selecting '<JsonPointer>' with compressed set to '<Compress>' should return '<Result>'" -TestCases @(
			@{ InputObject = '{d:{a:{b:1,c:{"$ref":"#/d/two"}},two:2}}'
				JsonPointer = '/d/a'; Compress = $false; Result = "{$NL  `"b`": 1,$NL  `"c`": 2$NL}" }
			@{ InputObject = '{d:{a:{b:1,c:{"$ref":"#/d/c"}},c:{d:{"$ref":"#/d/two"}},two:2}}'
				JsonPointer = '/d/a'; Compress = $true; Result = '{"b":1,"c":{"d":2}}' }
		) {
			Param($InputObject, [string] $JsonPointer, [bool] $Compress, [string] $Result)
			$InputObject |Export-Json -JsonPointer $JsonPointer -Compress:$Compress |
				Should -BeExactly $Result -Because 'pipeline should work'
			Export-Json -JsonPointer $JsonPointer -Compress:$Compress -InputObject $InputObject |
				Should -BeExactly $Result -Because 'parameter should work'
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
