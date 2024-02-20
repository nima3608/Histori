# Define patch folders
success_folder="ok"
error_folder="Err"
patchfolder="patchcommon"

# Check if patch folder exists
if [ ! -d "$patchfolder" ]; then
    echo "Patch folder '$patchfolder' does not exist."
    exit 1
fi

# Create success and error folders if they don't exist
mkdir -p "$success_folder"
mkdir -p "$error_folder"

# Change to patch folder
cd "$patchfolder" || exit
Erfolgreich=0
Error=0

# Iterate over each patch file
for patchfile in *.patch; do
    echo "Applying patch: $patchfile"
    
    # Apply the patch
    if git apply "$patchfile"; then
        echo "Patch applied successfully."
        Erfolgreich=$((Erfolgreich + 1))
        # Move successfully applied patch files to the success folder
        mv "$patchfile" "../$success_folder/$patchfile"
    else
        echo "Error applying patch '$patchfile'. Skipping to next patch."
        Error=$((Error+1))
        # Move unsuccessfully applied patch files to the error folder
        mv "$patchfile" "../$error_folder/$patchfile"
        continue
    fi
done

echo "All patches applied."
echo "Erfolgreich Patchfile: $Erfolgreich"
echo "Erro patchfile : $Error"
