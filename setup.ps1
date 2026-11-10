# setup.ps1 - Doczilla project initialization (ASCII-only version)

Write-Host "Starting Doczilla project initialization..." -ForegroundColor Cyan

# 1. Create folders
$folders = @(
    "01_business_process",
    "02_document_template/field_cards",
    "02_document_template/export_samples",
    "03_ai_extraction/prompts",
    "03_ai_extraction/examples",
    "04_qa_testing/check_cards",
    "04_qa_testing/test_data/T01_full_correct",
    "04_qa_testing/test_data/T02_missing_inn",
    "04_qa_testing/test_data/T03_price_conflict",
    "04_qa_testing/test_data/T04_advance_0",
    "04_qa_testing/test_data/T05_advance_100",
    "04_qa_testing/test_data/T06_nested",
    "04_qa_testing/test_data/T07_multiplier",
    "04_qa_testing/test_data/T08_long_name",
    "04_qa_testing/test_data/T09_date_formats",
    "04_qa_testing/test_data/T10_two_appendices",
    "04_qa_testing/test_data/T11_cross_ref",
    "04_qa_testing/test_data/T12_export",
    "05_integration",
    "06_report/screenshots",
    "docs/meeting_notes",
    "docs/decisions",
    ".github/ISSUE_TEMPLATE"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Path $folder -Force | Out-Null
    Write-Host "  Created: $folder" -ForegroundColor Gray
}

# 2. Create .gitkeep in empty folders
Get-ChildItem -Directory -Recurse | ForEach-Object {
    if ((Get-ChildItem $_.FullName -Force).Count -eq 0) {
        New-Item -ItemType File -Path "$($_.FullName)/.gitkeep" -Force | Out-Null
    }
}

# 3. Create README.md (ASCII-safe)
$readme = @"
# Doczilla Contract Automation Project

Contract automation in Doczilla: template -> AI-fill -> checklist -> DOCX/PDF export.

## Team
- Student 1 (Architect): template + business process
- Student 2 (AI): prompts and extraction
- Student 3 (QA): tests and metrics
"@
$readme | Out-File -FilePath "README.md" -Encoding ascii

# 4. Create other base files
"# Changelog`n" | Out-File -FilePath "CHANGELOG.md" -Encoding ascii
"# Project Scope`n" | Out-File -FilePath "PROJECT_SCOPE.md" -Encoding ascii
"# Architecture`n" | Out-File -FilePath "ARCHITECTURE.md" -Encoding ascii

# 5. Create .gitignore
$gitignore = @"
.DS_Store
Thumbs.db
desktop.ini
*.tmp
*.bak
*~
.vscode/
.idea/
*.pdf
*.docx
.env
"@
$gitignore | Out-File -FilePath ".gitignore" -Encoding ascii

# 6. Git init
Write-Host "`nInitializing Git..." -ForegroundColor Cyan
git init
git add .
git commit -m "feat: initialize Doczilla project structure"

# 7. Create develop branch
Write-Host "`nCreating develop branch..." -ForegroundColor Cyan
git checkout -b develop
git checkout main

Write-Host "`nDone! Structure created." -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  git remote add origin YOUR_REPO_URL" -ForegroundColor Yellow
Write-Host "  git push -u origin main develop" -ForegroundColor Yellow