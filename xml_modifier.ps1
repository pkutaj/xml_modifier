<# 
## PURPOSE
The aim of this code is to modify an xml file in order to populate required fields with current month. 


## TOC
STEP | ACTION
-----|-------
1.   | Declare Path
2.   | Load the data into an XML-Object
3.   | Bind the nodes
4.   | Use -replace to modify the nodes with regular expression
5.   | Save the file

2019-08-06 14:38:02 IMPLEMENT THIS INTO THE TASK ITSELF
#>

# 1.   | Declare Path
$configFile = '.\sample.xml'

# 2.   | Load the data into an XML-Object
$xmlObject = New-Object -TypeName xml
$xmlObject.Load($configFile)

# 3.   | Bind the nodes
$mailHeader = Select-XML -XML $xmlObject -Xpath '/Configuration/Compilations/Compilation/MailSettings/MailHeader'
$reportTimeStamp = Get-Date -UFormat "%m.%Y"
$regexPattern = "\d{2}.\d{4}"

# 4.   | Use -replace to modify the nodes with regular expression
Write-Host $mailHeader.Node.InnerText
if ($mailHeader -match $regexPattern) {
    $mailHeader.Node.InnerText = $mailHeader.Node.InnerText -replace $regexPattern, $reportTimeStamp
}
else { $mailHeader.Node.InnerText = $reportTimeStamp + " | " + $mailHeader.Node.InnerText }
Write-Host $mailHeader.Node.InnerText
# 5.   | Save the file
$xmlObject.Save($configFile)


