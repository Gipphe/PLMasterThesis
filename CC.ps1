$MetrixDBFile = "metrixpp.db"

function Invoke-Argon {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[String]$Target
	)

	$Path = "$(Get-Location)\Haskell\Implementations\$Target"

	docker run -it --rm -v "${Path}:/hssrc" argon --json /hssrc
	| ConvertFrom-Json
}

function Invoke-MetrixPP {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[String]$Target
	)

	$TargetDir = "Java/Implementations/$Target"

	metrix++ collect `
		--db-file=$MetrixDBFile `
		--std.code.complexity.cyclomatic `
		--exclude-files=class $TargetDir `
		2>&1
	| Out-Null
	metrix++ export --db-file=$MetrixDBFile --log-level=ERROR | ConvertFrom-Csv
}

function Get-Haskell-CC {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[String]$Target
	)

	$Total = 0
	$Res = Invoke-Argon $Target | ForEach-Object {
		$Name = $_.path -replace '/hssrc/', ''
		$CC = 0

		$_.blocks | ForEach-Object {
			$CC += $_.complexity
		}

		$Total += $CC
		[PSCustomObject]@{
			Name = $Name;
			CC   = $CC
		}
	}
	$Res += [PSCustomObject]@{Name = "Total"; CC = $Total }
	return $Res
}

function Get-Java-CC {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[String]$Target
	)

	$Total = 0

	$Res = Invoke-MetrixPP $Target
	| ForEach-Object {
		$_.file = $_.file -replace '^\./.*/(\w+.java)$', '$1'
		$_
	}
	| Group-Object { $_.file }
	| ForEach-Object {
		$Name = $_.Name
		$CC = 0

		$_.Group
		| Where-Object { $_.type -eq 'function' }
		| ForEach-Object { [Int]$_.'std.code.complexity:cyclomatic' }
		| ForEach-Object {
			$CC += $_ + 1
		}

		$Total += $CC

		[PSCustomObject]@{
			Name = $Name
			CC   = $CC
		}
	}

	$Res += [PSCustomObject]@{
		Name = "Total"
		CC   = $Total
	}

	return $Res
}

function Format-Result {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[PSCustomObject[]]$HaskellCC,

		[Parameter(Mandatory)]
		[PSCustomObject[]]$JavaCC,

		[Parameter(Mandatory)]
		[String]$Target
	)

	$SerialName = $Target.ToLower() -replace ' ', ''
	$HaskellTotal = $HaskellCC[$HaskellCC.Count - 1].CC
	$JavaTotal = $JavaCC[$JavaCC.Count - 1].CC

	"\begin{table}"
	"    \centering"
	"    \begin{tabular}{|l|r|}"
	"        \hline"
	"        \multicolumn{2}{|c|}{\textbf{\Ac{CC} for $Target}} \\"
	"        \hline"
	"        \textbf{File} & \textbf{\ac{CC}} \\"
	"        \hline"
	"        \multicolumn{2}{|c|}{\textbf{Haskell}} \\"
	"        \hline"
	$HaskellCC | ForEach-Object { "        $($_.Name) & $($_.CC) \\ \hline" }
	"        \multicolumn{2}{|c|}{\textbf{Java}} \\"
	"        \hline"
	$JavaCC | ForEach-Object { "        $($_.Name) & $($_.CC) \\ \hline" }
	"    \end{tabular}"
	"    \caption{\label{tbl:$SerialName-cc}\Acl{CC} for $Target implementations}"
	"\end{table}"
	""
	"\def\haskell${SerialName}cc{$HaskellTotal}"
	"\def\java${SerialName}cc{$JavaTotal}"
}

. .\Impls.ps1


$OutDir = "Out/CC"
if (!(Test-Path $OutDir)) {
	New-Item -Path $OutDir -ItemType Directory | Out-Null
}

$Implementations | ForEach-Object {
	Write-Host "Calculating $_ CC for Haskell..."
	$HS = Get-Haskell-CC $_
	Write-Host "Calculating $_ CC for Java..."
	$Java = Get-Java-CC $_
	Format-Result -Target $_ -HaskellCC $HS -JavaCC $Java > "$OutDir/${_}.tex"
}
Remove-Item $MetrixDBFile
