# Source URL
$url ="https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt"
# Destation file
$dest = "c:\temp\gpl.txt"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest
# Read the contents of the text file into a variable
$text = Get-Content -Path $dest -Raw
# Wait for 120 seconds before running next part
Start-Sleep -Seconds 120
# Text to speech :-)
Add-Type -AssemblyName System.speech
$s = New-Object System.Speech.Synthesis.SpeechSynthesizer
#Womans voice
$s.SelectVoice("Microsoft Zira Desktop")
$s.Speak("yo yo yo sheeple")
#Mans voice
$s.SelectVoice("Microsoft David Desktop")
$s.Speak("Test test testicles. OMG whats going on. Seems like you are hacked right?")
$s.SelectVoice("Microsoft Zira Desktop")
$s.Speak("Oh yes indeed, hacked and powned. Wave to the camera sheeple!")
$s.SelectVoice("Microsoft David Desktop")
$s.Speak("yeah they are checking the camera!")
$s.SelectVoice("Microsoft Zira Desktop")
$s.Speak("whahaha")
$s.SelectVoice("Microsoft David Desktop")
$s.Speak("Ninanoninei. Don't worry just warming up my vocal chords. I will give a speech to you soon but i'm gonna download some files first.")
$s.SelectVoice("Microsoft Zira Desktop")
$s.Speak("Hey, you found the GLP. Nice. Go ahead and bore the silly sheeple!")
$s.SelectVoice("Microsoft David Desktop")
$s.Speak($text)
