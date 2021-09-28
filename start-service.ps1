# service need to start
$serviceCollection = @("RpcSs", "RpcEptMapper", "DcomLaunch")

# Loop through the service's name array, if service is not running then start the service
foreach ($service in $serviceCollection) {
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

foreach ($service in $serviceCollection) {
  $getStatAfterStart = Get-Service | Where-Object {$_.name -eq $service}
  if ($getStatAfterStart.Status -eq "Running") {
    Write-Output "[Succeed] Service $($getStatAfterStart.DisplayName) is running"
  } else {
    Write-Output "[Error] Service $($getStatAfterStart.DisplayName) is not running"
  }
}
