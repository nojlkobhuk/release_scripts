function unzip($filename) {
    $shell_app = new-object -com shell.application
    $zip_file = $shell_app.namespace((Get-Location).Path + $filename)
    mkdir $filename.Trim(".zip")
    $destination = $shell_app.namespace((Get-Location).Path + $filename.Trim(".zip"))
    $destination.Copyhere($zip_file.items())
}

function zip($srcname) {
    [Reflection.Assembly]::LoadWithPartialName( "System.IO.Compression.FileSystem" ) | Out-Null
    [System.AppDomain]::CurrentDomain.GetAssemblies() | Out-Null
    echo src_folder
    $src_folder = "$DIRNAME\$srcname"
    $src_folder
    $zipname = "$install" + (Get-Date -Format "MM.ddTHH.mm.ss") 
    $destfile = "$env:HOMEDRIVE\RMBackup\$zipname.zip"
    echo destfile
    $destfile
    $compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal
    $includebasedir = $false
    [System.IO.Compression.ZipFile]::CreateFromDirectory($src_folder, $destfile, $compressionLevel, $includebasedir)
}

function sqlport() {
    [array]$process = netstat -anb
    [string]$port = ""
    For ( $i=0; $i -lt 100; $i++ ) { 
        if ( $process[$i] -match "sqlservr") {
            $id = $process[$i - 1].IndexOf("0:")
            $port = $process[$i - 1].Substring($id+1,$id+1)
            $i = 101
        }
    }
return $port
}

function is_backup($path) {
    if (-not (Test-Path "$path")) { echo "$path NOT FOUND" } else {
                    if (-not (Test-Path "$path")) { 
                        echo "$path NOT FOUND" 
                    } else { 
                        cp -r "$path\jboss-as\server\mobilebanking\log" .\2backup\jboss-as\server\mobilebanking\log
                        cp -r "$path\jboss-as\bin" .\2backup\jboss-as\bin
                        cp -r "$path\jboss-as\server\mobilebanking\conf" .\2backup\jboss-as\server\mobilebanking\conf
                        cp -r "$path\jboss-as\server\mobilebanking\deployers\jbossweb.deployer" .\2backup\jboss-as\server\mobilebanking\deployers\jbossweb.deployer
                        cp -r "$path\native\sbin" .\2backup\native\sbin
                        cp -r "$path\is-server.properties" .\2backup\is-server.properties
                        zip("2backup") 
                        rm -r 2backup
                    }
    }
}

function cs_backup($path) {
    if (-not (Test-Path "$path")) { echo "$path NOT FOUND" } else {
                    if (-not (Test-Path "$path")) { 
                        echo "$path NOT FOUND" 
                    } else { 
                        cp -r "$path\etc\httpd\logs" .\2backup\etc\httpd\logs
                        cp -r "$path\etc\httpd\conf" .\2backup\etc\httpd\conf
                        cp -r "$path\etc\httpd\conf.d" .\2backup\etc\httpd\
                        cp -r "$path\etc\ssl" .\2backup\etc\
                        cp -r "$path\var\www\html" .\2backup\var\www\html
                        zip("2backup")
                        rm -r 2backup
                    }
    }
}

filter grep($keyword) { if ( ($_ | Out-String) -like “*$keyword*”) { 
    Write-Host $_ 
    $_ } else { Write-Host $_ }
}

filter sed($before,$after) { %{$_ -replace $before,$after} } 

function imb($install) {
 
$port = sqlport
if ( $port -eq "" ) { 
    echo "NO SQL SERVER FOUND"
    $port = "NONE"
    if ( $install -match "db" ) { 
        $install = "default"
        echo "YOU CANT INSTALL dB WITHOUT RUNNING SQL SERVER"
        echo "or" 
        }
    }
    echo "SQL PORT $port"
    $env:JAVA_HOME = "C:/Program Files/Java/jdk1.6.0_45"
    $env:JAVA = "$env:JAVA_HOME/bin/java"
    $DIRNAME = $pwd.path


    [array]$files = ls | select Name | where {$_.Name -match "^(\S+).zip"}
    ForEach ( $file in $files ) {
        if ( $file.Name -match "dist" ) {
        $filename = $file.Name
        echo $filename.Trim(".zip")
        unzip ($filename)
        cd $filename.Trim(".zip")
        $DIRNAME = $pwd.path
        mkdir Backup
    }}
    ForEach ( $name in $(ls $env:HOMEDRIVE\*\*) ) { if ( $name.Name -eq "$install" ) { $setup = $name.FullName.Trim("\$install") }}
    gc custom.properties.templ* | % { $_ -replace "c:/mobilebanking/jdk1.6.0_25", "$env:JAVA_HOME" } | Set-Content -Encoding UTF8 "custom.properties"
    
    switch ($install)
    {
        installdb {
            echo "dB CREATING USER"
            if ((.\db-create-user.cmd  | grep BUILD) -match ("SUCCESSFUL")) {
            echo "dB CREATING DATABASE"
            .\db-create-database.cmd
            echo "dB CREATING SCHEMA"
            .\db-create-schema.cmd
        }}
        updatedb {
            echo "dB UPDATING SCHEMA"
            .\db-update-schema.cmd
        }
        cs-server {
            if ( (gsv | select Name) -match "cs-service") {
                echo "CS_SERVICE STOPS"
                if ((.\cs-stop-service.cmd | grep BUILD) -match ("SUCCESSFUL") -or ("service is not started")) { 
                    echo "CS_SERVICE ARCHIVES"
                    if (-not (Test-Path "$setup\$install")) { echo "$setup\$install NOT FOUND" } else {
                    if (-not (Test-Path "$setup\$install\etc\httpd\logs")) { echo "$setup\$install\etc\httpd\logs NOT FOUND" } else { cp -r "$setup\$install\etc\httpd\logs" .\cslogs }
                    cs_backup("$setup\$install")
                    echo "CS_SERVICE UNINSTALL"
                    .\ant.cmd cs-uninstall-service
                    #rm -r -Force "$setup\$install"
                }
            }}
            echo "CS_SERVICE INSTALL"
            if ((.\cs-install.cmd | grep BUILD) -match ("SUCCESSFUL")) { 
            if ((ls).Name -match "cslogs" ) { 
                cp -r -Force .\cslogs\* "$setup\$install\etc\httpd\logs\" 
                rm -r -Force .\cslogs
                }
            echo "CS_SERVICE STARTS"
            .\cs-start-service.cmd
            gsv cs-service
        }}
        is-server {
            if ( (gsv | select Name) -match "is-service") {
                echo "IS_SERVICE STOPS"
                if ((.\is-stop-service.cmd | grep BUILD) -match ("SUCCESSFUL") -or ("service is not started")) {
                    echo "IS_SERVICE ARCHIVES"
                    if (-not (Test-Path "$setup\$install")) { echo "$setup\$install NOT FOUND" } else {
                    if (-not (Test-Path "$setup\$install\jboss-as\server\mobilebanking\log")) { echo "$setup\$install\jboss-as\server\mobilebanking\log NOT FOUND" } else { cp -r "$setup\$install\jboss-as\server\mobilebanking\log" .\islog }
                    is_backup("$setup\$install")
                    echo "IS_SERVICE UNINSTALL"
                    .\ant.cmd is-uninstall-service
                    #rm -r "$setup\$install"
                }
            }}
            echo "IS_SERVICE INSTALL"
            if ((.\is-install.cmd | grep BUILD) -match ("SUCCESSFUL")) {   
            if ((ls).Name -match "islog") { 
                cp -r .\islog\* "$setup\is-server\jboss-as\server\mobilebanking\log\" 
                rm -r -Force .\islog
                }
            echo "IS_SERVICE STARTS"
            .\is-start-service.cmd
            gsv is-service
        }}
        stop { echo "INSTALL DID NOT FOUND mobilebank PATH" }   
        default { echo "PARAMETER ERROR Availible parameters are" 
                  echo "installdb updatedb cs-server is-server" }
    }
}

<# Допущения
- Поставка хранится в зип или разархивированном виде в репозитории
- Вложенные зип архивы в поставке отсутствуют
- Задана переменная окружения $env:JAVA_HOME = "C:/Program Files/Java/jdk1.6.0_45" с обычными слешами
- Компоненты системы мобильный банк устанавливаются на системный диск в корень, прим C:\mobilebanking
#>

git clone $repo
imb("cs-server")
imb("is-server")
