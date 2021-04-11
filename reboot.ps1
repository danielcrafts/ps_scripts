	$value = test-path -path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"
	 
	# If path does not exist, return OK status
	if ($value -match "False") {
	echo "OK - No Reboot required"
	$returnCode=0
	}
	 
	# Else return WARNING status
	else {
	Restart-Computer -Force
	$returnCode=1
	}
	 
	exit ($returnCode)