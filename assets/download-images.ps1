# Headers for authentication
$headers = @{
    'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
    'Accept' = 'image/webp,image/apng,image/*,*/*;q=0.8'
    'Accept-Language' = 'en-US,en;q=0.9'
    'Cookie' = 'atlassian.xsrf.token=...' # Add your cookie here
    'Referer' = 'https://goconnectitgroup.atlassian.net/wiki/'
}

# Base path for saving images
$basePath = "C:\GitRepos-priv\Appeee-Docs\html\assets"

# Function to create directory if it doesn't exist
function Test-DirectoryExists {
    param (
        [string]$path
    )
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
        Write-Host "Created directory: $path" -ForegroundColor Green
    }
}

# Function to download an image
function Get-Image {
    param (
        [string]$url,
        [string]$savePath,
        [string]$fileName
    )
    
    try {
        $fullPath = Join-Path $savePath $fileName
        Write-Host "Downloading: $fileName to $savePath" -ForegroundColor Cyan
        
        $webClient = New-Object System.Net.WebClient
        $webClient.Headers.Add('User-Agent', $headers['User-Agent'])
        $webClient.Headers.Add('Accept', $headers['Accept'])
        $webClient.Headers.Add('Accept-Language', $headers['Accept-Language'])
        $webClient.Headers.Add('Cookie', $headers['Cookie'])
        $webClient.Headers.Add('Referer', $headers['Referer'])
        
        # Test the URL first
        try {
            $response = $webClient.DownloadString($url)
        } catch {
            Write-Host "Error accessing URL: $url" -ForegroundColor Red
            Write-Host "Status Code: $($_.Exception.Response.StatusCode.value__)" -ForegroundColor Red
            Write-Host "Status Description: $($_.Exception.Response.StatusDescription)" -ForegroundColor Red
            return
        }
        
        $webClient.DownloadFile($url, $fullPath)
        Write-Host "Successfully downloaded: $fileName" -ForegroundColor Green
        
        # Add random delay between 0.1 and 0.5 seconds
        $delay = Get-Random -Minimum 100 -Maximum 501
        Start-Sleep -Milliseconds $delay
    }
    catch [System.Net.WebException] {
        Write-Host "Web Error downloading $fileName :" -ForegroundColor Red
        Write-Host "Status Code: $($_.Exception.Response.StatusCode.value__)" -ForegroundColor Red
        Write-Host "Status Description: $($_.Exception.Response.StatusDescription)" -ForegroundColor Red
        Write-Host "Message: $($_.Exception.Message)" -ForegroundColor Red
    }
    catch {
        Write-Host "General Error downloading $fileName :" -ForegroundColor Red
        Write-Host "Error Type: $($_.Exception.GetType().FullName)" -ForegroundColor Red
        Write-Host "Message: $($_.Exception.Message)" -ForegroundColor Red
        if ($_.Exception.InnerException) {
            Write-Host "Inner Exception: $($_.Exception.InnerException.Message)" -ForegroundColor Red
        }
    }
}

# Create base directory
Test-DirectoryExists $basePath

# Process each HTML file and its images
$htmlFiles = Get-ChildItem -Path "C:\GitRepos-priv\Appeee-Docs\html\GO Appeee - documentation\Platform" -Recurse -Filter "*.html"

Write-Host "Starting image download process..." -ForegroundColor Yellow

foreach ($htmlFile in $htmlFiles) {
    $relativePath = $htmlFile.DirectoryName.Replace("C:\GitRepos-priv\Appeee-Docs\html\GO Appeee - documentation\Platform", "")
    $savePath = Join-Path $basePath $relativePath
    Test-DirectoryExists $savePath
    
    $content = Get-Content $htmlFile.FullName -Raw
    $imageMatches = [regex]::Matches($content, '<img[^>]*src="([^"]*)"')
    
    foreach ($match in $imageMatches) {
        $url = $match.Groups[1].Value
        if ($url -match 'download/attachments/(\d+)/([^?]+)') {
            # Extract filename from URL up to the file extension
            $fileName = [System.IO.Path]::GetFileName($url)
            $fileName = $fileName -replace '\?.*$',''  # Remove any query parameters
            Get-Image -url $url -savePath $savePath -fileName $fileName
        }
    }
}

Write-Host "Image download process completed." -ForegroundColor Green 