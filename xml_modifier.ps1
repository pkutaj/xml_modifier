<# 
## PURPOSE
The aim of this code is to modify an xml file in order to populate required fields with current month. 


## TOC
STEP | ACTION
-----|-------
1.   | Declare Path
2.   | Load the data into an XML-Object
3.   | Bind the nodes
4.   | Modify the nodes with the right selection of .Node
5.   | Save the file


2019-08-06 14:38:02 IMPLEMENT THIS INTO THE TASK ITSELF
#>

# 1.   | Declare Path
$configFilePath = 'C:\Users\pkutaj\Documents\workspace\PS\xml_modifier\compilation_23.boaRD.xml'

# 2.   | Load the data into an XML-Object
$xmlObject = New-Object -TypeName xml
$xmlObject.Load($configFilePath)

# 3.   | Bind the nodes
$mailHeader = Select-XML -XML $xmlObject -Xpath '/Configuration/Compilations/Compilation/MailSettings/MailHeader'
$reportTimeStamp = Get-Date -UFormat "%m.%Y"
write-host $reportTimeStamp
write-host $mailHeader

# 4.   | Modify the nodes with the right selection of .Node
$mailHeader.Node.InnerText = $reportTimeStamp + $mailHeader.Node.InnerText 
write-host $mailHeader

# 5.   | Save the file
$xmlObject.Save($configFilePath)


