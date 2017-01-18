# PsZonar
PowerShell wrapper of selected Zonar web methods.

# Usage

## Get-Jbustrip

~~~powershell
$startingDate = '1/13/2017'
$endingDate = '1/14/2017'
$credential = Get-Credential

$r = Get-Jbustrip -c $credential -sd $startingDate -ed $endingDate
...
~~~~

## Get-MileageByState

~~~powershell
$startingDate = '1/13/2017'
$endingDate = '1/14/2017'
$credential = Get-Credential

$r = Get-MileageByState -c $credential -sd $startingDate -ed $endingDate

$r.gpsmileagelist.assetdist | % {

    # save asset node so it can be used later
    $asset = $_
    
    # generate the query to add to the asset table for each `assetdist` instance
    $query = "INSERT INTO asset (tag,fleet,type,id) VALUES ({0},{1},{2},{3})" -F $_.tag,$_.fleet,$_.type,$_.id
    Write-Debug $query
    
    # perform the INSERT
    Invoke-SqlCmd -ServerInstance 'server_name' -Query $query

    $_.loi | % {

        # generate a query to add a row to the LOI table for each `loi` instance
        $query = "INSERT INTO LOI (parent_id,[from],[to],name,distance) VALUES ({0},'{1}','{2}','{3}',{4})" -F $asset.id, (ConvertFrom-Epoch $_.from), (ConvertFrom-Epoch $_.to), $_.name, $_.distance
        Write-Debug $query
    
        # perform the INSERT
        Invoke-SqlCmd -ServerInstance 'server_name' -Query $query

    } # /foeach loi

} # /assetdist
~~~

# Personnel

- Author: Craig Buchanan
- Contributors: Ben Canine
