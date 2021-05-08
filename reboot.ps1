	param
	(
	$typ = "0"
	)
	$value = test-path -path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"
	 
	#$typ=Client
	if (($value -match "true") -and ((Get-CimInstance Win32_OperatingSystem -Property *).Name -match "Business") -and ($typ -match "Client")) {
	Restart-Computer -Force
	}
	
	#$typ=Hyperv
	if (($value -match "true") -and ((Get-CimInstance Win32_OperatingSystem -Property *).Name -match "Server") -and ($typ -match "HyperV") -and ((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V).state -match "enabled")) {
	Stop-VM * -Force
	$count = ((get-vm).Name | measure).count
	do{
		start-sleep -s 60
		$offline = ((get-vm).State -like "Off" | measure).count
	  }
	while($offline -ne $count)
	Restart-Computer -Force
	}

	#$typ=Server
	if (($value -match "true") -and ((Get-CimInstance Win32_OperatingSystem -Property *).Name -match "Server") -and ($typ -match "Server") -and ((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V).state -match "Disabled")) {
	Restart-Computer -Force
	}
	