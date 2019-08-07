# THE PUZZLE OF XML MANIPULATION
## the case	
the puzzle is, how to manipulate an xml file with the help of a powershell script, how to be CRUD, so to say. 

## solution


## sources
* [Mastering everyday XML tasks in PowerShell](https://www.powershellmagazine.com/2013/08/19/mastering-everyday-xml-tasks-in-powershell/)
* [XML Formatting, XQuery, and XPath Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=DotJoshJohnson.xml)
* [regex is -replace's best friend](https://powershell.org/2013/08/regular-expressions-are-a-replaces-best-friend/)


## terminology
* malformed XML
* XML Object 

## changelog
### 2019-08-06 13:48:41 hey, it's supported!
* i know there is medium article, no idea from my own head how could this be done
* new to me: powershell has awesome xml support
### 2019-08-06 13:55:24 finding
* don't use get-content for performance reasong! why?
    * reading in the XMl file ass a plain text fils and then casting it to XML in a second step is 7-times more expensive

```powershell 
# ! VIA NEGATIVA (DO NOT DO THIS) ! 
# declare path
$path = 'c:\data.xml'

# load it into an XML object
[XML]$xml = Get-Content $Path
```
* so? The way to go is to declare an **xml object** and load it from the path

```powershell 
# declare path
$path = 'c:\data.xml'

# load the data directly into an XML object
$xml = New-Object -TypeName XML
$xml.load($path)

#possible exceptions here in case of malformed XML
#possible exceptions here in case of XML nodes containing spaces

#traverse the nodes and select the info you want
$xml.node.subnode | Select-Object -Property Foo, Bar
```

### 2019-08-06 14:08:36 changing stuff ?
* seems that x-path (xml query language) comes handy — there is an XML vscode extension that can already both get and evaluate an xpath location

```powershell 
# SELECT ITEM WITH X-PATH
$item = Select-XML -XML $xml -Xpath '//XPATH'
# SELECT THE NODE IN QUESTION
$item.fooNode.barSubNode = 'lorem ipsum'
# OVERWRITING THE EXISTING FILE 
$xml.Save($path)
```

## 2019-08-07 11:37:25 how to keep the string update sustainable ? regex in PS ?
* the sustainable replacement could be done with regex
* the example below is for a monthly report, where the timestamp is replaced each time the script runs

```powershell
# CREATE A BINDING IN THE FORMAT MM.YYYY
$reportTimeStamp = Get-Date -UFormat "%m.%Y"
# SELECT ITEM WITH X-PATH
$item = Select-XML -XML $xml -Xpath '//XPATH'
# SELECT THE NODE IN QUESTION AND ENHANCE IT: IT ALREADY CONTAINS THE TIMESTAMP! 
$item.fooNode.barSubNode = $item.fooNode.barSubNode -replace "\d{2}.d{4}", $reportTimeStamp
# OVERWRITING THE EXISTING FILE 
$xml.Save($path)

```
