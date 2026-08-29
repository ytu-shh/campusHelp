# PowerShell script to fix JSP files

$jspDir = "f:\2025.4.22\campusHelp\campusHelp\WebContent"

# Get all JSP files
$jspFiles = Get-ChildItem -Path $jspDir -Filter "*.jsp" -Recurse

foreach ($file in $jspFiles) {
    Write-Host "Processing $($file.FullName)"
    
    # Read file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # 1. Add fn taglib if not already present
    if ($content -match '@@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"@@>') {
        $content = $content -replace '@@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"@@>','@@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"@@>@@@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"@@>'
    }
    
    # 2. Replace message container with fn:escapeXml approach
    $pattern = '<c:if test="\$\{!empty msg \}">.*?<\/c:if>'
    $replacement = '<c:if test="\$\{!empty msg \}"><script type="text/javascript">var msg = \'<c:out value="\$\{fn:escapeXml(msg)\}"\/>\';alert(msg);<\/script><\/c:if>\r\n'
    $content = $content -replace $pattern, $replacement
    
    # Write back to file
    Set-Content -Path $file.FullName -Value $content -Force
    
    Write-Host "Fixed $($file.Name)"
}

Write-Host "All JSP files processed!"