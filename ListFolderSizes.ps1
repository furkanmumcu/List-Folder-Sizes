Function ListFolderSizes($path){
    
    #find sub directory names
    $dirs = Get-ChildItem $path | Where-Object {$_.PSIsContainer} | Foreach-Object {$_.Name}
    
    $list = New-Object System.Collections.Specialized.OrderedDictionary

    $sizes = @(0) * $dirs.Count
    for ($i = 0; $i -lt $dirs.Count ; $i++) {
        $newpath = $path + "\" + $dirs[$i]   
        $sizes[$i] = (Get-ChildItem -path $newpath -recurse | Measure-Object -property length -sum ).sum /1MB
        
        $list.Add($dirs[$i],$sizes[$i])
    }
    
    #echo $path
    #echo $sizes[1]
    echo $list
}
