\
]Param (
  $accessToken
  $method
)

$headers = @{Authorization = "Bearer ya29.a0AfB_byCfTQJA8SYw3DY012roC6xSoj4FlMobi9EJf3JfeO_qPk8JvbYGL2mQ16vgGecWTr4ZU7XVD0CCjqdbYyWV88JRVZO28_NC6pvIRKjMTd52CG0dZvemfBW2DO4zXlYdl0qtXMDzkQlgRIUOC7JsBLKEQXaWPycIq3P0ICBEaCgYKASMSARISFQGOcNnCGyLqkUIAIJp0puiEIw1aqA0179"}
echo "Importing developers"
$baseApiUrl = "https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/developers"

cd ./footlocker-nonprod/developers
$files = ls

foreach ($file in $files )

{ 
$requestPayload = Get-Content $file | ConvertFrom-Json
$email=$requestPayload.email
$FirstName=$requestPayload.firstName
$LastName=$requestPayload.lastName
$userName=$requestPayload.userName

# Write-Host $requestPayload

$json_template = @"
{

  "email" : "$($requestPayload.email.ToLower())",
  "firstName" : "$($requestPayload.firstName)",
  "lastName" : "$($requestPayload.lastName)",
  "userName" : "$($requestPayload.userName)"
}
"@

$reqPayload = $json_template
Write-Host $reqPayload
$token = "$accessToken.substring(0, 471)"
Invoke-WebRequest https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/developers -Method 'POST' -ContentType 'application/json; charset=utf-8' -Body $reqPayload -Headers $headers | Select-Object -Expand Content

}
