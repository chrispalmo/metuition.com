Param(
    [parameter(Mandatory=$true)]
    [string] $CloudflareAdminEmail, 
    [parameter(Mandatory=$true)]
    [string] $CloudflareApiKey, 
    [parameter(Mandatory=$true)]
    [string] $CloudflareZoneId
);

# Upload the website

Read-Host -prompt ("Initializing git commit and push. Press any key to continue or ctrl+c to abort")

git add *
git status

$git_commit_message = Read-Host ("Enter a short commit message, or ctrl+c to abort")

git checkout master 
git commit -a -m $git_commit_message
git push

# Clear the Cloudflare cache
<# Credit to [Niels Swimberghe]
(https://swimburger.net/blog/powershell/powershell-snippet-clearing-cloudflare-cache-with-cloudflares-api) #>

Read-Host -Prompt "About to clear the Cloudflare cache. Press any key to continue, or ctrl+c to abort"

$PurgeCacheUri = "https://api.cloudflare.com/client/v4/zones/$CloudflareZoneId/purge_cache";
$RequestHeader = @{
    'X-Auth-Email' = $CloudflareAdminEmail
    'X-Auth-Key' = $CloudflareApiKey
};
$RequestBody = '{"purge_everything":true}';
Invoke-RestMethod `
    -Uri $PurgeCacheUri `
    -Method Delete `
    -ContentType  "application/json" `
    -Headers $requestHeader `
    -Body $RequestBody
