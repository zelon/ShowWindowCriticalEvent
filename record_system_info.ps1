chcp 65001
mode 300
Get-EventLog -LogName "System" -After ((Get-Date) + (New-TimeSpan -Days -7)) `
  | Where-Object {$_.EntryType -ne 'Information' } `
  | Select-Object -Property TimeWritten, Source, EventID, Message `
  | Where-Object {$_.EventID -ne '10016' } <# dcom error #> `
  | Where-Object {$_.EventID -ne '10010' } <# dcom error2 #> `
  | Where-Object {$_.EventID -ne '1014' } <# there is no dns server #> `
  | Where-Object {$_.EventID -ne '134' } <# NtpClient - time-service #> `
  | Where-Object {$_.EventID -ne '15301' } <# make new ssl cerificate #> `
  | Where-Object {$_.EventID -ne '15300' } <# delete new ssl cerificate #> `
  | Sort-Object TimeWritten
Get-WmiObject -namespace root\wmi -class MSStorageDriver_FailurePredictStatus -ErrorAction Silentlycontinue | Select InstanceName, PredictFailure, Reason | Format-Table -Autosize
Get-Date -Format g
