# Source URL
$url ="https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt"
# Destation file
$dest = "c:\temp\gpl.txt"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest
# Read the contents of the text file into a variable
$text = Get-Content -Path $dest -Raw
# Wait for 120 seconds before running next part
Start-Sleep -Seconds 1
# Text to speech :-)
Add-Type -AssemblyName System.speech
$s = New-Object System.Speech.Synthesis.SpeechSynthesizer
$s.Speak("Test test testicles. OMG whats going on. Seems like you are hacked right?")
$s.SelectVoice("Microsoft Zira Desktop")
$s.Speak("Oh yes indeed, hacked and powned. Wave to the camera. Come on David, do the Lords work.")
Start-Sleep -Seconds 3
$s.SelectVoice("Microsoft David Desktop")
$s.Speak("Do re mi fa so la ti do. Don't worry just warming up my vocal chords. I will give a speech to you soon. Downloading some files.")
$s.SelectVoice("Microsoft Zira Desktop")
$s.Speak("Hah you found the GLP. Nice. Go ahead and bore some people! Yikes.")
$s.SelectVoice("Microsoft David Desktop")
$s.Speak($text)
