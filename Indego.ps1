$serial = '123456789'
$user = "max.muster@anywhere.com"
$pass = "supersecret"
$api = 'https://api.indego.iot.bosch-si.com/api/v1/'

$pair = "${user}:${pass}"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)

$basicAuthValue = "Basic $base64"
$headers = @{ Authorization = $basicAuthValue }

$jsonBody= @{
    'device' = ''
    'os_type' = 'Android'
    'os_version' = '4.0'
    'dvc_manuf' = 'unknown'
    'dvc_type' = 'unknown'
    } | ConvertTo-Json

# Authentication
$uri = $api + "authenticate"
$authResponse = Invoke-RestMethod -Method POST -ContentType 'application/json' -Body $jsonBody -Headers $headers -Verbose -Uri $uri

$headers = @{ 'x-im-context-id' = $authResponse.contextId }

# Get status
$uri = $api + "alms/$serial/state"
$status = Invoke-RestMethod -Method GET -Headers $headers -Uri $uri

# Get garden location
$uri = $api + "alms/$serial/predictive/location"
$gardenLocation = Invoke-RestMethod -Method GET -Headers $headers -Uri $uri

# Get alerts
$uri = $api + "alerts"
$alerts = Invoke-RestMethod -Method GET -Headers $headers -Uri $uri

# Get generic device data
$uri = $api + "alms/$serial"
$deviceData = Invoke-RestMethod -Method GET -Headers $headers -Uri $uri

# Get security settings
$uri = $api + "alms/$serial/security"
$securitySettings = Invoke-RestMethod -Method GET -Headers $headers -Uri $uri

# Get settings for automatic updates
$uri = $api + "alms/$serial/automaticUpdate"
$automaticUpdates = Invoke-RestMethod -Method GET -Headers $headers -Uri $uri

# Query for available firmware updates
$uri = $api + "alms/$serial/updates"
$firmwareAvailable = Invoke-RestMethod -Method GET -Headers $headers -Uri $uri

# Deauthentication
$uri = $api + "authenticate"
$deauth = Invoke-RestMethod -Method DELETE -ContentType 'application/json' -Headers $headers -Verbose -Uri $uri