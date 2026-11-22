<#
.SYNOPSIS
    Everything Gemini and Antigravity (EGA) - Windows 1-Click Bootstrap Installer
.DESCRIPTION
    Installs EGA globally as an Antigravity plugin with zero repository clutter.
#>

[CmdletBinding()]
param (
    [string]$RepoUrl = "https://github.com/gamiheme/ega.git",
    [switch]$Force
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  Everything Gemini and Antigravity (EGA) v2.3.0" -ForegroundColor Cyan
Write-Host "  The Harness-Native Super-Plugin for Antigravity" -ForegroundColor Gray
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

# Check for Antigravity CLI
$agyCmd = Get-Command "agy" -ErrorAction SilentlyContinue

if ($agyCmd) {
    Write-Host "[*] Antigravity CLI detected: $($agyCmd.Source)" -ForegroundColor Green
    Write-Host "[*] Installing EGA via Antigravity Plugin Engine..." -ForegroundColor Cyan
    
    try {
        & agy plugin install https://github.com/gamiheme/ega
        Write-Host ""
        Write-Host "[+] EGA successfully installed globally!" -ForegroundColor Green
        Write-Host "    72 Subagents | 425 Skills | 122 Rules | 37 MCPs | 9 Hooks" -ForegroundColor Gray
        Write-Host ""
        Write-Host "Run 'agy plugin list' to verify." -ForegroundColor Yellow
        exit 0
    } catch {
        Write-Warning "Plugin install command reported: $_"
        Write-Host "[*] Falling back to direct global plugin installation..." -ForegroundColor Yellow
    }
} else {
    Write-Host "[!] 'agy' CLI not found in PATH." -ForegroundColor Yellow
    Write-Host "[*] Installing directly into global Antigravity plugins directory..." -ForegroundColor Cyan
}

# Direct installation path fallback
$pluginsDir = Join-Path $HOME ".gemini\config\plugins"
$targetDir = Join-Path $pluginsDir "ega"

if (-not (Test-Path $pluginsDir)) {
    New-Item -ItemType Directory -Path $pluginsDir -Force | Out-Null
}

if (Test-Path $targetDir) {
    if ($Force) {
        Write-Host "[*] Removing existing EGA installation (--Force specified)..." -ForegroundColor Yellow
        Remove-Item -Path $targetDir -Recurse -Force
    } else {
        Write-Host "[*] Updating existing EGA installation..." -ForegroundColor Cyan
        if (Test-Path (Join-Path $targetDir ".git")) {
            git -C $targetDir pull --ff-only
            Write-Host "[+] EGA successfully updated!" -ForegroundColor Green
            exit 0
        }
    }
}

Write-Host "[*] Cloning EGA into: $targetDir" -ForegroundColor Cyan
git clone --depth 1 $RepoUrl $targetDir

Write-Host ""
Write-Host "[+] EGA installed globally in $targetDir" -ForegroundColor Green
Write-Host "    EGA is now immediately active across all Antigravity sessions and workspaces." -ForegroundColor Cyan
Write-Host ""
