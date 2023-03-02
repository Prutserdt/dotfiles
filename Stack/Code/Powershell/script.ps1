Add-Type -AssemblyName System.speech
$s = New-Object System.Speech.Synthesis.SpeechSynthesizer
$s.Speak("Yo, yo. You have been hacked. Please wave to the camera. Ha, ha. Fortunately this is just for shits and giggles. But. Remember. You could have been seriously compromized. Over and out. Peace.")
