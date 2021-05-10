[CmdletBinding()]
param (
	[Switch]$Confirm
)

function Invoke-Hyperfine {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory)]
		[String[]]$Names,

		[Parameter(Mandatory)]
		[String]$Output,

		[Parameter(Mandatory)]
		[String[]]$Commands
	)

	if ($Names.Count -ne $Commands.Count) {
		Write-Error "Not the same number of names as commands"
		return
	}

	$CommandNames = $Names | ForEach-Object { "--command-name", $_ }

	hyperfine --warmup 10 --export-json $Output $CommandNames $Commands
}

function Get-Java-Command {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[String]$Target
	)

	return "java -classpath \`"Java/Implementations/$Target\`" Main"
}

function Get-Haskell-Command {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory)]
		[String]$Target
	)

	return "Haskell\Implementations\$Target\Main.exe"
}

function Build-Haskell {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory)]
		[String]$Target
	)
	Push-Location "Haskell\Implementations\$Target"
	stack ghc -- -O2 Main.hs
	Pop-Location
}

function Build-Java {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory)]
		[String]$Target
	)
	Push-Location "Java\Implementations\$Target"
	javac Main.java
	Pop-Location
}

function Round2 {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[Double]$X
	)
	[Math]::Round($X * 1000, 2)
}

function Add-Ratio {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[PSObject[]]$Results
	)

	if ($Results.Count -eq 0) {
		return $Results
	}

	$Sorted = $Results | Sort-Object -Property 'mean'
	$Min = $Sorted[0].mean

	$Sorted | ForEach-Object {
		[PSCustomObject]$_
		| Add-Member `
			-PassThru `
			-MemberType NoteProperty `
			-Name 'ratio' `
			-Value $($_.mean / $Min)
	}
}

function Format-Result {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[PSObject]$Result,

		[Parameter(Mandatory)]
		[String]$Target
	)

	$SerialName = $Target.ToLower() -replace ' ', '-'

	"\subsubsection{Execution time for $Target implementations}"
	""
	"\begin{table}"
	"    \centering"
	"    \begin{tabular}{|l|r|r|r|r|}"
	"        \hline"
	"        \multicolumn{5}{|c|}{\textbf{$Target}} \\"
	"        \hline"
	"        \textbf{Command} & \textbf{Mean [ms]} & \textbf{Min [ms]} & \textbf{Max [ms]} & \textbf{Relative} \\"
	"        \hline"
	Add-Ratio $Result.results | Sort-Object -Property "mean" -Descending | ForEach-Object {
		$Cmd = $_.command
		$Mean = Round2 $_.mean
		$StdDev = Round2 $_.stddev
		$Min = Round2 $_.min
		$Max = Round2 $_.max
		$Ratio = [Math]::Round($_.ratio, 2)
		"        ${Cmd} & $ $Mean \pm $StdDev $ & $ $Min $ & $ $Max $ & $Ratio \\"
		"        \hline"
	}
	"    \end{tabular}"
	"    \caption{\label{tbl:$SerialName-execution-times}Execution times for $Target implementations}"
	"\end{table}"
}

. .\Impls.ps1

if (!$Confirm) {
	$Question = "$($MyInvocation.MyCommand.Name) is rarely able to get" `
		+ " accurate measures for each case, and will overwrite existing" `
		+ " measurements even if there are statistical deviations in the" `
		+ " measurements. It will warn you if there are statistical" `
		+ " deviations though.`nThe following cases will be measured and" `
		+ " overwritten:`n$($Implementations -join ', ')`nAre you sure you" `
		+ " wish to continue?"
	$Options = '&Yes', '&No'
	$Decision = $Host.UI.PromptForChoice('Time.ps1', $Question, $Options, 1)
	if ($Decision -ne 0) {
		return
	}
}

$OutDir = "Out/Time"
if (!(Test-Path $OutDir)) {
	New-Item -Path $OutDir -ItemType Directory | Out-Null
}

$File = "time_temp.json"
$Implementations
| ForEach-Object {
	Write-Host "Building $_ ..."
	Build-Haskell $_ | Write-Host
	Build-Java $_ | Write-Host
	Write-Host "Benchmarking $_ ..."
	Invoke-Hyperfine `
		-Names "Java: $_", "Haskell: $_" `
		-Output $File `
		-Commands $(Get-Java-Command $_), $(Get-Haskell-Command $_)
	| Write-Host
	Write-Host ""

	$Res = Get-Content $File | ConvertFrom-Json
	Format-Result -Result $Res -Target $_ > "$OutDir/${_}.tex"
}

Start-Sleep -Seconds 1
if (Test-Path $File) {
	Remove-Item $File
}
