Add-Type -AssemblyName System.Speech
$synth = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
$synth | Get-Member

[array]$voices = $synth.GetInstalledVoices()
$voices[2].VoiceInfo


$synth.Speak($builder)

$synth.Rate

$synth.State

$synth.Voice.AdditionalInfo

$synth.GetInstalledVoices()

$stuff_to_say = "The striped hyena (Hyaena hyaena) is a species of true hyena native to North and East Africa, the Middle East, the Caucasus, Central Asia and the Indian Subcontinent. It is listed by the IUCN as near threatened, as the global population is estimated to be under 10,000 mature individuals which continues to experience deliberate and incidental persecution along with a decrease in its prey base such that it may come close to meeting a continuing decline of 10% over the next three generations."
$synth.Speak($stuff_to_say)

$synth.SelectVoice("Microsoft Hazel Desktop")
$synth.Rate("10")
