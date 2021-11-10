param (
    [Parameter()]
    [String[]]
    $Services
)

# Loop through the service's name array, if service is not running then start the service
foreach ($service in $Services) {

  for ($i = 0; $i -lt 3; $i++) {

    $getServiceStatus = Get-Service | Where-Object { $_.name -eq $service }
    if ($getServiceStatus.Status -eq "Running") {

      Continue

    }

    else {

      Start-Service -Name $service
      Start-Sleep -Seconds 2

    }

  }

}


foreach ($service in $Services) {

  $getStatAfterStart = Get-Service | Where-Object {$_.name -eq $service}
  if ($getStatAfterStart.Status -eq "Running") {

    Write-Output "[INFO] Service $($service) is running"

  } else {

    Write-Output "[ERROR] Service $($service) is not running"

  }

}
