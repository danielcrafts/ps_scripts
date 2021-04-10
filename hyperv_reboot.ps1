	$value = test-path -path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"
	 
	if ($value -match "False") {
	echo "OK - No Reboot required"
	$returnCode=0
	}
	
	else {
	Stop-VM * -Force
	$count = ((get-vm).Name | measure).count
	do{
		start-sleep -s 60
		$offline = ((get-vm).State -like "Off" | measure).count
	  }
	while($offline -ne $count)
	Restart-Computer
	}