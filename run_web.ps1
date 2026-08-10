# Starts the local CORS proxy (needed by the web build because newsapi.org
# does not send CORS headers) and then runs the app in Google Chrome.
#
# Usage:
#   powershell -ExecutionPolicy Bypass -File run_web.ps1

$ErrorActionPreference = "Stop"

Write-Host "Starting local news CORS proxy on http://127.0.0.1:8090 ..." -ForegroundColor Cyan
$proxy = Start-Process -FilePath "dart" `
    -ArgumentList @("run", "tool/news_proxy.dart") `
    -WorkingDirectory $PSScriptRoot `
    -WindowStyle Hidden -PassThru

try {
    Start-Sleep -Seconds 3
    Write-Host "Opening the app in Chrome..." -ForegroundColor Cyan
    flutter run -d chrome
}
finally {
    Write-Host "Stopping the proxy..." -ForegroundColor Cyan
    Stop-Process -Id $proxy.Id -ErrorAction SilentlyContinue
}