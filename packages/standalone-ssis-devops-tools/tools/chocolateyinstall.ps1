$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://download.microsoft.com/download/5/1/4/5144b772-d3b0-4e1c-a05b-5376f2ea0fc1/SSISDevOpsTools-1.0.0.0.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  checksum      = '5B721116D982457EF2FB8C584EF8AE24B7266E519FD5F16CAA867FA32EBDD14F'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs