Standalone SSIS DevOps Tools
============================

Package
-------
standalone-ssis-devops-tools v1.0.0


Description
-----------

*(description below copied from MS SSIS website)*

Standalone SSIS DevOps Tools provide a set of executables to do SSIS CICD tasks. Without the
dependency on the installation of Visual Studio or SSIS runtime, these executables can be easily integrated
with any CICD platform. The executables provided are:

- SSISBuild.exe: build SSIS projects in project deployment model or package deployment model.
- SSISDeploy.exe: deploy ISPAC files to SSIS catalog, or DTSX files and their dependencies to file system.


Product Info
------------

- Copyright (c) Microsoft Corporation
- Product License: https://marketplace.visualstudio.com/items/SSIS.ssis-devops-tools/license
- Documentation: https://learn.microsoft.com/en-us/sql/integration-services/devops/ssis-devops-standalone


Installer Code License
----------------------

MIT License

Copyright (c) 2024 Martin Zarate

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


Release Notes
-------------

*(release notes below copied from MS SSIS website)*

Version 1.0.0.0

- Release Date: September 1, 2021
- General Availability(GA) release.

Version 0.1.3.1 Preview

- Release Date: June 10, 2021
- Fixed an issue that SSISDeploy.exe failed to deploy SSIS projects with error "Unhandled Exception:
System.IO.FileLoadException: Could not load file or assembly
'Microsoft.SqlServer.IntegrationServices.ProjectDeployment, Version=1.0.0.0, Culture=neutral,
PublicKeyToken=31bf3856ad364e35' or one of its dependencies. Strong name validation failed. (Exception from
HRESULT: 0x8013141A) --> System.Security.SecurityException: Strong name validation failed. (Exception from
HRESULT: 0x8013141A)".

Version 0.1.3 Preview

- Release Date: June 2, 2021
- Fixed an issue that SSISBuild.exe failed to build projects with error "Project consistency check failed. The
following inconsistencies were detected" when the package name in the project contains special characters. Fixed an
issue that SSISBUild.exe failed to build projects when there's mismatch between the name in dtproj and the
filename. Fixed an issue that SSISBuild.exe failed to build projects with protection level
encryptSenstiveWithPassword/EncryptAllWithPassword when the project targets SQL Server 2016.

Version 0.1.2 Preview

- Release Date: January 14, 2021
- Fixed an issue that SSISBuild.exe fails to build project with NullReference exception when package parameter
metadata in SSIS project file and SSIS package mismatches. Fixed an issue that package fails to be executed with
error starting with "Failed to decrypt protected XML node" though the package is deployed to SSISDB successfully
with SSISDeploy.exe, when the SSIS project containing the package is encrypted with EncryptSensitiveWithUserKey and
the package contains CM with sensitive data.

Version 0.1.1 Preview

- Release Date: November 11, 2020
- Fixed an issue that SSISDeploy.exe fails to load an assembly when deploying ispac to SSIS catalog.

Version 0.1.0 Preview

- Release Date: October 16, 2020
- Initial preview release of standalone SSIS DevOps Tools.

---
Generated on 2024-06-19
