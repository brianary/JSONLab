# VHS https://github.com/charmbracelet/vhs
Output demo.gif
Hide
Set Shell pwsh
Type "Import-Module ../.publish/JSONLab.psd1"
Enter
Type "Clear-Host"
Enter
Show
Type `'{"":3.14}' |Select-Json /`
Enter
Sleep 2s
Type `'{"a":{"b":true}}' |Select-Json /a/*`
Enter
Sleep 2s
Type "'[1, 2, 3]' |Set-Json /1 0"
Enter
Sleep 2s
Type `'{"list":[1, 2]}' |Set-Json /list/- 3`
Enter
Sleep 2s
Type "'{a:1}' |Resolve-JsonPointer /*"
Enter
Sleep 2s
Type `'{"a":1,"b":{"u":3},"c":{"v":5}}','{"a":{"w":8},"b":2,"c":{"x":6}}' |Merge-Json`
Enter
Sleep 2s
Type `'{d:{a:{b:1,c:{"$ref":"#/d/two"}},two:2}}' |Export-Json /d/a`
Enter
Sleep 9s
