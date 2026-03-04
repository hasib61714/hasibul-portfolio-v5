# ══ GitHub Topics Auto-Adder ══
# Run করুন: .\add_topics.ps1 -Token "ghp_xxxxxxxxxxxx"

param(
    [Parameter(Mandatory=$true)]
    [string]$Token
)

$OWNER  = "hasib61714"
$HEADER = @{
    "Authorization"        = "Bearer $Token"
    "Accept"               = "application/vnd.github+json"
    "X-GitHub-Api-Version" = "2022-11-28"
}

# ══ প্রতিটি Repo-এর Topics ══
$repoTopics = @{
    "hasibul-portfolio-v5"       = @("html","css","javascript","portfolio","frontend")
    "red-data-website"           = @("javascript","react","typescript","frontend","website")
    "hair-erp-main"              = @("typescript","react","erp","supabase","tailwind","fullstack")
    "imap-bangladesh"            = @("javascript","react","ai","nodejs","fullstack")
    "internship-hub-backend"     = @("php","laravel","mysql","rest-api","backend")
    "internship-hub"             = @("javascript","react","laravel","mysql","fullstack","jwt")
    "heart-disease-prediction"   = @("python","machine-learning","fastapi","scikit-learn","react","data-science")
    "first-project2"             = @("javascript","html","css","todo-app","frontend")
    "first-project"              = @("javascript","html","css","frontend")
}

Write-Host "`n🚀 GitHub Topics আপডেট শুরু হচ্ছে...`n" -ForegroundColor Cyan

foreach ($repo in $repoTopics.Keys) {
    $url  = "https://api.github.com/repos/$OWNER/$repo/topics"
    $body = @{ names = $repoTopics[$repo] } | ConvertTo-Json

    try {
        Invoke-RestMethod -Uri $url -Method Put -Headers $HEADER -Body $body -ContentType "application/json" | Out-Null
        Write-Host "✅ $repo" -ForegroundColor Green
        Write-Host "   Topics: $($repoTopics[$repo] -join ', ')" -ForegroundColor DarkGray
    } catch {
        Write-Host "❌ $repo — Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n✅ সব শেষ! Portfolio-এ filter এখন কাজ করবে।`n" -ForegroundColor Green
Write-Host "🔗 https://hasib61714.github.io/hasibul-portfolio-v5/" -ForegroundColor Cyan
