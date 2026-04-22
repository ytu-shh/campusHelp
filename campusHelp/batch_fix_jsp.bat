@echo off
setlocal enabledelayedexpansion

REM 定义要处理的目录
set "JSP_DIR=f:\2025.4.22\campusHelp\campusHelp\WebContent"

REM 遍历所有JSP文件
for /r "%JSP_DIR%" %%f in (*.jsp) do (
    echo Processing %%f
    
    REM 检查文件是否包含taglib指令
    findstr /i "<%@taglib" "%%f" >nul
    if errorlevel 1 (
        echo No taglib found in %%f, skipping
        goto nextfile
    )
    
    REM 1. 添加fn标签库
    powershell -Command "(Get-Content '%%f') -replace '@@taglib prefix=\"fmt\" uri=\"http://java.sun.com/jsp/jstl/fmt\"%%>','@@taglib prefix=\"fmt\" uri=\"http://java.sun.com/jsp/jstl/fmt\"%%>@@@taglib prefix=\"fn\" uri=\"http://java.sun.com/jsp/jstl/functions\"%%>' | Set-Content '%%f'"
    
    REM 2. 替换消息提示代码
    powershell -Command "(Get-Content '%%f') -replace '<c:if test=\"\$\{!empty msg \}\">.*?<\/c:if>','<c:if test=\"\$\{!empty msg \}\"><script type=\"text/javascript\">var msg = \'<c:out value=\"\$\{fn:escapeXml(msg)\}\"\/>\';alert(msg);<\/script><\/c:if>\r\n' | Set-Content '%%f'"
    
    :nextfile
)

echo All JSP files processed!