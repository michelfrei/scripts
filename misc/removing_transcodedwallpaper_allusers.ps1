$profiles = Get-WmiObject Win32_UserProfile | Where-Object { $_.Special -eq $false }

foreach ($profile in $profiles) {
    $profilePath = $profile.LocalPath
    $transcodedWallpaperPath = Join-Path $profilePath "AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper"

    if (Test-Path $transcodedWallpaperPath) {
        Remove-Item $transcodedWallpaperPath -Force
        Write-Output "Removed TranscodedWallpaper for user profile: $profilePath"
    } else {
        Write-Output "No TranscodedWallpaper found for user profile: $profilePath"
    }
}

gpupdate /force
stop-process -name explorer -force