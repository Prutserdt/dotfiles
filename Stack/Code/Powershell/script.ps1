# Create a backup of the current desktop background!
copy "c:\Users\Public\Pictures\Desktop_bio.jpg" "c:\Users\Public\Pictures\Desktop_bio_backup.jpg"

# Source the picture that will become the new desktop background
$url ="https://i.imgflip.com/1aypjs.jpg"

# Destation file
$dest ="c:\Users\Public\Pictures\Desktop_bio.jpg"

# Download the file and write
Invoke-WebRequest -Uri $url -OutFile $dest

## Uncomment the following to revert back!
##
## Save the powned image
#copy "c:\Users\Public\Pictures\Desktop_bio.jpg" "c:\Users\Public\Pictures\Desktop_bio_powned.jpg"
##
## Replace the backed up picture
#copy "c:\Users\Public\Pictures\Desktop_bio_backup.jpg" "c:\Users\Public\Pictures\Desktop_bio.jpg"
