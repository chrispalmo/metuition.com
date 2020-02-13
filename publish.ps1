# Import configurations and secret keys from config.json

$config = Get-Content -Raw -Path .\scripts\config.json | ConvertFrom-Json

# Pass the configurations and secret keys as arguments into the script that does the actual work:

./scripts/commit_push_clear_cache.ps1 `
	-CloudflareAdminEmail $config.CloudflareAdminEmail `
	-CloudflareApiKey $config.CloudflareApiKey `
	-CloudflareZoneId $config.CloudflareZoneId
