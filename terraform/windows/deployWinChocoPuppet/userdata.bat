<script>

cd  \

mkdir userdatalog

date /t >>\userdatalog\logfile.txt

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

date /t >>\userdatalog\logfile.txt
choco install -y puppet-agent >>\userdatalog\logfile.txt

date /t >>\userdatalog\logfile.txt
puppet help  >>\userdatalog\logfile.txt

echo "installing puppet module puppetlabs-chocolatey" >>\userdatalog\logfile.txt
date /t >>\userdatalog\logfile.txt
puppet module install puppetlabs-chocolatey --version 3.0.0 >>\userdatalog\logfile.txt

date /t >>\userdatalog\logfile.txt

</script>
