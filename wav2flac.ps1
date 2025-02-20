<##########################################################
# Script to convert all WAV in a dir to FLAC (Recursively)#
# https://github.com/jpestovich/usefulpowershell          #
# Requires FFMPEG                                         #
# https://ffmpeg.org/download.html#build-windows          #
##########################################################>

# Define conversion function
function Convert-Files {
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $filepath,

        [Parameter(Position=1)]
        [string] $ffmpeg = 'C:\bin\ffmpeg.exe'
    )
    Get-Childitem -Recurse -Path $filepath *.wav | ForEach-Object {
        if ($_.Extension -eq ".wav") {
            $noextension = $_.DirectoryName + "\" + $_.BaseName
            & $ffmpeg -i $_.FullName -acodec flac "$noextension.flac"
        }
    }
}

<#########################################################################
#  Variables                                                             #
#  Filepath must be set! ffmpeg will default to C:\bin\ffmpeg.exe        #
#  change this value depending on the location of your ffmpeg.exe binary #
#########################################################################>

#Path where files are located & to be converted (required)
$filepath = 'C:\tmp\blegh'

#Specify ffmpeg location (optional, see default)
$ffmpeg = 'C:\Users\jpestovich\Downloads\ffmpeg-master-latest-win64-gpl\ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe'

Convert-Files -filepath $filepath -ffmpeg $ffmpeg
