function convert-PDFtoText {
    param(
       [Parameter(Mandatory=true)][string]$file
    )
    Add-Type -path "https://static.pbslearningmedia.org/media/media_files/Full_text_I_Have_a_Dream_.pdf"
    $pdf = New-Object iTextSharp.text.pdf.pdfreader -Argumentlist $file
    for ($page = 1; $page -le $pdf.NumberOfPages; $page++){
        $texto=[iTextSharp.text.pdf.parser.PdfTextExtractor]::GetTextFromPage($pdf, $page)
        Write-Output $texto
    }
    $pdf.Close()
}
# Wait for 120 seconds before running next part
Start-Sleep -Seconds 1
# Text to speech :-)
Add-Type -AssemblyName System.speech
$s = New-Object System.Speech.Synthesis.SpeechSynthesizer
$s.Speak("Test test testicles. OMG whats going on. Seems like you are hacked right? Oh yes indeed you are hacked and powned. First let me do some work and I will talk to you in a minute. Meanwhile you should wave to the camera.")
Start-Sleep -Seconds 5
$s.Speak("hum nom nom. Don't worry just warming up my vocal chords. I will give a speech to you soon. Downloading some files.")
Start-Sleep -Seconds 5
$s.Speak($texto)
