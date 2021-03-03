$source = "C:\Program Files\Steinberg\VSTPlugins\Powered Plugins"
$destination = "C:\Program Files\VSTPlugins\UAD"

$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$testadmin = $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
if ($testadmin -eq $false) {
Start-Process powershell.exe -Verb RunAs -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}" -Elevated' -f ($myinvocation.MyCommand.Definition))
exit
}

Write-Host ".............................................................
:::::::::::::::'##::::'##::::'###::::'########:::::::::::::::
::::::::::::::: ##:::: ##:::'## ##::: ##.... ##::::::::::::::
::::::::::::::: ##:::: ##::'##:. ##:: ##:::: ##::::::::::::::
::::::::::::::: ##:::: ##:'##:::. ##: ##:::: ##::::::::::::::
::::::::::::::: ##:::: ##: #########: ##:::: ##::::::::::::::
::::::::::::::: ##:::: ##: ##.... ##: ##:::: ##::::::::::::::
:::::::::::::::. #######:: ##:::: ##: ########:::::::::::::::
:::::::::::::::::.......:::..:::::..::........:::::::::::::::
:'########::'##:::::::'##:::'##::'######::::'####::'##::: ##:
: ##.... ##: ##::::::: ##::: ##:'##... ##:::. ##::: ###:: ##:
: ##:::: ##: ##::::::: ##::: ##: ##:::..::::: ##::: ####: ##:
: ########:: ##::::::: ##::: ##: ##::'####::: ##::: ## ## ##:
: ##.....::: ##::::::: ##::: ##: ##::: ##:::: ##::: ##. ####:
: ##:::::::: ##::::::: ##::: ##: ##::: ##:::: ##::: ##:. ###:
: ##:::::::: ########:. ######::. ######::::'####:: ##::. ##:
:..:::::::::........:::.......::::......:::::....::..::::..::
::'######:::'#######::'#######::'########:'#######:'#######::
: ##... ##:'##.... ##: ##... ##:... ##..:: ##....:: ##... ##:
: ##:::..:: ##:::: ##: ##::: ##:::: ##:::: ##:::::: ##::: ##:
:: ######:: ##:::: ##: #######::::: ##:::: ######:: #######::
:::.... ##: ##:::: ##: ##. ##:::::: ##:::: ##..:::: ##. ##:::
:'##::: ##: ##:::: ##: ##:. ##::::: ##:::: ##:::::: ##:. ##::
:: ######::. #######:: ##::. ##:::: ##:::: #######: ##::. ##:
:::.....::::.......:::..::::..:::::..:::::.......::..::::..::
" -BackgroundColor DarkBlue -ForegroundColor Gray

Write-Host "Hi!

This is a little script that quickly organizes your UAD Plugin folder into three folders:
- Demos (unused demos)
- Expired (expired demos)
All authorized plugins

The plugins will be moved
from: " -NoNewline
Write-Host "$source" -ForegroundColor Red
Write-Host "to: " -NoNewline
Write-Host "$destination" -ForegroundColor Red

Write-Host "
If you wish to change these directories, just edit the first two lines of the script."

Read-Host -Prompt "
Press Enter to continue.."

#Save Detailed System Profile
#Start-Process "C:\Program Files (x86)\Universal Audio\Powered Plugins\UADPerfMon.exe"
#Add-Type -AssemblyName System.Windows.Forms
#Add-Type -AssemblyName Microsoft.VisualBasic
#[Microsoft.VisualBasic.Interaction]::AppActivate("UAD Performance Monitor")
#Start-Sleep 3
#[System.Windows.Forms.SendKeys]::SendWait('^{s}')

Write-Host "Open " -NoNewline
Write-Host "UAD Control Panel" -ForegroundColor Yellow -NoNewline
Write-Host " and select " -NoNewline
Write-Host "System Info" -ForegroundColor Yellow -NoNewLine
Write-Host ".
Select " -NoNewLine
Write-Host "Save Detailed System Profile" -ForegroundColor Yellow -NoNewLine
Read-Host -Prompt " and save to Desktop or Script Directory.

Hit Enter when done"

#Parsing System Profile
Set-Location $PSScriptRoot
do {
    try{
        $pluginList = Get-Content ".\UADSystemProfile.txt" -ErrorAction SilentlyContinue
        if(-not ($pluginList)){
            $pluginList = Get-Content "~\Desktop\UADSystemProfile.txt" -ErrorAction Stop
        }
    }
    catch {
         Read-Host -Prompt "UADSystemProfile.txt not found. Please place it on ~\Desktop or in Script Directory and hit Enter"
    }
} until ($pluginList)

$pluginList = $pluginList -replace '^UAD System Info'
$pluginList = $pluginList -replace '^UAD Software Release Version'
$pluginList = $pluginList | Select-String '^UAD '

$pluginList = $pluginList -replace ' Bass Amplifier'
$pluginList = $pluginList -replace ' Bass Enhancer'
$pluginList = $pluginList -replace ' Digital Reverb'
$pluginList = $pluginList -replace ' Spring Reverb'
$pluginList = $pluginList -replace ' Ambience Recovery'
$pluginList = $pluginList -replace ' Guitar Amplifier'
$pluginList = $pluginList -replace ' Amplifier'
$pluginList = $pluginList -replace ' Audio Leveler'
$pluginList = $pluginList -replace ' Digital Delay'
$pluginList = $pluginList -replace ' Digital Reverb'
$pluginList = $pluginList -replace ' and Effects'
$pluginList = $pluginList -replace ' Distortion'
$pluginList = $pluginList -replace ' Dynamics'
$pluginList = $pluginList -replace ' Envelope Shaper'
$pluginList = $pluginList -replace ' Leveler'
$pluginList = $pluginList -replace ' Reverb'
$pluginList = $pluginList -replace ' Phase Alignment'
$pluginList = $pluginList -replace ' Tape Recorder'
$pluginList = $pluginList -replace ' Reverb'
$pluginList = $pluginList -replace ' Room Modeler'
$pluginList = $pluginList -replace ' Saturation'
$pluginList = $pluginList -replace ' Subharmonic Synth'
$pluginList = $pluginList -replace ' Tape Delay'
$pluginList = $pluginList -replace ' Tube Preamp and EQ'

$pluginList = $pluginList -replace '2500 Bus Compressor','2500'
$pluginList = $pluginList -replace 'SVT-3 Pro','SVT3Pro'
$pluginList = $pluginList -replace 'SVT-VR','SVTVR'
$pluginList = $pluginList -replace 'Cambridge EQ','Cambridge'
$pluginList = $pluginList -replace 'Bender EQ','Bender'
$pluginList = $pluginList -replace 'Cube Delay','Cube'
$pluginList = $pluginList -replace '160 Compressor','160'
$pluginList = $pluginList -replace 'EL8 Distressor Compressor','Distressor'
$pluginList = $pluginList -replace '670 Legacy Limiter','670 Legacy'
$pluginList = $pluginList -replace 'Legacy EQ','Legacy'
$pluginList = $pluginList -replace 'EQ4 EQ','EQ4'
$pluginList = $pluginList -replace 'Mu Limiter','Mu'
$pluginList = $pluginList -replace 'VOXBOX Channel Strip','VOXBOX'
$pluginList = $pluginList -replace 'Legacy Filter','Filter'
$pluginList = $pluginList -replace '1084 Preamp and EQ','1084'
$pluginList = $pluginList -replace '88RS Legacy Channel Strip','88RS Legacy'
$pluginList = $pluginList -replace '8-bit Filter Effects','8-bit Effects'
$pluginList = $pluginList -replace 'Oxford Limiter V2','Oxford Limiter'
$pluginList = $pluginList -replace 'Oxide','Oxide Tape'
$pluginList = $pluginList -replace 'Multiband Compressor','Multiband'
$pluginList = $pluginList -replace 'CE-1 Chorus','CE-1'
$pluginList = $pluginList -replace 'Dimension D Chorus','Dimension D'
$pluginList = $pluginList -replace 'TLA-100A Compressor','TLA-100A'
$pluginList = $pluginList -replace 'CL 1B Compressor','CL 1B'
$pluginList = $pluginList -replace 'UAD UAD','UAD'
$pluginList = $pluginList -replace 'VT-737sp Channel Strip','VT-737sp'
$pluginList = $pluginList -replace 'LA-2A Legacy Leveler','LA-2A Legacy'
$pluginList = $pluginList -replace '1176LN Legacy Limiter','1176LN Legacy'
$pluginList = $pluginList -replace '1176SE Legacy Limiter','1176SE Legacy'
$pluginList = $pluginList -replace 'EQP-1A Legacy EQ','EQP-1A Legacy'
$pluginList = $pluginList -replace 'ENGL 646','ENGL E646'
$pluginList = $pluginList -replace 'ENGL 765','ENGL E765'
$pluginList = $pluginList -replace 'Gallien-Krueger','Gallien Krueger'
$pluginList = $pluginList -replace 'TS808 Overdrive','TS808'
$pluginList = $pluginList -replace 'NSEQ-2 EQ','NSEQ-2'
$pluginList = $pluginList -replace 'EMT 140 Plate','EMT 140'
$pluginList = $pluginList -replace 'A-Range EQ','A-Range'
$pluginList = $pluginList -replace 'VSC-2 Compressor','VSC-2'
$pluginList = $pluginList -replace 'VSM-3 Saturator','VSM-3'

$pluginList = $pluginList -replace '500 EQ Collection','550A & API 560'
$pluginList = $pluginList -replace 'bx_digital V2 EQ','bx_digital V2 & bx_digital V2 Mono'
$pluginList = $pluginList -replace 'bx_digital V3 EQ Collection','bx_digital V3 & bx_digital V3 mix'
$pluginList = $pluginList -replace 'BAX EQ Collection','BAX EQ Master & Dangerous BAX EQ Mix'
$pluginList = $pluginList -replace 'alpha compressor','alpha master & elysia alpha mix'
$pluginList = $pluginList -replace 'EL7 FATSO Compressor','FATSO Jr & Empirical Labs FATSO Sr'
$pluginList = $pluginList -replace 'Tube Limiter Collection','660 & Fairchild 670'
$pluginList = $pluginList -replace 'Friedmans Collection','Friedman BE100 & Friedman DS40'
$pluginList = $pluginList -replace '32C EQ','32C SE & Harrison 32C'
$pluginList = $pluginList -replace '69 Preamp and EQ Collection','69 Legacy & Helios Type 69'
$pluginList = $pluginList -replace 'Massive Passive EQ Collection','Massive Passive MST & Manley Massive Passive'
$pluginList = $pluginList -replace 'Massenburg DesignWorks MDWEQ5 EQ','MDWEQ5-3B & MDWEQ5-5B'
$pluginList = $pluginList -replace 'Filter Collection','Filter SE & Moog Multimode Filter XL & Moog Multimode Filter'
$pluginList = $pluginList -replace '1073 Preamp and EQ Collection','1073 Legacy & Neve 1073 & Neve 1073SE Legacy'
$pluginList = $pluginList -replace '1081 EQ','1081 & Neve 1081SE'
$pluginList = $pluginList -replace '31102 EQ','31102 & Neve 31102SE'
$pluginList = $pluginList -replace '88RS Channel Strip Collection','88RS & Neve 88RS Legacy'
$pluginList = $pluginList -replace 'Ocean Way Microphone Collection','Ocean Way Mic Collection 180 & Ocean Way Mic Collection'
$pluginList = $pluginList -replace 'Pultec Passive EQ Collection','Pultec EQP-1A & Pultec EQP-1A Legacy & Pultec HLF-3C & Pultec MEQ-5'
$pluginList = $pluginList -replace 'Putnam Microphone Collection','Putnam Mic Collection 180 & Putnam Mic Collection'
$pluginList = $pluginList -replace '4000 E Channel Strip Collection','E Channel Strip & SSL E Channel Strip Legacy'
$pluginList = $pluginList -replace '4000 G Bus Compressor Collection','G Bus Compressor & SSL G Bus Compressor Legacy'
$pluginList = $pluginList -replace 'LA-2A Collection','LA-2 & Teletronix LA-2A Gray & Teletronix LA-2A Legacy & Teletronix LA-2A Silver & Teletronix LA-3A'
$pluginList = $pluginList -replace 'Tilt EQ','Tilt & Tonelux Tilt Live'
$pluginList = $pluginList -replace 'Sphere Mic Modeler','Sphere 180 & Townsend Labs Sphere'
$pluginList = $pluginList -replace 'Tube-Tech EQ Collection','Tube-Tech ME 1B & Tube-Tech PE 1C'
$pluginList = $pluginList -replace '1176 Limiter Collection','1176 Rev A & UA 1176AE & UA 1176LN Legacy & UA 1176LN Rev E & UA 1176SE Legacy'
$pluginList = $pluginList -replace '175B and 176 Tube Compressor Collection','175-B & UA 176'
$pluginList = $pluginList -replace '33609 Stereo Limiter Compressor','33609SE & Neve 33609 C'
$pluginList = $pluginList -replace 'Precision Mix Rack Collection','Precision Channel Strip & Precision Delay Mod & Precision Delay Mod L & Precision Reflection Engine & CS-1'
$pluginList = $pluginList -replace 'Neve Collection','Neve 2254 E Dual & Neve 2254 E & Neve 33609 C'

if (-not (Test-Path -Path ".\Logs")) { New-Item -Path ".\Logs" -ItemType Directory }
$pluginList | Set-Content ".\Logs\PluginList.txt"

#Organizing
$authorized = $pluginList | Select-String ': Authorized for all devices'
$authorized = $authorized -replace ': Authorized for all devices','.dll'
$authorized = $authorized -replace ' & ','.dll
UAD '
$authorized | Set-Content ".\Logs\Authorized.txt"
$authorized = Get-Content ".\Logs\Authorized.txt"
if ($authorized) { $authorized = Get-Content ".\Logs\Authorized.txt" }

$demo = $pluginList | Select-String ': Demo not started'
$demo = $demo -replace ': Demo not started','.dll'
$demo = $demo -replace ' & ','.dll
UAD '
$demo | Set-Content ".\Logs\DemoNotStarted.txt"
$demo = Get-Content ".\Logs\DemoNotStarted.txt"
if ($demo) { $demo = Get-Content ".\Logs\DemoNotStarted.txt" }

$expired = $pluginList | Select-String ': Demo expired'
$expired = $expired -replace ': Demo expired','.dll'
$expired = $expired -replace ' & ','.dll
UAD '
$expired | Set-Content ".\Logs\DemoExpired.txt"
if ($expired) { $expired = Get-Content ".\Logs\DemoExpired.txt" }

#Create directories if they don't exist
$monoSource = Join-Path -Path $source -ChildPath "Mono"
$demoPath = Join-Path -Path $destination -ChildPath "Demos"
$expiredPath = Join-Path -Path $destination -ChildPath "Expired"
$monoPath = Join-Path -Path $destination -ChildPath "Mono"
$demoMonoPath = Join-Path -Path $demoPath -ChildPath "Mono"
$expiredMonoPath = Join-Path -Path $expiredPath -ChildPath "Mono"

if (-not (Test-Path -Path $destination)) { New-Item -Path $destination -ItemType Directory }
if (-not (Test-Path -Path $demoPath)) { New-Item -Path $demoPath -ItemType Directory }
if (-not (Test-Path -Path $expiredPath)) { New-Item -Path $expiredPath -ItemType Directory }
if (-not (Test-Path -Path $monoPath)) { New-Item -Path $monoPath -ItemType Directory }
if (-not (Test-Path -Path $demoMonoPath)) { New-Item -Path $demoMonoPath -ItemType Directory }
if (-not (Test-Path -Path $expiredMonoPath)) { New-Item -Path $expiredMonoPath -ItemType Directory }

#Reset
Get-ChildItem -Path $destination ".\*.dll" | Move-Item -Destination $source
Get-ChildItem -Path $demoPath ".\*.dll" | Move-Item -Destination $source
Get-ChildItem -Path $expiredPath ".\*.dll" | Move-Item -Destination $source

Get-ChildItem -Path $monoPath ".\*.dll" | Move-Item -Destination $monoSource
Get-ChildItem -Path $demoMonoPath ".\*.dll" | Move-Item -Destination $monoSource
Get-ChildItem -Path $expiredMonoPath ".\*.dll" | Move-Item -Destination $monoSource

#Moving
Get-ChildItem $source -File | 
Where-Object { $_.Name -In $authorized } | 
Move-Item -Destination $destination -Force

Get-ChildItem $source -File | 
Where-Object { $_.Name -In $demo } | 
Move-Item -Destination $demoPath -Force

Get-ChildItem $source -File | 
Where-Object { $_.Name -In $expired } | 
Move-Item -Destination $expiredPath -Force

$authorizedMono = $authorized -replace '.dll','(m).dll'
Get-ChildItem $monoSource -File | 
Where-Object { $_.Name -In $authorizedMono } | 
Move-Item -Destination $monoPath -Force

$demoMono = $demo -replace '.dll','(m).dll'
Get-ChildItem $monoSource -File | 
Where-Object { $_.Name -In $demoMono } | 
Move-Item -Destination $demoMonoPath -Force

$expiredMono = $expired -replace '.dll','(m).dll'
Get-ChildItem $monoSource -File | 
Where-Object { $_.Name -In $expiredMono } | 
Move-Item -Destination $expiredMonoPath -Force

#Finish
Read-Host -Prompt "UAD Plugins sorted successfully! Press Enter to exit"
