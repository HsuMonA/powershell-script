$outputFile = "F:\devs\powershell\ScanResult.txt"

$computerName = hostname
$os = Get-CimInstance Win32_OperatingSystem
$osName = $os.caption
$osVersion = $os.version
$buildNumber = $os.BuildNumber
$osLanguage = (Get-Culture).DisplayName

$processor = Get-CimInstance Win32_Processor
$processorSpeed = $processor.MaxClockSpeed
$processorName = $processor.Name
$processorCount = $processor.NumberOfLogicalProcessors
$processorCores = $processor.NumberOfCores

$softwareList = Get-WmiObject -Class Win32_Product | Select-Object Name, Vendor, Version

$installDate = $os.InstallDate

$installDir = $env:windir

$cpu = Get-WmiObject -Class Win32_Processor
$architecture = $cpu.AddressWidth

$output = @"
    Computername: $computerName
    OS-Name: $osName
    OS-Version: $osVersion
    Buildnummer: $buildNumber
    OS-Sprache: $osLanguage
    Prozessor-Speed: $processorSpeed
    Prozessor-Name: $processorName
    Anzahl Prozessoren: $processorCount
    Anzahl Kerne: $processorCores
    Installierte Software mit Herstellernamen, Version: $($softwareList | Format-Table | Out-String)
    Installationsdatum: $installDate
    Installationsverzeichnis: $installDir
    Architektur: $architecture
"@

$output | Out-File $outputFile

$output







