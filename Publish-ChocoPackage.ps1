<#
.SYNOPSIS
 Package and push the given chocolatey package to the community host.
#>
[CmdletBinding()]
param (
	# path of the directory containing the chocolatey package to push
	[Parameter(Mandatory, ValueFromPipeline)]
	[IO.DirectoryInfo] $PackageToPublishDirPath,

	# defaults to parent folder of this script if not provided.
	[IO.DirectoryInfo] $WorkingDirPath = $null,

	# sets API key into chocolatey environment key store. Does not need to be provided on every call.
	[string] $ChocoApiKey
)
begin {
	if ($ChocoApiKey) {
		choco apikey -s "https://push.chocolatey.org/" -k $ChocoApiKey
	}
}
process {
	if (-not $WorkingDirPath) {
		$WorkingDirPath = $PSScriptRoot
	}

	try {
		Push-Location (Join-Path $WorkingDirPath.FullName $PackageToPublishDirPath)
		Remove-Item *.nupkg
		choco pack
		Get-ChildItem *.nupkg | choco push $_
	} finally {
		Pop-Location
	}
}