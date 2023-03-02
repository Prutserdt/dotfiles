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
$s.Speak("Test test testicles. OMG whats going on. Seems like you are hacked right? Oh yes indeed you are hacked and powned. First let me do some work and I will talk to you in a minute. Meanwhile you should wave to the camera.")
Start-Sleep -Seconds 3
$s.Speak("Do re mi fa so la ti do. Don't worry just warming up my vocal chords. I will give a speech to you soon. Downloading some files.")
Start-Sleep -Seconds 1
$s.Speak($text)
