chcp 65001
mode 300
Get-EventLog -LogName "System" -After ((Get-Date) + (New-TimeSpan -Days -7)) `
  | Where-Object {$_.InstanceID -ne '10016' -and $_.InstanceID -ne '10010' } `
  | Where-Object {$_.InstanceID -ne '1014' } <# there is no dns server #> `
  | Where-Object {$_.InstanceID -ne '134' } <# NtpClient - time-service #> `
  | Where-Object {$_.EntryType -ne 'Information' } `
  | Sort-Object Index
Get-WmiObject -namespace root\wmi -class MSStorageDriver_FailurePredictStatus -ErrorAction Silentlycontinue | Select InstanceName, PredictFailure, Reason | Format-Table -Autosize
Get-Date -Format g
