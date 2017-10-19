$api = 'https://api.indego.iot.bosch-si.com/api/v1/authenticate'
$user = "max.muster@anywhere.com"
$pass = "supersecret"
$pair = "${user}:${pass}"

$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)

$basicAuthValue = "Basic $base64"
$headers = @{ Authorization = $basicAuthValue }

$jsonbody= @{
    'device' = ""
    'os_type' = "Android"
    'os_version' = "4.0"
    'dvc_manuf' = "unknown"
    'dvc_type' = "unknown"
    } | ConvertTo-Json

$response = Invoke-RestMethod -Method Post -ContentType 'application/json' -Uri $api -Body $jsonbody -Headers $headers  -Verbose| fl *