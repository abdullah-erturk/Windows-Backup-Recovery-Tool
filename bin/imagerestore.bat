@echo off
setlocal enabledelayedexpansion
set "SCRIPT_DIR=%~dp0"

REM ======== D˜L AYARLARI / LANGUAGE SETTINGS ========
set "LANG=EN"

REM 1. Registry Detection
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Nls\Language" /v InstallLanguage 2>nul | findstr "041F" >nul
if !errorlevel! equ 0 set "LANG=TR"

REM 2. WinPE Specific
if "!LANG!"=="TR" goto skip_detect
where wpeutil >nul 2>&1
if !errorlevel! equ 0 (
    wpeutil ListKeyboardLayouts 2>nul | findstr /i "041f" >nul
    if !errorlevel! equ 0 set "LANG=TR"
)

REM 3. Online User Locale (PowerShell)
if "!ENV!"=="ONLINE" (
    if "!LANG!"=="TR" goto skip_detect
    powershell -NoProfile -Command "exit 0" >nul 2>&1
    if !errorlevel! neq 0 goto skip_detect

    powershell -NoProfile -Command "(Get-UICulture).Name" 2>nul | findstr /i "tr-TR" >nul
    if !errorlevel! equ 0 set "LANG=TR"
)

:skip_detect

REM ======== S™ZLšK / DICTIONARY ========
if "!LANG!"=="TR" goto :lang_tr

:lang_en
    set "MSG_TITLE=Windows Image Restore Tool (Online/Offline)"
    set "MSG_INTRO=This tool restores a Windows WIM/ESD image to a partition or disk."
    set "MSG_SCANNING=Scanning for .wim and .esd files in ROOT directories of all drives... (Note: C: skipped in WinPE)"
    set "ERR_NO_WIM=ERROR: No .wim or .esd files found!"
    set "PROMPT_SELECT_WIM=Select WIM file number (e.g. 1): "
    set "MSG_SELECTED_WIM=Selected WIM: "
    set "MSG_LIST_INDEX=Listing images inside WIM..."
    set "PROMPT_SELECT=Your choice (1 or 2): "
    set "PROMPT_SELECT_INDEX=Select Image Index number (e.g. 1): "
    set "MSG_ENV_ONLINE=[ONLINE DETECTED] Windows is running."
    set "MSG_ENV_OFFLINE=[OFFLINE DETECTED] WinPE Environment."
    set "MSG_ONLINE_WARN=WARNING: Selected volume will be FORMATTED (NTFS)."
    set "PROMPT_SELECT_VOL=Enter Target Volume Number: "
    set "MSG_OFFLINE_WARN=WARNING: Selected DISK will be CLEANED and Repartitioned!"
    set "PROMPT_SELECT_DISK=Enter Target Disk Number: "
    set "ERR_TEMPLATE_MISSING=ERROR: Partition template file not found!"
    set "MSG_APPLYING=Applying Image... This may take a while."
    set "MSG_BOOT_FIX=Fixing Boot Records..."
    set "MSG_DONE=Restore Completed Successfully."
    set "MSG_FAIL=Restore Failed."
    set "PROMPT_CONFIRM=Are you sure you want to proceed? (Y/N): "
    set "MSG_CANCELLED=Cancelled."
    set "PROMPT_RESTORE_TYPE=Select Restore Type:"
    set "TYPE_VOL=1. Restore to Partition (Volume)"
    set "TYPE_DISK=2. Restore to Disk (Clean & Repartition)"
    set "PROMPT_FIRMWARE=Select firmware type for target disk:"
    set "PROMPT_SELECT_FIRMWARE=Select firmware type (e.g. 1):"
    set "FIRMWARE_UEFI=1. UEFI (Modern systems, GPT)"
    set "FIRMWARE_BIOS=2. BIOS/Legacy (Older systems, MBR)"
    set "ERR_ONLINE_C_RESTRICT=ERROR: You cannot restore to the active System Drive (C:) in Online Mode!"
    set "ERR_ONLINE_C_DISK=This disk contains your active C: drive!"
    set "MSG_PRESS_ANY_KEY=Press any key to continue..."
    set "MSG_BCD_TEMP_DRIVE=Temporary drive assigned: S:"
    set "MSG_BCD_COMMAND=BCDBoot command:"
    set "MSG_BCD_TARGET=Target boot partition: S:"
    set "MSG_BCD_SUCCESS=SUCCESS - Boot files created"
    set "MSG_BCD_ERROR=ERROR: BCDBoot failed"
    set "MSG_BCD_REMOVE=Removing temporary drive letter: S:"
    set "MSG_BCD_FALLBACK=Boot partition cannot be determined. Fallback to Target..."
    set "MSG_FW_UEFI_SELECTED=UEFI selected - GPT disk will be created"
    set "MSG_FW_BIOS_SELECTED=BIOS selected - MBR disk will be created"
    set "MSG_FW_TARGET=Target Disk Firmware:"
    set "MSG_TEMPLATE_FILE=Template File:"
    set "MSG_INVALID_SELECTION=Invalid selection!"
    set "MSG_SINGLE_INDEX=Single index found, auto-selecting: 1"
    set "MSG_BOOT_DISK_NOT_FOUND=Boot disk not found, trying standard bcdboot..."
    set "MSG_DISK_TYPE_GPT=Disk type: GPT - UEFI boot will be used"
    set "MSG_DISK_TYPE_MBR=Disk type: MBR - BIOS boot will be used"
    set "MSG_PARENT_DISK=Parent Disk:"
    set "MSG_BOOT_PART_UEFI=Boot partition (UEFI/FAT32/Small) found - Partition"
    set "MSG_BOOT_PART_BIOS_TYPE=Boot partition (BIOS/FAT32/Type0C) found - Partition"
    set "MSG_BOOT_PART_BIOS_ACTIVE=Boot partition (BIOS/FAT32/Active) found - Partition"
    set "MSG_BOOT_PART_FOUND=Boot Partition Found: Partition"
    set "MSG_FORMATTING_VOL=Formatting Volume"
    set "MSG_PARTITIONING=Partitioning Disk..."
    set "MSG_VOL_NO_LETTER=Win_Install labeled volume found without letter! Assigning letter..."
    set "MSG_BOOT_PART_DETECTED=Boot Partition found: Partition"
    set "MSG_SOURCE_WIN=Source Windows:"
    set "MSG_SOURCE_WIN_ERROR=ERROR: Windows\System32 not found!"
    set "MSG_SOURCE_WIN_MISSING=Windows installation is incomplete or corrupted!"
    set "MSG_SOURCE_WIN_VERIFIED=Source Windows verified:"
    set "MSG_BOOT_FALLBACK_WARN=WARNING: Boot partition not found! Fallback mode..."
    set "MSG_BIOS_BOOT_FAIL_TITLE=BIOS Boot Creation Failed"
    set "MSG_BIOS_BOOT_FAIL_REASONS=Possible reasons:"
    set "MSG_BIOS_BOOT_FAIL_R1=1. Windows officially does not support BIOS/MBR"
    set "MSG_BIOS_BOOT_FAIL_R2=2. Image does not contain BIOS boot files"
    set "MSG_BIOS_BOOT_FAIL_SOLUTION=SOLUTION:"
    set "MSG_BIOS_BOOT_FAIL_S1=- Restart the script"
    set "MSG_BIOS_BOOT_FAIL_S2=- When asked for firmware type, select \"1. UEFI\""
    set "MSG_BIOS_BOOT_FAIL_S3=- UEFI is recommended for Windows 11"
    set "MSG_HIGH_PERF=Setting High Performance..."
    set "MSG_FIRMWARE=Firmware:"
    set "ERR_INVALID_NUMBER=ERROR: Invalid number!"
    set "ERR_DISK_NOT_FOUND=ERROR: Disk not found!"
    set "ERR_DISK0_WARNING=CRITICAL WARNING: Disk 0 is typically the BOOT DISK!"
    set "ERR_DISK0_DESTROY=This operation will DESTROY ALL DATA!"
    set "ERR_DISK0_CONFIRM=Type DELETE_ALL_DATA to confirm:"
    set "ERR_DISK0_CANCELLED=Operation cancelled for safety."
    set "ERR_INDEX_RANGE=ERROR: Index must be between 1 and"
    set "ERR_WIM_NOT_ACCESSIBLE=ERROR: WIM file not found or not accessible!"
    set "MSG_WIM_PATH=Path:"
    goto :lang_done

:lang_tr
    set "MSG_TITLE=Windows ˜maj Geri Ykleme Arac (€evrimi‡i/€evrimdŸ)"
    set "MSG_INTRO=Bu ara‡ WIM/ESD imajn bir b”lme veya diske geri ykler."
    set "MSG_SCANNING=Tm srclerin ANA D˜Z˜N˜NDE .wim ve .esd dosyalar aranyor... (Not: WinPE'de C: taranmaz)"
    set "ERR_NO_WIM=HATA: Hi‡bir .wim veya .esd dosyas bulunamad!"
    set "PROMPT_SELECT_WIM=WIM dosya numarasn se‡in (”rn: 1): "
    set "MSG_SELECTED_WIM=Se‡ilen WIM: "
    set "PROMPT_SELECT=Se‡iminiz (1 yada 2): "
    set "PROMPT_SELECT_INDEX=˜maj ˜ndeks numarasn se‡in (”rn: 1): "
    set "MSG_LIST_INDEX=WIM i‡indeki imajlar listeleniyor..."
    set "MSG_ENV_ONLINE=[ONLINE ALGILANDI] Windows ‡alŸyor."
    set "MSG_ENV_OFFLINE=[OFFLINE ALGILANDI] WinPE Ortam."
    set "MSG_ONLINE_WARN=UYARI: Se‡ilen b”lm FORMATLANACAK (NTFS)."
    set "PROMPT_SELECT_VOL=Hedef Volume Numarasn Girin: "
    set "MSG_OFFLINE_WARN=UYARI: Se‡ilen D˜SK tamamen TEM˜ZLENECEK ve yeniden b”lmlenecek!"
    set "PROMPT_SELECT_DISK=Hedef Disk Numarasn Girin: "
    set "ERR_TEMPLATE_MISSING=HATA: B”lmleme Ÿablon dosyas bulunamad!"
    set "MSG_APPLYING=˜maj Ykleniyor... Bu iŸlem zaman alabilir."
    set "MSG_BOOT_FIX=™nykleme (Boot) Kaytlar Onarlyor..."
    set "MSG_DONE=Geri Ykleme BaŸaryla Tamamland."
    set "MSG_FAIL=Geri Ykleme BaŸarsz."
    set "PROMPT_CONFIRM=˜Ÿleme baŸlamak istedi§inize emin misiniz? (E/H): "
    set "MSG_CANCELLED=˜Ÿlem ˜ptal Edildi."
    set "PROMPT_RESTORE_TYPE=Geri Ykleme Tr Se‡in:"
    set "TYPE_VOL=1. B”lme Ykle (Volume)"
    set "TYPE_DISK=2. Diske Ykle (Sil ve Yeniden B”lmle)"
    set "PROMPT_FIRMWARE=Hedef disk i‡in firmware tipini se‡in:"
    set "PROMPT_SELECT_FIRMWARE=Firmware tipini se‡in (”rn: 1):"
    set "FIRMWARE_UEFI=1. UEFI (Modern sistemler, GPT)"
    set "FIRMWARE_BIOS=2. BIOS/Legacy (Eski sistemler, MBR)"
    set "ERR_ONLINE_C_RESTRICT=HATA: €alŸan Windows (C:) zerine geri ykleme yapamazsnz!"
    set "ERR_ONLINE_C_DISK=Bu disk aktif C: srcsn i‡eriyor!"
    set "MSG_PRESS_ANY_KEY=Devam etmek i‡in bir tuŸa basn..."
    set "MSG_BCD_TEMP_DRIVE=Ge‡ici src atand: S:"
    set "MSG_BCD_COMMAND=BCDBoot komutu:"
    set "MSG_BCD_TARGET=Hedef boot partition: S:"
    set "MSG_BCD_SUCCESS=BAžARILI - Boot dosyalar oluŸturuldu"
    set "MSG_BCD_ERROR=HATA: BCDBoot baŸarsz"
    set "MSG_BCD_REMOVE=Ge‡ici src harfi kaldrlyor: S:"
    set "MSG_BCD_FALLBACK=Boot partition bulunamad. Hedef b”lme yazlyor..."
    set "MSG_FW_UEFI_SELECTED=UEFI se‡ildi - GPT disk oluŸturulacak"
    set "MSG_FW_BIOS_SELECTED=BIOS se‡ildi - MBR disk oluŸturulacak"
    set "MSG_FW_TARGET=Hedef Disk Firmware:"
    set "MSG_TEMPLATE_FILE=žablon Dosyas:"
    set "MSG_INVALID_SELECTION=Ge‡ersiz se‡im!"
    set "MSG_SINGLE_INDEX=Tek Index bulundu, otomatik se‡iliyor: 1"
    set "MSG_BOOT_DISK_NOT_FOUND=Boot Disk bulunamad, standart bcdboot deneniyor..."
    set "MSG_DISK_TYPE_GPT=Disk tipi: GPT - UEFI boot kullanlacak"
    set "MSG_DISK_TYPE_MBR=Disk tipi: MBR - BIOS boot kullanlacak"
    set "MSG_PARENT_DISK=Parent Disk:"
    set "MSG_BOOT_PART_UEFI=Boot partition (UEFI/FAT32/Small) bulundu - Partition"
    set "MSG_BOOT_PART_BIOS_TYPE=Boot partition (BIOS/FAT32/Type0C) bulundu - Partition"
    set "MSG_BOOT_PART_BIOS_ACTIVE=Boot partition (BIOS/FAT32/Active) bulundu - Partition"
    set "MSG_BOOT_PART_FOUND=Boot Partition Found: Partition"
    set "MSG_FORMATTING_VOL=Formatting Volume"
    set "MSG_PARTITIONING=Partitioning Disk..."
    set "MSG_VOL_NO_LETTER=\"Win_Install\" etiketli volume harfsiz bulundu! Harf atanyor..."
    set "MSG_BOOT_PART_DETECTED=Boot Partition bulundu: Partition"
    set "MSG_SOURCE_WIN=Kaynak Windows:"
    set "MSG_SOURCE_WIN_ERROR=HATA: Windows\System32 bulunamad!"
    set "MSG_SOURCE_WIN_MISSING=Windows kurulumu eksik veya hatal!"
    set "MSG_SOURCE_WIN_VERIFIED=Kaynak Windows do§ruland:"
    set "MSG_BOOT_FALLBACK_WARN=UYARI: Boot partition bulunamad! Fallback mod..."
    set "MSG_BIOS_BOOT_FAIL_TITLE=BIOS Boot OluŸturma BaŸarsz"
    set "MSG_BIOS_BOOT_FAIL_REASONS=Olaslklar:"
    set "MSG_BIOS_BOOT_FAIL_R1=1. Windows resmi olarak BIOS/MBR desteklemiyor"
    set "MSG_BIOS_BOOT_FAIL_R2=2. ˜maj BIOS boot dosyalar i‡ermiyor"
    set "MSG_BIOS_BOOT_FAIL_SOLUTION=€™ZšM:"
    set "MSG_BIOS_BOOT_FAIL_S1=- Script'i yeniden ‡alŸtrn"
    set "MSG_BIOS_BOOT_FAIL_S2=- Firmware tipi soruldu§unda \"1. UEFI\" se‡in"
    set "MSG_BIOS_BOOT_FAIL_S3=- Windows 11 i‡in UEFI kullanmanz ”nerilir"
    set "MSG_HIGH_PERF=Setting High Performance..."
    set "MSG_FIRMWARE=Firmware:"
    set "ERR_INVALID_NUMBER=HATA: Ge‡ersiz numara!"
    set "ERR_DISK_NOT_FOUND=HATA: Disk bulunamad!"
    set "ERR_DISK0_WARNING=KR˜T˜K UYARI: Disk 0 genellikle BOOT D˜SK˜D˜R!"
    set "ERR_DISK0_DESTROY=Bu iŸlem TšM VER˜LER˜ YOK EDECEK!"
    set "ERR_DISK0_CONFIRM=Onaylamak i‡in DELETE_ALL_DATA yazn:"
    set "ERR_DISK0_CANCELLED=Gvenlik i‡in iŸlem iptal edildi."
    set "ERR_INDEX_RANGE=HATA: Index 1 ile arasnda olmal"
    set "ERR_WIM_NOT_ACCESSIBLE=HATA: WIM dosyas bulunamad veya eriŸilemiyor!"
    set "MSG_WIM_PATH=Yol:"
    goto :lang_done

:lang_done
cls
echo ========================================================
echo !MSG_TITLE!
echo ========================================================
echo !MSG_INTRO!
echo.

REM ======== ORTAM VE FIRMWARE ALGILAMA ========
reg query "HKLM\SYSTEM\CurrentControlSet\Control\MiniNT" >nul 2>&1
if !errorlevel! equ 0 (
    set "ENV=OFFLINE"
    echo !MSG_ENV_OFFLINE!
    
    REM WinPE Power Settings (Prevent Sleep/Network Drop)
    echo !MSG_HIGH_PERF!
    powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>nul
    powercfg /x -monitor-timeout-ac 0 2>nul
    powercfg /x -disk-timeout-ac 0 2>nul
    
    REM Getting Firmware in WinPE
    reg query "HKLM\System\CurrentControlSet\Control" /v PEFirmwareType 2>nul | find "0x2" >nul
    if !errorlevel! equ 0 (set "FWT=UEFI") else (set "FWT=BIOS")
) else (
    set "ENV=ONLINE"
    echo !MSG_ENV_ONLINE!
    
    REM Getting Firmware in Online
    REM Robust Check 1: SecureBoot key only exists on UEFI systems
    reg query "HKLM\System\CurrentControlSet\Control\SecureBoot\State" >nul 2>&1
    if !errorlevel! equ 0 (
        set "FWT=UEFI"
    ) else (
        REM Robust Check 2: Check bcdedit for .efi extension
        bcdedit /enum {current} 2>nul | findstr /i "\.efi" >nul
        if !errorlevel! equ 0 (set "FWT=UEFI") else (set "FWT=BIOS")
    )
)
set "TEMPLATE=!SCRIPT_DIR!bios.txt"
if "!FWT!"=="UEFI" set "TEMPLATE=!SCRIPT_DIR!efi.txt"

echo !MSG_FIRMWARE! !FWT!
echo.

REM ======== WIM/ESD TARAMA ========
echo !MSG_SCANNING!
set count=0
if exist "%TEMP%\wimlist.txt" del "%TEMP%\wimlist.txt"

REM BULK NETWORK DETECTION SNAPSHOT (High Performance)
if "!ENV!"=="ONLINE" (
    powershell -NoProfile -Command "Get-PSDrive -PSProvider FileSystem | Where-Object {$_.DisplayRoot -ne $null} | Select-Object @{N='Drive';E={$_.Name}}, @{N='Root';E={$_.DisplayRoot}} | Format-Table -HideTableHeaders -AutoSize" > "%TEMP%\ps_network_drives.tmp" 2>nul
)

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    set "scan=true"
    if "!ENV!"=="OFFLINE" if /i "%%d"=="C" set "scan=false"
    
    set "scan_target="
    set "drivelabel="
    
    REM -----------------------------------------------------
    REM STEP 1: Basic Existence Check (Local & Visible Network)
    REM -----------------------------------------------------
    if exist %%d:\ (
        set "scan_target=%%d:\"
        set "drivelabel=[%%d:\]"
        
        REM Try to get nicer label from net use (but don't fail if not found)
        net use | findstr /i "%%d:" > "%TEMP%\netcheck.tmp" 2>nul
        if !errorlevel! equ 0 (
             for /f "tokens=1,2,3" %%A in ('type "%TEMP%\netcheck.tmp"') do (
                 if /i "%%B"=="%%d:" set "drivelabel=[%%C]"
             )
        )
    )

    REM -----------------------------------------------------
    REM STEP 2: Bulk Cache Check (Augment or Fill Gap)
    REM -----------------------------------------------------
    REM This is crucial for Win10 (Invisible drives) AND Win11 (Network Labels)
    if exist "%TEMP%\ps_network_drives.tmp" (
         findstr /i /b "%%d" "%TEMP%\ps_network_drives.tmp" > "%TEMP%\ps_drive_match.tmp"
         if !errorlevel! equ 0 (
             for /f "tokens=1,*" %%P in ('type "%TEMP%\ps_drive_match.tmp"') do (
                 set "drivelabel=[%%Q]"
                 REM If scan_target was empty (Win10 Invisible), use the UNC path from cache
                 if not defined scan_target set "scan_target=%%Q\"
             )
         )
    )

    REM -----------------------------------------------------
    REM STEP 3: Registry Fallback (Last Resort for Legacy scenarios)
    REM -----------------------------------------------------
    if not defined scan_target if "!ENV!"=="ONLINE" (
         reg query "HKCU\Network\%%d" /v RemotePath >nul 2>nul
         if !errorlevel! equ 0 (
             for /f "tokens=2,*" %%A in ('reg query "HKCU\Network\%%d" /v RemotePath 2^>nul') do (
                  set "scan_target=%%B\"
                  set "drivelabel=[%%B]"
             )
         )
    )
    
    REM -----------------------------------------------------
    REM STEP 4: Double-Check Hidden Drive via Debug Trick
    REM -----------------------------------------------------
    if not defined scan_target (
         if exist %%d:\\ (
             set "scan_target=%%d:\"
             set "drivelabel=[%%d:\]"
         )
    )
    
    REM Perform Scanning if a target was found
    if defined scan_target if "!scan!"=="true" (
        
        REM Search in root directory (WIM and ESD combined)
        dir /b /a-d "!scan_target!*.wim" "!scan_target!*.esd" 2>nul > "%TEMP%\imajesearch.tmp"
        if exist "%TEMP%\imajesearch.tmp" (
            for /f "usebackq delims=" %%f in ("%TEMP%\imajesearch.tmp") do (
                set /a count+=1
                echo !count!. !drivelabel! %%f
                echo !scan_target!%%f>> "%TEMP%\wimlist.txt"
            )
            del "%TEMP%\imajesearch.tmp"
        )
        
        REM Search in sources subfolder (WIM and ESD combined, exclude boot.wim/esd)
        if exist "!scan_target!sources\" (
            dir /b /a-d "!scan_target!sources\*.wim" "!scan_target!sources\*.esd" 2>nul > "%TEMP%\imajesearch_sources.tmp"
            if exist "%TEMP%\imajesearch_sources.tmp" (
                for /f "usebackq delims=" %%f in ("%TEMP%\imajesearch_sources.tmp") do (
                    REM Filter out boot.wim/boot.esd (case-insensitive)
                    set "filename=%%f"
                    echo !filename! | findstr /i /c:"boot.wim" /c:"boot.esd" >nul
                    if !errorlevel! neq 0 (
                        set /a count+=1
                        echo !count!. !drivelabel!\sources\ %%f
                        echo !scan_target!sources\%%f>> "%TEMP%\wimlist.txt"
                    )
                )
                del "%TEMP%\imajesearch_sources.tmp"
            )
        )
    )
)

if !count! equ 0 (
    echo !ERR_NO_WIM!
    echo !MSG_PRESS_ANY_KEY!
    pause >nul
    exit /b
)

echo.
set /p wimselect=!PROMPT_SELECT_WIM!

REM Se‡ilen dosyay bul
set sel=0
for /f "usebackq tokens=*" %%i in ("%TEMP%\wimlist.txt") do (
    set /a sel+=1
    if !sel! equ !wimselect! set "selected_wim=%%i"
)

if not defined selected_wim (
    echo !MSG_INVALID_SELECTION!
    echo !MSG_PRESS_ANY_KEY!
    pause >nul
    exit /b
)

REM WIM file accessibility check
if not exist "!selected_wim!" (
    echo.
    echo !ERR_WIM_NOT_ACCESSIBLE!
    echo !MSG_WIM_PATH! !selected_wim!
    echo !MSG_PRESS_ANY_KEY!
    pause >nul
    exit /b
)

echo !MSG_SELECTED_WIM! !selected_wim!
echo.

REM ======== INDEX LISTELEME ========
echo !MSG_LIST_INDEX!
dism /Get-ImageInfo /ImageFile:"!selected_wim!" > "%TEMP%\wiminfo.txt"
type "%TEMP%\wiminfo.txt"

set indexcount=0
for /f "tokens=3" %%a in ('find /c "Index :" "%TEMP%\wiminfo.txt"') do set indexcount=%%a

if !indexcount! equ 1 (
    echo.
    echo !MSG_SINGLE_INDEX!
    set indexselect=1
    goto index_selected
)

echo.
:select_index_loop
set /p indexselect=!PROMPT_SELECT_INDEX!

REM Validate number (trim spaces)
set "indexselect=!indexselect: =!"
if "!indexselect!"=="" (
    echo !ERR_INVALID_NUMBER!
    goto select_index_loop
)
echo !indexselect!| findstr /r "^[0-9][0-9]*$" >nul
if !errorlevel! neq 0 (
    echo !ERR_INVALID_NUMBER!
    goto select_index_loop
)

REM Range check
if !indexselect! LSS 1 (
    echo !ERR_INDEX_RANGE! !indexcount!
    goto select_index_loop
)
if !indexselect! GTR !indexcount! (
    echo !ERR_INDEX_RANGE! !indexcount!
    goto select_index_loop
)

:index_selected

REM ======== RESTORE TYPE MENU ========
echo.
echo !PROMPT_RESTORE_TYPE!
echo !TYPE_VOL!
echo !TYPE_DISK!
set /p rtype=!PROMPT_SELECT!
if "!rtype!"=="2" goto restore_disk
REM Default to volume (1)

:restore_volume
echo.
if "!ENV!"=="ONLINE" echo !MSG_ONLINE_WARN!
if "!ENV!"=="OFFLINE" echo !MSG_ONLINE_WARN!
REM Note: Using same warning "Selected Volume will be Formatted" is appropriate for both.

echo ========================
echo list volume > "%TEMP%\disklist.txt"
diskpart /s "%TEMP%\disklist.txt"
echo ========================

:select_volume_loop
set /p volselect=!PROMPT_SELECT_VOL!

REM Volume number validation (trim spaces)
set "volselect=!volselect: =!"
if "!volselect!"=="" (
    echo !ERR_INVALID_NUMBER!
    goto select_volume_loop
)
echo !volselect!| findstr /r "^[0-9][0-9]*$" >nul
if !errorlevel! neq 0 (
    echo !ERR_INVALID_NUMBER!
    goto select_volume_loop
)

REM SAFETY CHECK: Check if selected volume is C:
if "!ENV!"=="ONLINE" (
    REM Get volume list to find C: drive
    echo list volume > "%TEMP%\check_vol_c.txt"
    diskpart /s "%TEMP%\check_vol_c.txt" > "%TEMP%\vol_list_c.txt"
    
    REM Find the line with selected volume number (exact match with spaces)
    findstr /r /c:"  Volume !volselect!  " "%TEMP%\vol_list_c.txt" > "%TEMP%\selected_vol_line.txt"
    
    REM Check if this line contains " C " (C: drive)
    findstr /c:" C " "%TEMP%\selected_vol_line.txt" >nul
    if !errorlevel! equ 0 (
        echo.
        echo ==========================================
        echo !ERR_ONLINE_C_RESTRICT!
        echo !ERR_ONLINE_C_DISK!
        echo ==========================================
        echo.
        echo !MSG_PRESS_ANY_KEY!
        pause >nul
        goto select_volume_loop
    )
)

REM Proceed to formatting

REM 1. Get Existing Letter (Robust List Volume Parsing)
echo list volume > "%TEMP%\listvol_chk.txt"
diskpart /s "%TEMP%\listvol_chk.txt" > "%TEMP%\vol_chk.txt"
set "old_letter="

REM Language-Independent Match (Ignores "Volume" or "Birim" keyword)
REM Matches:
REM "  Volume 5  C" -> Token 2=5, Token 3=C
REM "* Volume 5  C" -> Token 3=5, Token 4=C (Token 1=*)
for /f "usebackq tokens=1,2,3,4" %%a in ("%TEMP%\vol_chk.txt") do (
    REM Case 1: Standard Line (Token 2 is Volume ID)
    if "%%b"=="!volselect!" (
        set "candidate=%%c"
        echo !candidate!| findstr /r "^[A-Z]$" >nul
        if !errorlevel! equ 0 set "old_letter=!candidate!"
    )
    REM Case 2: Selected Line (Token 1 is *, Token 3 is Volume ID)
    if "%%a"=="*" if "%%c"=="!volselect!" (
        set "candidate=%%d"
        echo !candidate!| findstr /r "^[A-Z]$" >nul
        if !errorlevel! equ 0 set "old_letter=!candidate!"
    )
)

echo.
if defined old_letter (
    echo EXISTING DRIVE LETTER PRESERVED: !old_letter!
)

echo !MSG_FORMATTING_VOL! !volselect!...
echo select volume !volselect! > "%TEMP%\format.txt"
echo format fs=ntfs quick label="Win_Install" override >> "%TEMP%\format.txt"

REM If a letter existed, FORCE assign it back because FORMAT often strips it in WinPE
if defined old_letter (
    echo assign letter=!old_letter! >> "%TEMP%\format.txt"
) else (
    REM Only auto-assign if no letter existed
    echo assign >> "%TEMP%\format.txt"
)
diskpart /s "%TEMP%\format.txt" > "%TEMP%\partlog.txt"

REM 2. Verify Target Drive (Read again to be sure)
echo list volume > "%TEMP%\listvol_verify.txt"
diskpart /s "%TEMP%\listvol_verify.txt" > "%TEMP%\vol_verify.txt"
set "targetdrive="
findstr /r /c:" Volume !volselect! " "%TEMP%\vol_verify.txt" > "%TEMP%\verify_line.txt"

for /f "usebackq tokens=3" %%a in ("%TEMP%\verify_line.txt") do (
    set "candidate=%%a"
    echo !candidate!| findstr /r "^[A-Z]$" >nul
    if !errorlevel! equ 0 set "targetdrive=!candidate!"
)

REM Last resort: If still no letter, assign AUTO (not Z)
if not defined targetdrive (
    echo select volume !volselect! > "%TEMP%\force_auto.txt"
    echo assign >> "%TEMP%\force_auto.txt"
    diskpart /s "%TEMP%\force_auto.txt"
    
    REM Read one last time
    echo list volume > "%TEMP%\listvol_final.txt"
    diskpart /s "%TEMP%\listvol_final.txt" > "%TEMP%\vol_final.txt"
    findstr /c:"Volume !volselect!" "%TEMP%\vol_final.txt" > "%TEMP%\final_line.txt"
    for /f "usebackq tokens=3" %%a in ("%TEMP%\final_line.txt") do (
        set "candidate=%%a"
        echo !candidate!| findstr /r "^[A-Z]$" >nul
        if !errorlevel! equ 0 set "targetdrive=!candidate!"
    )
)

echo !MSG_APPLYING! ^(Target: !targetdrive!:\^)
dism /Apply-Image /ImageFile:"!selected_wim!" /Index:!indexselect! /ApplyDir:!targetdrive!:\

if !errorlevel! neq 0 (
    echo !MSG_FAIL!
    goto :restore_finish
)

echo !MSG_BOOT_FIX!
REM ==========================================================
REM SMART BOOT PARTITION DETECTION (Flattened - No Parser Errors)
REM ==========================================================
set "bootpart="

REM 1. Find Parent Disk
echo select volume !volselect! > "%TEMP%\finddisk.txt"
echo list disk >> "%TEMP%\finddisk.txt"
diskpart /s "%TEMP%\finddisk.txt" > "%TEMP%\disk_res.txt"

set "parentdisk="
findstr /c:"* Disk" "%TEMP%\disk_res.txt" > "%TEMP%\start_disk.txt"
for /f "usebackq tokens=3" %%a in ("%TEMP%\start_disk.txt") do set "parentdisk=%%a"

if not defined parentdisk (
    echo !MSG_BOOT_DISK_NOT_FOUND!
    bcdboot !targetdrive!:\Windows /f !FWT!
    goto :restore_success
)

REM 1.5. Detect disk type (GPT or MBR) from list disk output
REM In "list disk" output, GPT disks have an asterisk (*) in the Gpt column
echo list disk > "%TEMP%\check_gpt.txt"
diskpart /s "%TEMP%\check_gpt.txt" > "%TEMP%\gpt_check.txt"

REM Find the line for our parent disk and check if it has * in Gpt column
REM Format: "  Disk 2    Online          200 GB      0 B        *"
REM The asterisk appears in the last column for GPT disks
findstr /r "Disk !parentdisk! " "%TEMP%\gpt_check.txt" > "%TEMP%\disk_line.txt"

REM Check if the line ends with asterisk (GPT marker)
findstr /r "\*$" "%TEMP%\disk_line.txt" >nul
if !errorlevel! equ 0 (
    set "FWT=UEFI"
    echo !MSG_DISK_TYPE_GPT!
) else (
    set "FWT=BIOS"
    echo !MSG_DISK_TYPE_MBR!
)

echo !MSG_PARENT_DISK! !parentdisk! ^(Firmware: !FWT!^)

REM 2. Search partitions
echo select disk !parentdisk! > "%TEMP%\listpart.txt"
echo list partition >> "%TEMP%\listpart.txt"
diskpart /s "%TEMP%\listpart.txt" > "%TEMP%\parts.txt"

if "!FWT!"=="UEFI" goto :search_uefi
goto :search_bios

:search_uefi
REM UEFI: Look for FAT32 partition with small size (EFI System Partition)
REM EFI partitions are typically 100-500 MB and FAT32 formatted
echo select disk !parentdisk! > "%TEMP%\list_all.txt"
echo list partition >> "%TEMP%\list_all.txt"
diskpart /s "%TEMP%\list_all.txt" > "%TEMP%\all_parts.txt"

REM Check each partition for FAT32 + small size
for /f "tokens=2" %%p in ('findstr /r "Partition" "%TEMP%\all_parts.txt"') do (
    if "%%p" neq "###" if "%%p" neq "Partition" (
        echo select disk !parentdisk! > "%TEMP%\chk_efi.txt"
        echo select partition %%p >> "%TEMP%\chk_efi.txt"
        echo detail partition >> "%TEMP%\chk_efi.txt"
        diskpart /s "%TEMP%\chk_efi.txt" > "%TEMP%\efi_det.txt"
        
        REM Check for FAT32
        findstr /i "FAT32" "%TEMP%\efi_det.txt" >nul
        if !errorlevel! equ 0 (
            REM Check size - look for MB in the output (either Size line or Volume line)
            REM EFI partitions are typically 100-500 MB
            findstr /r "MB" "%TEMP%\efi_det.txt" >nul
            if !errorlevel! equ 0 (
                REM Also check it's not GB (to ensure it's small)
                findstr /r "GB" "%TEMP%\efi_det.txt" >nul
                if !errorlevel! neq 0 (
                    REM Found FAT32 partition with MB size (not GB) - this is EFI
                    set "bootpart=%%p"
                    echo !MSG_BOOT_PART_UEFI! %%p
                    goto :mount_boot
                )
            )
        )
    )
)
goto :mount_boot

:search_bios
REM BIOS: Look for Active FAT32 partition (Type 0C or 0B)
echo select disk !parentdisk! > "%TEMP%\list_all_bios.txt"
echo list partition >> "%TEMP%\list_all_bios.txt"
diskpart /s "%TEMP%\list_all_bios.txt" > "%TEMP%\all_parts_bios.txt"

for /f "tokens=2" %%p in ('findstr /r "Partition" "%TEMP%\all_parts_bios.txt"') do (
    if "%%p" neq "###" if "%%p" neq "Partition" (
        echo select disk !parentdisk! > "%TEMP%\chk_bios.txt"
        echo select partition %%p >> "%TEMP%\chk_bios.txt"
        echo detail partition >> "%TEMP%\chk_bios.txt"
        diskpart /s "%TEMP%\chk_bios.txt" > "%TEMP%\bios_det.txt"
        
        REM Check for FAT32
        findstr /i "FAT32" "%TEMP%\bios_det.txt" >nul
        if !errorlevel! equ 0 (
            REM Check for Active (language-independent: look for "Active" in any language or Type 0C/0B)
            findstr /r /c:"Type.*:.*0C" /c:"Type.*:.*0B" "%TEMP%\bios_det.txt" >nul
            if !errorlevel! equ 0 (
                set "bootpart=%%p"
                echo !MSG_BOOT_PART_BIOS_TYPE! %%p
                goto :mount_boot
            )
            
            REM Also check Active flag (works in most languages as it shows Yes/Evet/etc)
            findstr /r "Active.*:.*[YyEe]" "%TEMP%\bios_det.txt" >nul
            if !errorlevel! equ 0 (
                set "bootpart=%%p"
                echo !MSG_BOOT_PART_BIOS_ACTIVE! %%p
                goto :mount_boot
            )
        )
    )
)
goto :mount_boot

:mount_boot
if defined bootpart (
    echo !MSG_BOOT_PART_FOUND! !bootpart!
    
    REM 3. Assign Temp Letter S
    echo select disk !parentdisk! > "%TEMP%\mountboot.txt"
    echo select partition !bootpart! >> "%TEMP%\mountboot.txt"
    echo assign letter=S >> "%TEMP%\mountboot.txt"
    echo.
    echo !MSG_BCD_TEMP_DRIVE! ^(Disk !parentdisk! Partition !bootpart!^)
    diskpart /s "%TEMP%\mountboot.txt"
    
    REM 4. Repair BCD to S:
    echo.
    echo !MSG_BCD_COMMAND! bcdboot !targetdrive!:\Windows /s S: /f !FWT!
    echo !MSG_BCD_TARGET! ^(Disk !parentdisk! Partition !bootpart!^)
    echo.
    bcdboot !targetdrive!:\Windows /s S: /f !FWT!
    
    if !errorlevel! equ 0 (
        echo.
        echo !MSG_BCD_SUCCESS!
    ) else (
        echo.
        echo !MSG_BCD_ERROR! ^(Error: !errorlevel!^)
    )
    
    REM 5. Remove Temp Letter
    echo.
    echo !MSG_BCD_REMOVE!
    echo select disk !parentdisk! > "%TEMP%\unmountboot.txt"
    echo select partition !bootpart! >> "%TEMP%\unmountboot.txt"
    echo remove letter=S >> "%TEMP%\unmountboot.txt"
    diskpart /s "%TEMP%\unmountboot.txt"
) else (
    echo !MSG_BCD_FALLBACK!
    bcdboot !targetdrive!:\Windows /s !targetdrive!:\ /f !FWT!
)

:restore_success
echo !MSG_DONE!

:restore_finish
call :cleanup_temp_files
echo !MSG_PRESS_ANY_KEY!
pause >nul
exit /b

:restore_disk
echo.
echo !MSG_OFFLINE_WARN!

REM ======== FIRMWARE TYPE SELECTION FOR TARGET DISK ========
echo.
if "!ENV!"=="OFFLINE" (
    echo !MSG_ENV_OFFLINE! - Auto-detecting Firmware...
    echo !MSG_FIRMWARE! !FWT!
    
    REM Re-verify TEMPLATE just in case
    if "!FWT!"=="UEFI" (
        set "TEMPLATE=!SCRIPT_DIR!efi.txt"
        echo !MSG_FW_UEFI_SELECTED!
    ) else (
        set "TEMPLATE=!SCRIPT_DIR!bios.txt"
        echo !MSG_FW_BIOS_SELECTED!
    )
) else (
    echo !PROMPT_FIRMWARE!
    echo !FIRMWARE_UEFI!
    echo !FIRMWARE_BIOS!
    set /p fwchoice=!PROMPT_SELECT_FIRMWARE!
    
    if "!fwchoice!"=="1" (
        set "FWT=UEFI"
        set "TEMPLATE=!SCRIPT_DIR!efi.txt"
        echo !MSG_FW_UEFI_SELECTED!
    ) else (
        set "FWT=BIOS"
        set "TEMPLATE=!SCRIPT_DIR!bios.txt"
        echo !MSG_FW_BIOS_SELECTED!
    )
)
echo.

REM Early template file check
if not exist "!TEMPLATE!" (
    echo.
    echo ========================================
    echo !ERR_TEMPLATE_MISSING!
    echo !MSG_TEMPLATE_FILE! !TEMPLATE!
    echo ========================================
    echo.
    echo !MSG_PRESS_ANY_KEY!
    pause >nul
    exit /b
)

echo ========================================
echo !MSG_FW_TARGET! !FWT!
echo !MSG_TEMPLATE_FILE! !TEMPLATE!
echo ========================================
echo.

REM Now show disk list
echo ========================
echo list disk > "%TEMP%\disklist.txt"
diskpart /s "%TEMP%\disklist.txt"
echo ========================

:select_disk_loop
set /p diskselect=!PROMPT_SELECT_DISK!

REM Disk number validation (trim spaces)
set "diskselect=!diskselect: =!"
if "!diskselect!"=="" (
    echo !ERR_INVALID_NUMBER!
    goto select_disk_loop
)
echo !diskselect!| findstr /r "^[0-9][0-9]*$" >nul
if !errorlevel! neq 0 (
    echo !ERR_INVALID_NUMBER!
    goto select_disk_loop
)

REM Check if disk exists
echo select disk !diskselect! > "%TEMP%\check_disk.txt"
echo list disk >> "%TEMP%\check_disk.txt"
diskpart /s "%TEMP%\check_disk.txt" > "%TEMP%\disk_check.txt"

findstr "Disk !diskselect!" "%TEMP%\disk_check.txt" >nul
if !errorlevel! neq 0 (
    echo !ERR_DISK_NOT_FOUND!
    echo !MSG_PRESS_ANY_KEY!
    pause >nul
    goto select_disk_loop
)

REM ONLINE MODE: Check if selected disk contains C: drive
if "!ENV!"=="ONLINE" (
    REM Get C: volume details
    echo list volume > "%TEMP%\find_c.txt"
    diskpart /s "%TEMP%\find_c.txt" > "%TEMP%\volumes.txt"
    
    REM Find line with C drive and extract volume number
    findstr /c:" C " "%TEMP%\volumes.txt" > "%TEMP%\c_line.txt"
    
    REM Parse volume number from the line
    for /f "tokens=2" %%v in ('type "%TEMP%\c_line.txt"') do (
        set "c_volume=%%v"
    )
    
    if defined c_volume (
        REM Select C: volume and list disks to find parent disk
        echo select volume !c_volume! > "%TEMP%\get_c_disk.txt"
        echo list disk >> "%TEMP%\get_c_disk.txt"
        diskpart /s "%TEMP%\get_c_disk.txt" > "%TEMP%\c_disks.txt"
        
        REM Find disk with asterisk (currently selected = C:'s disk)
        findstr /c:"* Disk" "%TEMP%\c_disks.txt" > "%TEMP%\c_disk_line.txt"
        
        for /f "tokens=3" %%d in ('type "%TEMP%\c_disk_line.txt"') do (
            set "c_disk_num=%%d"
        )
        
        if defined c_disk_num (
            if "!diskselect!"=="!c_disk_num!" (
                echo.
                echo ==========================================
                echo !ERR_ONLINE_C_RESTRICT!
                echo !ERR_ONLINE_C_DISK!
                echo ==========================================
                echo.
                echo !MSG_PRESS_ANY_KEY!
                pause >nul
                goto select_disk_loop
            )
        )
    )
)

REM ==========================================================
REM PRESERVE TARGET DISK LETTER (If one exists)
REM ==========================================================
set "preserved_disk_letter="
echo select disk !diskselect! > "%TEMP%\disk_detail_chk.txt"
echo detail disk >> "%TEMP%\disk_detail_chk.txt"
diskpart /s "%TEMP%\disk_detail_chk.txt" > "%TEMP%\disk_det_res.txt"

REM Parse detail disk output to find any assigned letter
REM Output format typically:
REM "  Volume 5     E   New Volume..."
REM "  Volume 5         New Volume..." (No letter)
REM We iterate lines, look for "Volume", and check Token 3
for /f "usebackq tokens=1,2,3" %%a in ("%TEMP%\disk_det_res.txt") do (
    if /i "%%a"=="Volume" (
        REM Check candidate %%c
        echo %%c| findstr /r "^[A-Z]$" >nul
        if !errorlevel! equ 0 (
             if not defined preserved_disk_letter set "preserved_disk_letter=%%c"
        )
    )
)

if defined preserved_disk_letter (
    echo.
    echo EXISTING DISK LETTER DETECTED: !preserved_disk_letter!
)

REM Proceed directly to template processing

REM Template processing - COPY & READ (Safest Method)
if exist "%TEMP%\partition.txt" del "%TEMP%\partition.txt"
if exist "%TEMP%\tpl.tmp" del "%TEMP%\tpl.tmp"

REM Debug Info
echo Processing Template: !TEMPLATE!

if not exist "!TEMPLATE!" (
    echo.
    echo !ERR_TEMPLATE_MISSING!
    echo !MSG_TEMPLATE_FILE! !TEMPLATE!
    echo !MSG_PRESS_ANY_KEY!
    pause >nul
    exit /b
)

REM Copy to temp to avoid path/lock issues
copy /y "!TEMPLATE!" "%TEMP%\tpl.tmp" >nul 2>&1
if not exist "%TEMP%\tpl.tmp" (
    echo ERROR: Failed to copy template file to temp!
    echo Source: !TEMPLATE!
    pause
    exit /b
)

REM Initialize output
type nul > "%TEMP%\partition.txt"

REM Read local temp file directly (preserves delimiters)
for /f "usebackq delims=" %%a in ("%TEMP%\tpl.tmp") do (
    set "line=%%a"
    if defined line (
        REM Use FOR loop to inject diskselect into replacement strings (Nested !...! not supported)
        for %%D in (!diskselect!) do set "line=!line:#DISK#=%%D!"
        echo !line!>> "%TEMP%\partition.txt"
    )
)

REM Verify that content was actually written
set "fsize=0"
if exist "%TEMP%\partition.txt" (
    for %%A in ("%TEMP%\partition.txt") do set "fsize=%%~zA"
)

REM DEBUG: Show generated script content
echo.
echo ==========================================
echo [DEBUG] Generated Partition Script Content:
type "%TEMP%\partition.txt"
echo ==========================================
echo.

if !fsize! equ 0 (
    echo(
    echo ERROR: Partition script is empty or failed to create!
    echo Template: !TEMPLATE!
    echo(
    echo !MSG_PRESS_ANY_KEY!
    pause >nul
    exit /b
)

REM Verify template file was created
if not exist "%TEMP%\partition.txt" (
    echo(
    echo !ERR_TEMPLATE_MISSING!
    echo Failed to create partition script!
    echo !MSG_PRESS_ANY_KEY!
    pause >nul
    exit /b
)

echo !MSG_PARTITIONING!
diskpart /s "%TEMP%\partition.txt" > "%TEMP%\partition_result.txt"

REM Check for errors in diskpart output
findstr /i "error" "%TEMP%\partition_result.txt" >nul
if !errorlevel! equ 0 (
    echo(
    echo ERROR: Partitioning failed!
    type "%TEMP%\partition_result.txt"
    echo !MSG_PRESS_ANY_KEY!
    pause >nul
    call :cleanup_temp_files
    exit /b
)

REM Wait for diskpart to complete
timeout /t 2 /nobreak >nul

REM Hedef srcy bul (Label=Win_Install olan)
echo list volume > "%TEMP%\findvol.txt"
diskpart /s "%TEMP%\findvol.txt" > "%TEMP%\vollist.txt"

set "targetdrive="
REM Capture Volume ID for Win_Install to ensure we target the correct volume
REM Capture Volume ID for Win_Install to ensure we target the correct volume
set "win_vol_id="
set "targetdrive="
for /f "usebackq tokens=1,2,3,4,5" %%a in ("%TEMP%\vollist.txt") do (
    REM Standard: "  Volume 5  C   Win_Install" -> Token 2=VolID, Token 3=Letter, Token 4/5=Label
    
    REM Scenario 1: Letter exists (Token 3 is single char usually, check strictness later)
    REM If Token 4 is Win_Install (Volume 5 C Win_Install)
    if /i "%%d"=="Win_Install" (
        set "win_vol_id=%%b"
        set "targetdrive=%%c"
    )
    REM If Token 5 is Win_Install (Volume 5 C Label Win_Install - Rare)
    if /i "%%e"=="Win_Install" (
        set "win_vol_id=%%b"
        set "targetdrive=%%c"
    )
    
    REM Scenario 2: No Letter (Volume 5 Win_Install) -> Token 3 is label
    if /i "%%c"=="Win_Install" (
        set "win_vol_id=%%b"
        REM targetdrive remains empty
    )
    
    REM Selected Row (* Volume ...)
    if "%%a"=="*" (
        if /i "%%e"=="Win_Install" (
            set "win_vol_id=%%c"
            set "targetdrive=%%d"
        )
        if /i "%%f"=="Win_Install" (
            set "win_vol_id=%%c"
            set "targetdrive=%%d"
        )
        if /i "%%d"=="Win_Install" (
            set "win_vol_id=%%c"
        )
    )
)

if not defined win_vol_id (
    REM CRITICAL FALLBACK: If label parsing failed, assume Partition 2 (BIOS) or Partition 3 (UEFI)
    REM based on FWT. But explicit search is better.
    REM Let's try to find it via RAW label search on disk detail
    echo select disk !diskselect! > "%TEMP%\find_raw.txt"
    echo detail disk >> "%TEMP%\find_raw.txt"
    diskpart /s "%TEMP%\find_raw.txt" > "%TEMP%\raw_disk.txt"
    for /f "tokens=1,2,3,4" %%a in ('findstr /i "Win_Install" "%TEMP%\raw_disk.txt"') do (
        if "%%a"=="Volume" set "win_vol_id=%%b"
    )
)

REM RE-EVALUATE: If target has a letter (from ASSIGN) but it's NOT C, and C is free, SWITCH IT!
if defined targetdrive if "!ENV!"=="OFFLINE" if /i "!targetdrive!" neq "C" (
    echo [DEBUG] Checking if C: can be claimed...
    if not exist C:\ (
        echo WinPE Optimization: Switching !targetdrive!: to C: ...
        echo select volume !win_vol_id! > "%TEMP%\switch_c.txt"
        echo remove letter=!targetdrive! >> "%TEMP%\switch_c.txt"
        echo assign letter=C >> "%TEMP%\switch_c.txt"
        
        REM Unsilenced for debugging
        diskpart /s "%TEMP%\switch_c.txt"
        
        if exist C:\ (
            set "targetdrive=C"
            echo [SUCCESS] Switch complete.
        ) else (
            echo [ERROR] Switch failed ^(C: not found after assign^). Keeping !targetdrive!
        )
    ) else (
        echo [INFO] C: drive appears to be BUSY/TAKEN. Verification:
        vol C: 2>nul
        echo Keeping auto-assigned letter: !targetdrive!
    )
)

if not defined targetdrive (
    echo !MSG_VOL_NO_LETTER!
    
    REM 1. Find a guaranteed FREE letter
    set "free_letter="
    
    REM In OFFLINE mode, prioritize C if available
    if "!ENV!"=="OFFLINE" (
        if not exist C:\ set "free_letter=C"
    )
    
    REM If C is not free or we are Online, search Z -> D
    if not defined free_letter (
        for %%L in (Z Y X W V U T S R Q P O N M L K J I H G F E D) do (
            if not defined free_letter (
                if not exist %%L:\ set "free_letter=%%L"
            )
        )
    )
    
    if not defined free_letter (
        echo ERROR: No free drive letters available!
        goto :restore_finish
    )

    REM 2. Determine Final Letter (Preserved vs Free)
    set "final_letter="
    
    REM PRIORITY 1: In WinPE, if C is explicitly free, TAKE IT!
    if "!ENV!"=="OFFLINE" (
        if "!free_letter!"=="C" set "final_letter=C"
    )

    REM PRIORITY 2: Use Preserved Letter (if Safe and C wasn't already taken)
    if not defined final_letter (
        if defined preserved_disk_letter (
            if "!ENV!"=="ONLINE" (
                if /i "!preserved_disk_letter!" neq "C" set "final_letter=!preserved_disk_letter!"
            ) else (
                set "final_letter=!preserved_disk_letter!"
            )
        )
    )
    
    REM PRIORITY 3: Use the found free letter
    if not defined final_letter set "final_letter=!free_letter!"
    
    echo Assigning letter: !final_letter! to Volume !win_vol_id!
    
    echo select volume !win_vol_id! > "%TEMP%\assign_target.txt"
    echo assign letter=!final_letter! >> "%TEMP%\assign_target.txt"
    diskpart /s "%TEMP%\assign_target.txt" >nul
    set "targetdrive=!final_letter!"
)

echo !MSG_APPLYING! ^(Target: !targetdrive!:\^)
dism /Apply-Image /ImageFile:"!selected_wim!" /Index:!indexselect! /ApplyDir:!targetdrive!:\

if !errorlevel! equ 0 (
    echo !MSG_BOOT_FIX!
    
    REM Smart Boot Partition Detection for Disk Restore
    set "bootpart="
    
    REM Find boot partition on selected disk
    echo select disk !diskselect! > "%TEMP%\listpart_disk.txt"
    echo list partition >> "%TEMP%\listpart_disk.txt"
    diskpart /s "%TEMP%\listpart_disk.txt" > "%TEMP%\parts_disk.txt"
    echo(
    
    if "!FWT!"=="UEFI" (
        REM UEFI: Find System partition (should be Partition 1 in efi.txt)
        findstr /i "System Sistem" "%TEMP%\parts_disk.txt" > "%TEMP%\uefi_disk.txt"
        for /f "usebackq tokens=2" %%a in ("%TEMP%\uefi_disk.txt") do set "bootpart=%%a"
    ) else (
        REM BIOS: Find Active partition (should be Partition 1 in bios.txt)
        REM First check if there's an Active partition
        findstr /i "Active Etkin" "%TEMP%\parts_disk.txt" > "%TEMP%\active_check.txt"
        
        REM Look for the partition marked with asterisk (Active)
        for /f "usebackq tokens=2,3,4" %%a in ("%TEMP%\parts_disk.txt") do (
            if "%%a"=="*" set "bootpart=%%b"
        )
        
        REM If no asterisk found, check each Primary partition for Active status
        if not defined bootpart (
            findstr /i "Primary Birincil" "%TEMP%\parts_disk.txt" > "%TEMP%\prim_disk.txt"
            for /f "usebackq tokens=2" %%p in ("%TEMP%\prim_disk.txt") do (
                echo select disk !diskselect! > "%TEMP%\chkact_disk.txt"
                echo select partition %%p >> "%TEMP%\chkact_disk.txt"
                echo detail partition >> "%TEMP%\chkact_disk.txt"
                diskpart /s "%TEMP%\chkact_disk.txt" > "%TEMP%\detpart_disk.txt"
                
                findstr /i "Active.*Yes" "%TEMP%\detpart_disk.txt" >nul
                if !errorlevel! equ 0 set "bootpart=%%p"
                findstr /i "Etkin.*Evet" "%TEMP%\detpart_disk.txt" >nul
                if !errorlevel! equ 0 set "bootpart=%%p"
            )
        )
    )
    
    if defined bootpart (
        echo.
    echo !MSG_BOOT_PART_DETECTED! !bootpart! ^(Disk !diskselect!^)
        
        REM Assign temp letter S
        echo select disk !diskselect! > "%TEMP%\mount_disk.txt"
        echo select partition !bootpart! >> "%TEMP%\mount_disk.txt"
        echo assign letter=S >> "%TEMP%\mount_disk.txt"
        echo.
        echo !MSG_BCD_TEMP_DRIVE! ^(Disk !diskselect! Partition !bootpart!^)
        diskpart /s "%TEMP%\mount_disk.txt" >nul
        
        echo.
        echo !MSG_BCD_COMMAND! bcdboot !targetdrive!:\Windows /s S: /f !FWT!
        echo !MSG_BCD_TARGET! ^(Disk !diskselect! Partition !bootpart!^)
        echo !MSG_SOURCE_WIN! !targetdrive!:\Windows
        echo.
        
        REM Check if source Windows exists
        if not exist "!targetdrive!:\Windows\System32" (
            echo !MSG_SOURCE_WIN_ERROR!
            echo !MSG_SOURCE_WIN_MISSING!
        ) else (
            echo !MSG_SOURCE_WIN_VERIFIED! !targetdrive!:\Windows
            echo.
            
            REM Run BCDBoot
            bcdboot !targetdrive!:\Windows /s S: /f !FWT!
            
            REM Check result
            if !errorlevel! equ 0 (
                echo.
                echo !MSG_BCD_SUCCESS!
            ) else (
                echo.
                echo !MSG_BCD_ERROR! ^(Error: !errorlevel!^)
                echo.
                if "!FWT!"=="BIOS" (
                    echo ========================================
                    echo !MSG_BIOS_BOOT_FAIL_TITLE!
                    echo ========================================
                    echo.
                    echo !MSG_BIOS_BOOT_FAIL_REASONS!
                    echo   !MSG_BIOS_BOOT_FAIL_R1!
                    echo   !MSG_BIOS_BOOT_FAIL_R2!
                    echo.
                    echo !MSG_BIOS_BOOT_FAIL_SOLUTION!
                    echo   !MSG_BIOS_BOOT_FAIL_S1!
                    echo   !MSG_BIOS_BOOT_FAIL_S2!
                    echo   !MSG_BIOS_BOOT_FAIL_S3!
                    echo.
                    echo ========================================
                )
            )
        )
        
        echo.
        echo !MSG_BCD_REMOVE!
        echo select disk !diskselect! > "%TEMP%\unmount_disk.txt"
        echo select partition !bootpart! >> "%TEMP%\unmount_disk.txt"
        echo remove letter=S >> "%TEMP%\unmount_disk.txt"
        diskpart /s "%TEMP%\unmount_disk.txt"
    ) else (
        echo.
        echo !MSG_BOOT_FALLBACK_WARN!
        echo !MSG_BCD_COMMAND! bcdboot !targetdrive!:\Windows /f !FWT!
        echo.
        bcdboot !targetdrive!:\Windows /f !FWT!
    )
    
    echo !MSG_DONE!
) else (
    echo !MSG_FAIL!
)
echo !MSG_PRESS_ANY_KEY!
pause >nul
exit /b

REM ======== CLEANUP FUNCTION ========
:cleanup_temp_files
del "%TEMP%\wimlist.txt" 2>nul
del "%TEMP%\wimsearch.tmp" 2>nul
del "%TEMP%\esdsearch.tmp" 2>nul
del "%TEMP%\wimsearch_sources.tmp" 2>nul
del "%TEMP%\esdsearch_sources.tmp" 2>nul
del "%TEMP%\netcheck.tmp" 2>nul
del "%TEMP%\wiminfo.txt" 2>nul
del "%TEMP%\disklist.txt" 2>nul
del "%TEMP%\check_*.txt" 2>nul
del "%TEMP%\detail_*.txt" 2>nul
del "%TEMP%\listvol_*.txt" 2>nul
del "%TEMP%\vol_*.txt" 2>nul
del "%TEMP%\partition*.txt" 2>nul
del "%TEMP%\findvol.txt" 2>nul
del "%TEMP%\finddisk.txt" 2>nul
del "%TEMP%\listpart*.txt" 2>nul
del "%TEMP%\parts*.txt" 2>nul
del "%TEMP%\chk_*.txt" 2>nul
del "%TEMP%\efi_*.txt" 2>nul
del "%TEMP%\bios_*.txt" 2>nul
del "%TEMP%\mount*.txt" 2>nul
del "%TEMP%\unmount*.txt" 2>nul
del "%TEMP%\disk_*.txt" 2>nul
del "%TEMP%\gpt_*.txt" 2>nul
del "%TEMP%\format*.txt" 2>nul
del "%TEMP%\assign*.txt" 2>nul
del "%TEMP%\force_*.txt" 2>nul
del "%TEMP%\verify_*.txt" 2>nul
del "%TEMP%\final_*.txt" 2>nul
del "%TEMP%\winvol.tmp" 2>nul
del "%TEMP%\active_*.txt" 2>nul
del "%TEMP%\prim_*.txt" 2>nul
del "%TEMP%\detpart_*.txt" 2>nul
del "%TEMP%\uefi_*.txt" 2>nul
del "%TEMP%\all_*.txt" 2>nul
goto :eof