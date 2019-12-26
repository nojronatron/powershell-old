$triggerURI = "https://triggers.octoblu.com/flows/8236a400-dc9e-11e4-a1e1-895c8fbb617a/triggers/878afc80-2429-11e5-8998-bd8cb8f7dbf8"
$restMethod = "POST"
$startClass = "true"
$stopClass = "false"
$genericIdMsg = "Msg from Jon"
$restBody = @($startClass)

$myMsg = Invoke-RestMethod -Uri $triggerURI -Method $restMethod -Body $restBody
