Function ListFolderSizes($path, [boolean]$sortBySize){
    #find sub directory names
    $dirs = Get-ChildItem $path -Directory | Foreach-Object {$_.Name}
    
    #create list
    $list = New-Object System.Collections.Specialized.OrderedDictionary

    $sum = 0;
    $sizes = @(0) * $dirs.Count
    for ($i = 0; $i -lt $dirs.Count ; $i++) {
        Write-Progress -Activity "In Progress..." -PercentComplete $dirs.Count

        #sub-folder directory
        $newpath = $path + "\" + $dirs[$i]   
        
        #get folder sizes
        #$sizes[$i] = "{0:N2}" -f ((Get-ChildItem -path $newpath -recurse -File | Measure-Object -property length -sum ).sum /1MB) --one line
        $unformatted = ((Get-ChildItem -path $newpath -recurse -File | Measure-Object -property length -sum ).sum /1MB) #unformatted used for calculation of sum
        $formatted = "{0:N2}" -f $unformatted
        $sizes[$i] = $formatted
        
        #calculate sum
        $sum = $sum + $unformatted

        #add list size of the folder
        $list.Add($dirs[$i],$sizes[$i])
    }
    
    if($sortBySize){
        $list.GetEnumerator() | sort value
    }
    else{
        $list
    }
    echo ""
    
    if($sum -gt 1000){
        $formattedSum = "{0:N2}" -f ($sum/1000)
        echo "Total size of all folders = $formattedSum GB"
    }
    else{
        $formattedSum = "{0:N2}" -f $sum
        echo "Total size of all folders = $formattedSum MB"
    }
}
