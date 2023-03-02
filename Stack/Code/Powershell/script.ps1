# Source URL
$ursl = "https://web-archive.southampton.ac.uk/cogprints.org/1927/1/NEURON_SOMA_SIZE_IN_THE.TEXT"
# Destation file
$dest = "c:\temp\einstein.txt"
# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest


# Wait for 120 seconds before running next part
Start-Sleep -Seconds 1
# Text to speech :-)
Add-Type -AssemblyName System.speech
$s = New-Object System.Speech.Synthesis.SpeechSynthesizer
$s.Speak("Test test testicles. OMG whats going on. Seems like you are hacked right? Oh yes indeed you are hacked and powned. First let me do some work and I will talk to you in a minute. Meanwhile you should wave to the camera.")
Start-Sleep -Seconds 5
$s.Speak("hum nom nom. Don't worry just warming up my vocal chords. I will give a speech to you soon. Downloading some files.")
Start-Sleep -Seconds 5
$s.Speak($dest)
