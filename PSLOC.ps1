$HaskellPSLOCFilter = '^\s*--|^\s*$'
$JavaPSLOCFilter = '^\s*//|^\s*/\*|^\s*\*/|^\s*\* |^\s*$'

function Get-Content-PSLOC {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[String]$Path,

		[Parameter(Mandatory)]
		[String]$Filter
	)

	$Res = Get-Content $Path | Where-Object -FilterScript { $_ -notmatch $Filter }
	$Res.Count
}

function Get-PSLOC {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[String]$Target,

		[Parameter(Mandatory)]
		[String]$Ext,

		[Parameter(Mandatory)]
		[String]$RootDir,

		[Parameter(Mandatory)]
		[ScriptBlock]$GetFilePSLOC
	)

	$TargetDir = "$RootDir\Implementations\$Target"
	$Total = 0
	$Res = Get-ChildItem -Path $TargetDir -File -Name -Recurse -Include "*.$Ext"
	| ForEach-Object {
		$PSLOC = & $GetFilePSLOC "$TargetDir\$_"
		$Total += $PSLOC
		[PSCustomObject]@{
			File  = $_
			PSLOC = $PSLOC
		}
	}
	$Res += [PSCustomObject]@{
		File  = "Total"
		PSLOC = $Total
	}
	return $Res
}

function Get-Haskell-Files-PSLOC {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[String]$Target
	)

	Get-PSLOC -Target $Target -Ext 'hs' -RootDir 'Haskell' -GetFilePSLOC {
		param(
			[String]$Path
		)
		Get-Content-PSLOC -Path $Path -Filter $HaskellPSLOCFilter
	}
}

function Get-Java-Files-PSLOC {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[String]$Target
	)

	Get-PSLOC -Target $Target -Ext 'java' -RootDir 'Java' -GetFilePSLOC {
		param(
			[String]$Path
		)
		Get-Content-PSLOC -Path $Path -Filter $JavaPSLOCFilter
	}
}


function Format-Result {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[String]$Target,

		[Parameter(Mandatory)]
		[PSCustomObject[]]$HaskellPSLOC,

		[Parameter(Mandatory)]
		[PSCustomObject[]]$JavaPSLOC
	)

	$SerialName = $Target.ToLower() -replace ' ', ''
	$HaskellTotal = $HaskellPSLOC[$HaskellPSLOC.Count - 1].PSLOC
	$JavaTotal = $JavaPSLOC[$JavaPSLOC.Count - 1].PSLOC

	"\begin{table}"
	"    \centering"
	"    \begin{tabular}{|l|r|}"
	"        \hline"
	"        \multicolumn{2}{|c|}{\textbf{\Ac{PSLOC} for $Target}} \\"
	"        \hline"
	"        \textbf{File} & \textbf{PSLOC} \\"
	"        \hline"
	"        \multicolumn{2}{|c|}{\textbf{Haskell}} \\"
	"        \hline"
	$HaskellPSLOC | ForEach-Object { "        $($_.File) & $($_.PSLOC) \\ \hline" }
	"        \multicolumn{2}{|c|}{\textbf{Java}} \\"
	"        \hline"
	$JavaPSLOC | ForEach-Object { "        $($_.File) & $($_.PSLOC) \\ \hline" }
	"    \end{tabular}"
	"    \caption{\label{tbl:$SerialName-psloc}\Acl{PSLOC} for $Target implementations}"
	"\end{table}"
	""
	"\def\haskell${SerialName}psloc{$HaskellTotal}"
	"\def\java${SerialName}psloc{$JavaTotal}"
}

. .\Impls.ps1

$OutDir = "Out/PSLOC"
if (!(Test-Path $OutDir)) {
	New-Item -Path $OutDir -ItemType Directory | Out-Null
}

$Implementations | ForEach-Object {
	Write-Host "Counting PSLOC for $_"

	$HS = Get-Haskell-Files-PSLOC $_
	$Java = Get-Java-Files-PSLOC $_

	Format-Result -Target $_ -HaskellPSLOC $HS -JavaPSLOC $Java > "$OutDir/${_}.tex"
}
