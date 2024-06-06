<#
.SYNOPSIS
 Package and push the given chocolatey package to the community host.
#>
[CmdletBinding()]
param (
	# path of the directory to generate readme
	[Parameter(Mandatory, ValueFromPipeline)]
	[IO.DirectoryInfo] $PackageDirPath,

	# defaults to parent folder of this script if not provided.
	[IO.DirectoryInfo] $WorkingDirPath = $null
)
begin {
	Set-StrictMode -Version 3.0
	$ErrorActionPreference = 'stop'

	[xml] $xml = get-content -raw .\packages\standalone-ssis-devops-tools\standalone-ssis-devops-tools.nuspec
	$metadata = $xml.package.metadata

	function Format-Indented {
		param (
			[string] $Text,
			[int] $IndentSpaceLength,
			[switch] $DoIndentFirstLine
		)
		$Text = $Text -replace "(?m)^", (" " * $IndentSpaceLength)
		if (-not $DoIndentFirstLine) {
			$Text = $Text.substring($IndentSpaceLength)
		}

		#return
		$text
	}

	function Format-Dedented {
		param (
			[string] $Text,

			# if not set it measures it from the string.
			[int] $IndentSpaceLength,

			# True if the first line should be included in measurement
			[switch] $DoMeasureFirstLine,
			
			# Remove leading blank line and any trailing whitespace
			[switch] $DoTrim
		)
		# convert text into space-indented array of lines
		$Text = $Text -replace "\t", "    "

		if(-not $IndentSpaceLength) {
			$IndentSpaceLength = 0
			$lineSkipCount = If ($DoMeasureFirstLine) {,0} else {,1}
			# find all indent lengths
			$indentLengths = $Text -split "`n" |
				Select-Object -Skip $lineSkipCount | #skip the first line because it's where the tag opened
				Where-Object {-not [string]::IsNullOrWhitespace($_)} |
				Select-String '^( *)\S' -AllMatches | #get all space-indents that are followed by non-whitespace
				ForEach-Object {$_.Matches} | 
				Foreach-Object {$_.Groups[1].Value.Length}
		
			if ($indentLengths) {
				$IndentSpaceLength = ($indentLengths | Measure-Object -Minimum).Minimum
			}
		}

		$Text = $Text -replace "(?m)^ {0,$IndentSpaceLength}" #multiline-mode. For some reason when returning a pipe of strings Powershell destroys formatting in the result.
		
		if ($DoTrim) {
			$Text = $Text -replace "^\s*\n" #remove leading whitespace full-line if any
			$Text = $Text.TrimEnd() #remove all trailing whitespace
		}

		#return
		$Text
	}
	function Out-Section {
		param (
			[string] $Title,
			[string] $Body,
			[string] $UnderlineChar = "-",
			[switch] $SkipBlankLines
		)
		$body = Format-Dedented $body -DoTrim
		if (-not $SkipBlankLines) {
			$body = "`n$body"
		}

		$section = @(
			$title
			($underlinechar * $title.length)
			$body
		) 
		$section = $section | Where-Object {$_}
		if (-not $SkipBlankLines) {
			$section = @("") + $section
		}
		# return
		$section -join "`n"
	}
}


process {
	if (-not $WorkingDirPath) {
		$WorkingDirPath = $PSScriptRoot
	}

	# path.join handles better if PackageDirPath is absolute not relative.
	$packageResolvedPath = [io.path]::Combine($WorkingDirPath, $PackageDirPath)

	$nuspecFile = Get-ChildItem (Join-Path $packageResolvedPath *.nuspec)

	[xml] $xml = Get-Content -raw $nuspecFile
	$metadata = $xml.package.metadata
	$output = @(
		Out-Section $metadata.title '' '=' -SkipBlankLines
		""
		Out-Section Package "$($metadata.id) v$($metadata.version)" -SkipBlankLines
		""
		Out-Section Description $metadata.description
		""
		Out-Section 'Product Info' "
			- Copyright (c) $($metadata.copyright)
			- Product License: $($metadata.licenseUrl)
			- Documentation: $($metadata.docsUrl)
		"
		""
		Out-Section 'Installer Code License' (Get-Content $PSScriptRoot\license.md -Raw)
		""
		Out-Section 'Release Notes' $metadata.releaseNotes
		""
		"---"
		"Generated on $(Get-Date -Format yyyy-MM-dd)"
	)

	$output | Out-File (Join-Path $packageResolvedPath "readme.md")
}