<script>

cd  \

mkdir userdatalog

date /t >>userdatalog\logfile.txt

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco install -y puppet-agent

choco install -y git.install

echo  date /t >>userdatalog\logfile.txt

</script>
