param

(

       [string]$BUILDDIR = $(throw "The BUILDDIR must be provided."),

    [string]$ServiceDir = $(throw "The ServiceDir must be provided."),

    [string]$ServiceName = $(throw "The ServiceName must be provided."),

    [string]$BackupDir = $(throw "The BackupDir must be provided.")

)

 

function backup ($service) {

    $SourceTmp = "$BUILDDIR\$service"

    $Destination = "$BackupDir\$service"

    echo "source $SourceTmp"

    echo "dest $Destination"

    robocopy $SourceTmp $Destination *.* /E /NS /NC /NFL /NDL | Out-Null

}

 

function zip($srcname) {

    [Reflection.Assembly]::LoadWithPartialName( "System.IO.Compression.FileSystem" ) | Out-Null

    [System.AppDomain]::CurrentDomain.GetAssemblies() | Out-Null

    echo src_folder

    $src_folder = "$BackupDir\$srcname"

    $src_folder

    $zipname = "$srcname" + (Get-Date -Format "MM.ddTHH.mm.ss")

    $destfile = "$BackupDir\$zipname.zip"

    echo destfile

    $destfile

    $compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal

    $includebasedir = $false

    [System.IO.Compression.ZipFile]::CreateFromDirectory($src_folder, $destfile, $compressionLevel, $includebasedir)

}

 

 

if ( (gsv | select Name) -match "$ServiceName") {

    if (-not (Test-Path "$BackupDir")) { mkdir $BackupDir }

    Write-Host "Stopping service $ServiceName"

    spsv $ServiceName

    Write-Host "Backuping folder $ServiceDir"

    backup ($ServiceDir)

    Write-Host "Archiving folder $ServiceDir"

    zip ($ServiceDir)

    Write-Host "Starting service $ServiceName"

    sasv $ServiceName

} else { throw "service $ServiceName NOT FOUND in system, Nothing to backup" }
