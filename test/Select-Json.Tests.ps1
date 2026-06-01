<#
.SYNOPSIS
Tests getting a value from a JSON string or file.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Select-Json' -Tag Select-Json -Skip:$skip {
	Context 'Returns a value from a JSON string or file' -Tag SelectJson,Select,Json {
		It "Selecting '<Pointer>' from '<Json>' returns value '<Result>'" -TestCases @(
			@{ Json = 'true'; Pointer = ''; Result = $true }
			@{ Json = '{"":3.14}'; Pointer = '/'; Result = 3.14 }
			@{ Json = '{a:1}'; Pointer = '/a'; Result = 1 }
			@{ Json = '{a:1,b:2,c:3}'; Pointer = '/b'; Result = 2 }
			@{ Json = '{a:{aa:1,ab:2,ac:3},b:{ba:4,bb:5,bc:6}}'; Pointer = '/b/bc'; Result = 6 }
			@{ Json = '{"a":1, "b": {"ZZ/ZZ": {"AD~BC": 7}}}'; Pointer = '/b/ZZ~1ZZ/AD~0BC'; Result = 7 }
			@{ Json = '{"a":1, "b": {"[*?/]": {"AD~BC": 7}}}'; Pointer = '/b/~4~3~2~1]/AD~0BC'; Result = 7 }
			@{ Json = '{a:1}'; Pointer = '/b'; Result = $null }
			@{ Json = '{name: true, id: false, description: false}'; Pointer = '/name'; Result = $true }
			@{ Json = '[{name: true, id: false, description: false}]'; Pointer = '/0/name'; Result = $true }
			@{ Json = '[{name: true, id: false, description: false}]'; Pointer = '/*/name'; Result = $true }
			@{ Json = '{list:[{name: true, id: false}]}'; Pointer = '/list/0/name'; Result = $true }
			@{ Json = '{list:[{name: true, id: false}]}'; Pointer = '/list/*/name'; Result = $true }
		) {
			Param([string] $Json, [string] $Pointer, $Result)
			$Json |Select-Json -JsonPointer $Pointer |Should -BeExactly $Result -Because 'pipeline should work'
			Select-Json -JsonPointer $Pointer -InputObject $Json |Should -BeExactly $Result -Because 'parameter should work'
		}
		It "Selecting '<Pointer>' from '<Json>' returns structure '<Result>' (as JSON)" -TestCases @(
			@{ Json = '{"a":1, "b": {"ZZ/ZZ": {"AD~BC": 7}}}'; Pointer = '/b'; Result = '{"ZZ/ZZ":{"AD~BC":7}}' }
			@{ Json = '{"a":1, "b": {"[*?/]": {"AD~BC": 7}}}'; Pointer = '/b/~4~3~2~1]'; Result = '{"AD~BC":7}' }
		) {
			Param([string] $Json, [string] $Pointer, $Result)
			$Json |Select-Json -JsonPointer $Pointer |ConvertTo-Json -Compress -Depth 100 |Should -BeExactly $Result -Because 'pipeline should work'
			Select-Json -JsonPointer $Pointer -InputObject $Json |ConvertTo-Json -Compress -Depth 100 |Should -BeExactly $Result -Because 'parameter should work'
		}
		It "Selecting '<Pointer>' (following references) from '<Json>' returns value '<Result>'" -TestCases @(
			@{ Json = '{d:{a:{b:1,c:{"$ref":"#/d/c"}},c:{d:{"$ref":"#/d/two"}},two:2}}'; Pointer = '/d/a/c/d'; Result = 2 }
			@{ Json = '{d:{a:{b:1,c:{"$ref":"#/d/c"}},c:{d:{"$ref":"#/d/two"}},two:2}}'; Pointer = '/*/a/c/*'; Result = 2 }
		) {
			Param([string] $Json, [string] $Pointer, $Result)
			$Json |Select-Json -JsonPointer $Pointer -FollowReferences |Should -BeExactly $Result -Because 'pipeline should work'
			Select-Json -JsonPointer $Pointer -InputObject $Json -FollowReferences |Should -BeExactly $Result -Because 'parameter should work'
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
