Function ListFolderSizes($path, [boolean]$sortBySize){
    
    #find sub directory names
    $dirs = Get-ChildItem $path -Directory | Foreach-Object {$_.Name}
    
    $list = New-Object System.Collections.Specialized.OrderedDictionary


    $sizes = @(0) * $dirs.Count
    for ($i = 0; $i -lt $dirs.Count ; $i++) {
        $newpath = $path + "\" + $dirs[$i]   
        $sizes[$i] = "{0:N2}" -f ((Get-ChildItem -path $newpath -recurse -File | Measure-Object -property length -sum ).sum /1MB)
        $list.Add($dirs[$i],$sizes[$i])
    }
    
    if($sortBySize){
        $list.GetEnumerator() | sort value
    }
    else{
        $list
    }
}
