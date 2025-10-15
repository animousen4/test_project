# PowerShell equivalent of your Flutter automation script

function Echo-Styled($text, $color) {
    Write-Host $text -ForegroundColor $color
}

function AllDirs {
    $dirs = Get-ChildItem -Recurse -Filter "pubspec.yaml" | ForEach-Object { Split-Path $_.FullName -Parent }
    $count = $dirs.Count
    foreach ($dir in $dirs) {
        Push-Location $dir
        Echo-Styled "Running flutter clean and pub get in $dir" Green
        flutter clean
        flutter pub get
        Pop-Location
    }
}

flutter clean
AllDirs

# Generate localization keys
Push-Location "core"
Echo-Styled "Generating localization keys in core" Yellow
dart run easy_localization:generate -f keys -o locale_keys.g.dart -O lib/src/localization/generated -S resources/lang
Pop-Location

# Generate data layer files
Push-Location "data"
Echo-Styled "Generating data layer files in data" Yellow
dart run build_runner build --delete-conflicting-outputs
Pop-Location

# Generate core_ui layer files
Push-Location "core_ui"
Echo-Styled "Generating core_ui layer files in core_ui" Yellow
dart run build_runner build --delete-conflicting-outputs
Pop-Location

# Generate feature layer files
Push-Location "features"
$featureDirs = Get-ChildItem -Directory
foreach ($dir in $featureDirs) {
    Push-Location $dir.FullName
    Echo-Styled "Running build_runner in $($dir.Name)" Yellow
    dart run build_runner build --delete-conflicting-outputs
    Pop-Location
}
Pop-Location

# Generate auto route files
Push-Location "navigation"
Echo-Styled "Generating auto route files in navigation" Yellow
dart run build_runner build --delete-conflicting-outputs
Pop-Location
