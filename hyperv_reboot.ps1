	Stop-VM * -Force
	$count = ((get-vm).Name | measure).count
	$offline = ((get-vm).State -like "Off" | measure).count
	do{
		start-sleep -s 60
	  }
	while($offline -ne $count)
	Restart-Computer