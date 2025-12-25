@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

REM ======== DİL AYARLARI / LANGUAGE SETTINGS ========
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
if "!LANG!"=="TR" goto skip_detect
powershell -NoProfile -Command "exit 0" >nul 2>&1
if !errorlevel! neq 0 goto skip_detect

powershell -NoProfile -Command "(Get-UICulture).Name" 2>nul | findstr /i "tr-TR" >nul
if !errorlevel! equ 0 set "LANG=TR"

:skip_detect

REM ======== SÖZLÜK / DICTIONARY ========
REM ======== SÖZLÜK / DICTIONARY ========
if "!LANG!"=="TR" goto :lang_tr

:lang_en
    set "MSG_TITLE=Windows Image Backup Tool (Online/Offline)"
    set "MSG_INTRO=This tool backs up your Windows installation to a WIM file."
    set "MSG_DESC_ONLINE=- ONLINE mode: Backs up while Windows is running (uses VSS)"
    set "MSG_DESC_OFFLINE=- OFFLINE mode: Backs up from WinPE or another OS"
    set "MSG_NOTE_NETWORK=NOTE: You can also use network shares as destination."
    set "ERR_ADMIN=ERROR: This script requires Administrator privileges!"
    set "MSG_ADMIN_HINT=Right-click and select 'Run as Administrator'."
    set "MSG_LISTING=Listing local drives..."
    set "MSG_HEADER_LOCAL=== LOCAL DRIVES ==="
    set "MSG_HEADER_NET=== NETWORK DRIVES ==="
    set "MSG_NO_NET=No connected network drives found."
    set "PROMPT_SOURCE_VOL=Enter the VOLUME NUMBER of the drive to backup (e.g. 1): "
    set "ERR_NO_SOURCE_VOL=ERROR: Source volume number not specified!"
    set "ERR_VOL_NOT_FOUND=ERROR: Volume not found!"
    set "MSG_VOL_NO_LETTER=Volume has no letter, assigning temporary..."
    set "WARN_S_IN_USE=WARNING: Drive S: is already in use, trying different letter..."
    set "WARN_LETTER_FAIL=WARNING: Could not assign letter to Volume."
    set "MSG_TRY_ALT=Trying alternative method..."
    set "MSG_SOURCE_SELECTED=Selected source: Volume "
    set "MSG_SOURCE_SELECTED_TEMP= [Temporary]"
    set "MSG_DEST_OPTS=Destination options:"
    set "MSG_DEST_OPT1=1. Local volume (select from list above)"
    set "MSG_DEST_OPT2=2. Network share (e.g. \\server\share)"
    set "PROMPT_CHOICE=Your choice (1 or 2): "
    set "PROMPT_DEST_VOL=Enter the NUMBER of the target disk drive where the image will be saved. (e.g. 3): "
    set "MSG_DEST_SELECTED=Selected destination: Volume "
    set "PROMPT_NET_PATH=Enter Network Path (UNC) (e.g. \\192.168.1.5\Backup): "
    set "PROMPT_NET_USER=Username (Domain\User or User): "
    set "PROMPT_NET_PASS=Password: "
    set "MSG_NET_TRIAL=Connecting to network path..."
    set "MSG_NET_SUCCESS=Network connection successful."
    set "ERR_NET_FAIL=ERROR: Could not access or connect to network path!"
    set "PROMPT_WIM_NAME=Enter WIM file name (leave empty for auto): "
    set "MSG_FILENAME=File name: "
    set "MSG_IMG_NAME=Image name: "
    set "MSG_AUTO_DETECT=Detected Environment:"
    set "MSG_SUMMARY_HEADER=== BACKUP SUMMARY ==="
    set "MSG_SRC=Source        :"
    set "MSG_DEST=Destination   :"
    set "MSG_FILE=File Name     :"
    set "MSG_IMG=Image Name    :"
    set "MSG_MOD=Mode          :"
    set "PROMPT_CONFIRM=Should the backup process be started? (Y/N): "
    set "MSG_PROGRESS=Progress: DISM is running... This may take 30m - 2h."
    set "MSG_SECURE_WARN=WARNING: Log files may contain network credentials."
    set "MSG_EXCLUSION=Creating exclusion list..."
    set "MSG_STARTING=Starting backup..."
    set "MSG_WAIT=This may take a long time depending on PC speed. Please wait..."
    set "MSG_VSS_CREATE=Creating ONLINE VSS snapshot..."
    set "WARN_VSS_FAIL=WARNING: Could not create VSS Snapshot."
    set "MSG_VSS_REASON=Reason might be FAT32 filesystem (EFI Partition). FAT32 does not support VSS."
    set "MSG_TRY_DIRECT=Trying Direct Backup [No-VSS]..."
    set "MSG_VSS_MOUNT=VSS Snapshot mounted:"
    set "MSG_VSS_VERIFY=VSS Content Verified."
    set "MSG_FALLBACK=Fallback: Starting Direct Backup..."
    set "MSG_EFI_DETECT=EFI Partition detected. Possible BCD lock issue on Servers [0x80070020]."
    set "MSG_STAGING=Creating Staging Copy for safe backup..."
    set "MSG_COPYING=Copying files..."
    set "MSG_BCD_EXPORT=Exporting BCD..."
    set "MSG_BCD_OK=BCD exported successfully."
    set "WARN_BCD_FAIL=WARNING: Could not export BCD, existing file might be unusable."
    set "MSG_STAGING_CHECK=Staging Folder Content Check:"
    set "MSG_STAGING_CLEAN=Cleaning up Staging folder..."
    set "MSG_OFFLINE_BACKUP=Performing OFFLINE standard backup..."
    set "MSG_RESULT_HEADER=== BACKUP RESULTS ==="
    set "MSG_STATUS=STATUS	:"
    set "MSG_SUCCESS=SUCCESS"
    set "MSG_FAIL=FAILED"
    set "MSG_ERR_CODE=Error Code     :"
    set "MSG_LOG_FILE=DISM log file :"
    set "MSG_START=Start		:"
    set "MSG_END=End		:"
    set "MSG_DONE=Backup completed successfully."
    set "MSG_ERR_DONE=Error occurred during backup. Please check error messages above."
    set "MSG_CLEAN=Cleaning up..."
    set "MSG_TEMP_REMOVE=Removing source temp letter:"
    set "MSG_CLEAN_DONE=Cleanup finished."
    set "MSG_CLEAN_EXIT=Press any key to EXIT."
    set "MSG_EXCLUSION_PREP=Preparing exclusion list for:"
    set "MSG_NOTE_MOUNT_SKIP=NOTE: Skipping user profile exclusions because Mount Point is used."
    set "ERR_VSS_MOUNT=ERROR: Could not create VSSSnapshot folder!"
    set "MSG_CANCELLED=Operation cancelled."
    goto :lang_done

:lang_tr
    set "MSG_TITLE=Windows İmaj Yedekleme Aracı (Çevrimiçi/Çevrimdışı)"
    set "MSG_INTRO=Bu araç Windows kurulumunuzu WIM dosyasına yedekler."
    set "MSG_DESC_ONLINE=- ÇEVRİMİÇİ mod: Windows çalışırken yedek alır (VSS kullanır)"
    set "MSG_DESC_OFFLINE=- ÇEVRİMDIŞI mod: WinPE veya başka işletim sisteminden yedek alır"
    set "MSG_NOTE_NETWORK=NOT: Ağ paylaşımlarını da hedef olarak kullanabilirsiniz."
    set "ERR_ADMIN=HATA: Bu betik yönetici yetkisi gerektirir!"
    set "MSG_ADMIN_HINT=Sağ tıklayıp 'Yönetici olarak çalıştır' seçeneğini kullanın."
    set "MSG_LISTING=Yerel sürücüler listeleniyor..."
    set "MSG_HEADER_LOCAL=== YEREL SÜRÜCÜLER ==="
    set "MSG_HEADER_NET=== AĞ SÜRÜCÜLERİ (Bağlı ağ paylaşımları) ==="
    set "MSG_NO_NET=Bağlı ağ sürücüsü bulunamadı."
    set "PROMPT_SOURCE_VOL=Yedeklenecek sürücünün VOLUME NUMARASINI girin (örn: 1): "
    set "ERR_NO_SOURCE_VOL=HATA: Kaynak volume numarası belirtilmedi!"
    set "ERR_VOL_NOT_FOUND=HATA: Volume bulunamadı!"
    set "MSG_VOL_NO_LETTER=Volume harfi yok, geçici harf atanıyor..."
    set "WARN_S_IN_USE=UYARI: S: sürücüsü zaten kullanımda, farklı harf deneniyor..."
    set "WARN_LETTER_FAIL=UYARI: Volume harfi atanamadı."
    set "MSG_TRY_ALT=Alternatif yöntem deneniyor..."
    set "MSG_SOURCE_SELECTED=Seçilen kaynak: Volume "
    set "MSG_SOURCE_SELECTED_TEMP= [Geçici]"
    set "MSG_DEST_OPTS=Hedef seçenekleri:"
    set "MSG_DEST_OPT1=1. Yerel volume (yukarıdaki listeden volume numarası seçin)"
    set "MSG_DEST_OPT2=2. Ağ paylaşımı (örn: \\sunucu\paylasim)"
    set "PROMPT_CHOICE=Seçiminiz (1 veya 2): "
    set "PROMPT_DEST_VOL=Imajın kaydedileceği Hedef volume NUMARASINI girin (örn: 3): "
    set "MSG_DEST_SELECTED=Seçilen hedef: Volume "
    set "PROMPT_NET_PATH=Ağ yolu (UNC) girin (örn: \\192.168.1.5\Yedek): "
    set "PROMPT_NET_USER=Kullanıcı adı (Domain\User veya User): "
    set "PROMPT_NET_PASS=Parola: "
    set "MSG_NET_TRIAL=Ağ yoluna bağlanılıyor..."
    set "MSG_NET_SUCCESS=Ağ bağlantısı başarılı."
    set "ERR_NET_FAIL=HATA: Ağ yoluna erişilemedi veya bağlanılamadı!"
    set "PROMPT_WIM_NAME=WIM dosya adını girin (boş bırakırsanız otomatik ad): "
    set "MSG_FILENAME=Dosya adı	: "
    set "MSG_IMG_NAME=İmaj adı: "
    set "MSG_AUTO_DETECT=Algılanan Ortam:"
    set "MSG_SUMMARY_HEADER=== YEDEKLEME ÖZETİ ==="
    set "MSG_SRC=Kaynak        :"
    set "MSG_DEST=Hedef         :"
    set "MSG_FILE=Dosya Adı	:"
    set "MSG_IMG=İmaj Adı      :"
    set "MSG_MOD=Mod		:"
    set "PROMPT_CONFIRM=Yedekleme işlemi başlatılsın mı? (E/H): "
    set "MSG_PROGRESS=İlerleme: DISM komutu çalışıyor... Bu işlem 30 dk - 2 saat sürebilir."
    set "MSG_SECURE_WARN=UYARI: Log dosyalarında ağ kimlik bilgileri görünebilir."
    set "MSG_EXCLUSION=Dosya/klasör hariç tutma listesi oluşturuluyor..."
    set "MSG_STARTING=Yedekleme başlatılıyor..."
    set "MSG_WAIT=Bu işlem bilgisayarın hızına bağlı olarak uzun sürebilir. Lütfen bekleyin..."
    set "MSG_VSS_CREATE=ÇEVRİMİÇİ VSS snapshot oluşturuluyor..."
    set "WARN_VSS_FAIL=UYARI: VSS Snapshot oluşturulamadı."
    set "MSG_VSS_REASON=Sebebi FAT32 dosya sistemi -EFI Bölümü- olabilir. FAT32 VSS desteklemez."
    set "MSG_TRY_DIRECT=Doğrudan Yedekleme [VSS'siz] deneniyor..."
    set "MSG_VSS_MOUNT=VSS Snapshot bağlandı:"
    set "MSG_VSS_VERIFY=VSS İçeriği Doğrulandı."
    set "MSG_FALLBACK=Fallback: Doğrudan yedekleme başlatılıyor..."
    set "MSG_EFI_DETECT=EFI Bölümü algılandı. Sunucularda BCD kilit sorunu [0x80070020] olabilir."
    set "MSG_STAGING=Güvenli yedekleme için Staging kopyası oluşturuluyor..."
    set "MSG_COPYING=Dosyalar kopyalanıyor..."
    set "MSG_BCD_EXPORT=BCD Export alınıyor..."
    set "MSG_BCD_OK=BCD başarıyla export edildi."
    set "WARN_BCD_FAIL=UYARI: BCD export edilemedi, mevcut dosya kullanılamayabilir."
    set "MSG_STAGING_CHECK=Staging Klasör İçeriği Kontrolü:"
    set "MSG_STAGING_CLEAN=Staging klasörü temizleniyor..."
    set "MSG_OFFLINE_BACKUP=ÇEVRİMDIŞI standart yedekleme yapılıyor..."
    set "MSG_RESULT_HEADER=== YEDEKLEME SONUÇLARI ==="
    set "MSG_STATUS=DURUM        	:"
    set "MSG_SUCCESS=BAŞARILI"
    set "MSG_FAIL=BAŞARISIZ"
    set "MSG_ERR_CODE=Hata Kodu      :"
    set "MSG_LOG_FILE=DISM log dosyası:"
    set "MSG_START=Başlangıç    	:"
    set "MSG_END=Bitiş        	:"
    set "MSG_DONE=Yedekleme başarıyla tamamlandı"
    set "MSG_ERR_DONE=Yedekleme sırasında hata oluştu. Lütfen yukarıdaki hata mesajlarını kontrol edin."
    set "MSG_CLEAN=Temizlik yapılıyor..."
    set "MSG_TEMP_REMOVE=Kaynak geçici harf kaldırılıyor:"
    set "MSG_CLEAN_DONE=Temizlik tamamlandı."
    set "MSG_CLEAN_EXIT=Çıkış için hehangi bir tuşa basın."
    set "MSG_EXCLUSION_PREP=Hariç tutma listesi hazırlanıyor:"
    set "MSG_NOTE_MOUNT_SKIP=NOT: Mount Point kullanıldığı için kullanıcı profil hariç tutmaları atlanıyor."
    set "ERR_VSS_MOUNT=HATA: VSSSnapshot klasörü oluşturulamadı!"
    set "MSG_CANCELLED=İşlem iptal edildi."
    goto :lang_done

:lang_done
cls
echo ========================================================
echo !MSG_TITLE!
echo ========================================================
echo.
echo !MSG_INTRO!
echo !MSG_DESC_ONLINE!
echo !MSG_DESC_OFFLINE!
echo.
echo !MSG_NOTE_NETWORK!
echo ========================================================
echo.

REM Yönetici kontrolü
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo !ERR_ADMIN!
    echo !MSG_ADMIN_HINT!
    pause
    exit /b 1
)

REM Geçici dosya yolları
set scriptpath=%TEMP%\diskpart_%RANDOM%.txt
set selectsource=%TEMP%\select_source_%RANDOM%.txt
set selectdest=%TEMP%\select_dest_%RANDOM%.txt
set configlistpath=%TEMP%\configlist_%RANDOM%.ini
set netdrivelist=%TEMP%\netdrives_%RANDOM%.txt

REM ======== SÜRÜCÜ LİSTELEME ========
echo !MSG_LISTING!
echo.
echo !MSG_HEADER_LOCAL!
echo lis vol > "%scriptpath%"
echo exi >> "%scriptpath%"
diskpart /s "%scriptpath%"

echo.
echo !MSG_HEADER_NET!
net use | findstr /R /C:"^[A-Z]:" /C:":" > "%netdrivelist%" 2>nul
if exist "%netdrivelist%" (
    type "%netdrivelist%"
) else (
    echo !MSG_NO_NET!
)
echo.

REM ======== KAYNAK SÜRÜCÜ SEÇİMİ ========
:select_source
echo.
echo ========================================================
set /p sourcevol=!PROMPT_SOURCE_VOL! 
if not defined sourcevol (
    echo !ERR_NO_SOURCE_VOL!
    goto select_source
)

REM Volume bilgisini al
echo lis vol > "%scriptpath%"
echo exi >> "%scriptpath%"
diskpart /s "%scriptpath%" > "%TEMP%\vollist.txt" 2>&1

REM İlgili volume satırını bul
findstr /C:"Volume %sourcevol% " "%TEMP%\vollist.txt" > "%TEMP%\thisvol.txt"

REM Dosya var mı kontrol et
if not exist "%TEMP%\thisvol.txt" (
    echo !ERR_VOL_NOT_FOUND!
    goto select_source
)

REM Dosya boş mu kontrol et
for %%A in ("%TEMP%\thisvol.txt") do set filesize=%%~zA
if %filesize% equ 0 (
    echo !ERR_VOL_NOT_FOUND!
    goto select_source
)

REM Satırdan harf bilgisini çıkar (3. kolon) - usebackq ile dosyadan oku
set sourceletter=
for /f "usebackq tokens=3" %%a in ("%TEMP%\thisvol.txt") do (
    if not defined sourceletter set sourceletter=%%a
)

REM Harf kontrolü - tek karakter ve A-Z arasında mı?
set has_letter=false
if defined sourceletter (
    REM Uzunluk kontrolü - 1 karakter mi?
    set tempcheck=!sourceletter:~1,1!
    if "!tempcheck!"=="" (
        REM A-Z arasında mı kontrol et
        echo ABCDEFGHIJKLMNOPQRSTUVWXYZ | find "!sourceletter!" >nul
        if !errorlevel! equ 0 (
            set has_letter=true
            set sourcedrive=!sourceletter!
        )
    )
)

if "!has_letter!"=="true" (
    REM Zaten harfi var
    set source_needs_cleanup=false
    set "sourcepath_mode=LETTER"
    echo !MSG_SOURCE_SELECTED!%sourcevol% - !sourcedrive!:\
    
    REM Erişilebilir mi kontrol et
    if not exist !sourcedrive!:\ (
        echo !ERR_VOL_NOT_FOUND!
        goto select_source
    )
) else (
    REM Harf yok, geçici ata
    echo !MSG_VOL_NO_LETTER!
    
    REM Önce S: harfinin kullanılabilir olduğunu kontrol et
    if exist S:\ (
        echo !WARN_S_IN_USE!
        set tempdrive=R
    ) else (
        set tempdrive=S
    )
    
    echo sel vol %sourcevol% > "%selectsource%"
    echo assign letter=!tempdrive! >> "%selectsource%"
    echo exi >> "%selectsource%"
    
    diskpart /s "%selectsource%" >nul 2>&1
    
    timeout /t 2 /nobreak >nul
    
    if not exist !tempdrive!:\ (
        set assignresult=1
    ) else (
        set assignresult=0
    )
    
    if !assignresult! neq 0 (
        echo.
        echo !WARN_LETTER_FAIL!
        echo !MSG_TRY_ALT!
        set sourcedrive=!tempdrive!
        mountvol !sourcedrive!: /L > "%TEMP%\volid.txt" 2>nul
        for /f "usebackq tokens=*" %%i in ("%TEMP%\volid.txt") do set volid=%%i
        mountvol !sourcedrive!: !volid! >nul 2>&1
        timeout /t 2 /nobreak >nul
    )
    
    if not exist !tempdrive!:\ (
        echo !WARN_LETTER_FAIL!
        echo Volume GUID - Benzersiz Kimlik - kullanılarak devam edilecek...
        
        REM Volume GUID bul
        echo sel vol %sourcevol% > "%TEMP%\getguid_part.txt"
        echo detail vol >> "%TEMP%\getguid_part.txt"
        
        set "vol_guid="
        REM PowerShell ile DiskId veya GUID çekmeye gerek yok, Diskpart detail vol çıktısında Ltr yoksa Path zor bulunur.
        REM Alternatif: WMI ile Volume ID bul
        
        powershell -Command "$vol = Get-WmiObject -Class Win32_Volume | Where-Object { $_.DriveLetter -eq $null -and $_.Label -ne 'System Reserved' }; foreach($v in $vol) { if($v.DeviceID -match 'Volume') { Write-Host $v.DeviceID } }" > "%TEMP%\vols.txt"
        
        REM Hedef volume'u bulmak zor, bu yüzden basitçe bu adımda hata vermeyip
        REM Doğrudan VSS oluşturma adımında "sourcedrive" yerine "VolumePath" kullanacağız.
        
        REM Diskpart ile volume yolunu bulmaya çalışalım (Letter yoksa zordur).
        REM Kullanıcıya sorulan Volume No'dan yola çıkarak GUID bulmak için:
        
        set "ps_getguid=%TEMP%\getguid_%RANDOM%.ps1"
        (
            echo $volIndex = %sourcevol%
            echo $disks = Get-Disk ^| Get-Partition ^| Where-Object { $_.PartitionNumber -gt 0 }
            REM Bu yöntem karışık. Basitçe DiskPart UniqueID kullanalım? Hayır Volume ID lazım.
            
            REM En garantisi:
            REM Harf atamayı geç, Online modda zaten VSS kullanacağız.
            REM VSS'e 'C:' değil, Volume GUID gönderelim.
        ) > "!ps_getguid!"
        
        echo Kaynak modu: GUID [Harfsiz]
        
        REM Harf atanamadıysa, klasöre bağlamayı dene (Mount Point)
        set "mount_point=%TEMP%\mount_vol_%sourcevol%"
        if exist "!mount_point!" rmdir /s /q "!mount_point!"
        mkdir "!mount_point!"
        
        echo sel vol %sourcevol% > "%selectsource%"
        echo assign mount="!mount_point!" >> "%selectsource%"
        echo exi >> "%selectsource%"
        
        diskpart /s "%selectsource%" >nul 2>&1
        
        REM Kontrol et: Klasör artık bir mount point mi? Ya da içinde dosya var mı?
        REM Ancak EFI içi boş olabilir veya erişim kısıtlı olabilir.
        REM Mount başarılı ise devam edelim.
        
        set sourcedrive=!mount_point!
        set "sourcepath_mode=MOUNTPOINT"
        echo Alternatif Bağlantı: !sourcedrive!
    ) else (
        set sourcedrive=!tempdrive!
        set source_needs_cleanup=true
        set "sourcepath_mode=LETTER"
        echo !MSG_SOURCE_SELECTED!%sourcevol% - !sourcedrive!:\ !MSG_SOURCE_SELECTED_TEMP!
    )
)
if "!sourcepath_mode!"=="LETTER" (
    set "fullsourcepath=!sourcedrive!:"
) else (
    set "fullsourcepath=!sourcedrive!"
)

REM ======== HEDEF SEÇİMİ ========
:select_dest
echo.
echo ========================================================
echo !MSG_DEST_OPTS!
echo !MSG_DEST_OPT1!
echo !MSG_DEST_OPT2!
echo.
set /p destchoice=!PROMPT_CHOICE! 

if "!destchoice!"=="1" goto dest_local
if "!destchoice!"=="2" goto dest_network
echo !PROMPT_CHOICE!
goto select_dest

:dest_local
set /p destvol=!PROMPT_DEST_VOL! 
if not defined destvol (
    echo !ERR_NO_SOURCE_VOL!
    goto select_dest
)

echo lis vol > "%scriptpath%"
echo exi >> "%scriptpath%"
diskpart /s "%scriptpath%" > "%TEMP%\vollist2.txt" 2>&1

findstr /C:"Volume %destvol% " "%TEMP%\vollist2.txt" > "%TEMP%\thisvol2.txt"

REM Dosya var ve boş değil mi kontrol et
if not exist "%TEMP%\thisvol2.txt" (
    echo !ERR_VOL_NOT_FOUND!
    goto select_dest
)

for %%A in ("%TEMP%\thisvol2.txt") do set filesize2=%%~zA
if %filesize2% equ 0 (
    echo !ERR_VOL_NOT_FOUND!
    goto select_dest
)

REM Harf bilgisini çıkar (3. kolon)
set destletter=
for /f "usebackq tokens=3" %%a in ("%TEMP%\thisvol2.txt") do (
    if not defined destletter set destletter=%%a
)

REM Harf kontrolü - A-Z arasında mı?
set dest_has_letter=false
if defined destletter (
    set tempcheck2=!destletter:~1,1!
    if "!tempcheck2!"=="" (
        echo ABCDEFGHIJKLMNOPQRSTUVWXYZ | find "!destletter!" >nul
        if !errorlevel! equ 0 set dest_has_letter=true
    )
)

if "!dest_has_letter!"=="true" (
    set destdrive=!destletter!
    set destpath=!destletter!:
    set dest_needs_cleanup=false
    echo !MSG_DEST_SELECTED!%destvol% - !destletter!:\
    if not exist !destletter!:\ (
        echo !ERR_NET_FAIL!
        goto select_dest
    )
) else (
    echo !MSG_VOL_NO_LETTER!
    echo sel vol %destvol% > "%selectdest%"
    echo assign letter=T >> "%selectdest%"
    echo exi >> "%selectdest%"
    diskpart /s "%selectdest%" >nul 2>&1
    timeout /t 2 /nobreak >nul
    if not exist T:\ (
        echo !WARN_LETTER_FAIL!
        goto select_dest
    )
    set destdrive=T
    set destpath=T:
    set dest_needs_cleanup=true
    echo !MSG_DEST_SELECTED!%destvol% - T:\
)
goto dest_continue

:dest_network
set /p destpath=!PROMPT_NET_PATH! 

if not defined destpath (
    echo !ERR_NET_FAIL!
    goto select_dest
)

echo !MSG_NET_TRIAL!
dir "!destpath!" >nul 2>&1
if !errorlevel! equ 0 (
    echo !MSG_NET_SUCCESS!
    echo !MSG_DEST_SELECTED! !destpath!
    set dest_needs_cleanup=false
    goto dest_continue
)

echo !ERR_NET_FAIL!
echo !PROMPT_CONFIRM!
set /p continue=
set "net_continue=false"
if /i "!continue!"=="E" set "net_continue=true"
if /i "!continue!"=="Y" set "net_continue=true"
if "!net_continue!"=="false" goto select_dest

set /p netuser=!PROMPT_NET_USER!
echo !PROMPT_NET_PASS!

where powershell >nul 2>&1
if !errorlevel! equ 0 (
    powershell -Command "$pass = Read-Host -AsSecureString; [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass))" > "%TEMP%\pass.tmp"
    set /p netpass=<"%TEMP%\pass.tmp"
    del "%TEMP%\pass.tmp"
) else (
    set /p netpass=
)

net use "!destpath!" "!netpass!" /USER:"!netuser!" >nul 2>&1
if !errorlevel! equ 0 (
    echo !MSG_NET_SUCCESS!
) else (
    echo !ERR_NET_FAIL!
    goto select_dest
)
goto dest_continue

:dest_continue

REM ======== DOSYA ADI ========
echo.
echo ========================================================
set /p destfile=!PROMPT_WIM_NAME! 
if not defined destfile (
    set destfile=Windows_Yedek_!date:~-4!!date:~-7,2!!date:~-10,2!_!time:~0,2!!time:~3,2!.wim
    set destfile=!destfile: =0!
)
REM .wim uzantısını kontrol et
if /i not "!destfile:~-4!"==".wim" set destfile=!destfile!.wim

echo !MSG_FILENAME! !destfile!

REM ======== İMAJ ADI ========
echo.
set imagename=Windows Yedek !date! !time!
echo !MSG_IMG_NAME! !imagename!

REM ======== ONLINE/OFFLINE AUTO DETECT ========
echo.
echo ========================================================
reg query "HKLM\SYSTEM\CurrentControlSet\Control\MiniNT" >nul 2>&1
if !errorlevel! equ 0 (
    set capturemode=OFFLINE
    echo !MSG_AUTO_DETECT! [OFFLINE - WinPE]
) else (
    set capturemode=ONLINE
    echo !MSG_AUTO_DETECT! [ONLINE - Windows]
)

REM ======== ÖZET BİLGİLER ========
echo.
echo ========================================================
echo   !MSG_SUMMARY_HEADER!
echo ========================================================
echo   !MSG_SRC! Volume %sourcevol% ^(!sourcedrive!:\^)
if defined destvol (
    echo   !MSG_DEST! Volume %destvol% ^(!destpath!\^)
) else (
    echo   !MSG_DEST! !destpath!
)
echo   !MSG_FILE! !destfile!
echo   !MSG_IMG! !imagename!
echo   !MSG_MOD! !capturemode!
echo ========================================================
echo.
set /p confirm=!PROMPT_CONFIRM! 
set "confirmed=false"
if /i "!confirm!"=="E" set "confirmed=true"
if /i "!confirm!"=="Y" set "confirmed=true"

if "!confirmed!"=="false" (
    echo !MSG_CANCELLED!
    goto cleanup
)

REM ======== CONFIG LIST OLUŞTUR ========
echo.
echo !MSG_EXCLUSION!
REM Mod MOUNTPOINT ise Config listesi oluştururken dikkat et (User exclude çalışmayabilir)
if "!sourcepath_mode!"=="MOUNTPOINT" (
    echo !MSG_NOTE_MOUNT_SKIP!
    echo. > "%configlistpath%"
    echo [ExclusionList] >> "%configlistpath%"
    echo \$ntfs.log >> "%configlistpath%"
    echo \pagefile.sys >> "%configlistpath%"
    echo \swapfile.sys >> "%configlistpath%"
    echo \System Volume Information >> "%configlistpath%"
    echo \RECYCLER >> "%configlistpath%"
    echo \$Recycle.Bin >> "%configlistpath%"
) else (
    call :create_config_list !sourcedrive!
)

REM ======== DISM KOMUTU ========
echo.
echo ========================================================
echo !MSG_STARTING!
echo !MSG_PROGRESS!
if "!LANG!"=="TR" (
    echo !MSG_SECURE_WARN!
) else (
    echo !MSG_SECURE_WARN!
)
echo ========================================================
echo.

set dismstart=!date! !time!

REM Hedef dosya var mı kontrol et ve EYLEM belirle (Capture vs Append)
set "dismaction=/Capture-Image"
if exist "!destpath!\!destfile!" (
    echo Hedef dosya MEVCUT. İşlem "Append-Image" olarak değiştiriliyor.
    set "dismaction=/Append-Image"
)

set dismresult=0

REM DISM Log ve Scratch ayarlarını global olarak yap (Her modda erişilebilir olsun)
set "DismLog=!destpath!\dism.log"
if exist "!DismLog!" del /q "!DismLog!"
set "DismScratch=!destpath!\Temp"
if not exist "!DismScratch!" mkdir "!DismScratch!"

if "!capturemode!"=="ONLINE" (
    REM ONLINE mod - VSS snapshot kullanarak
    echo !MSG_VSS_CREATE!
    
    set "ps_vss=%TEMP%\vss_create_!RANDOM!.ps1"
    (
        echo $drive = '!fullsourcepath!^\'
        echo $s = ^(Get-WmiObject -List Win32_ShadowCopy^).Create^($drive, 'ClientAccessible'^)
        echo if ^($s.ReturnValue -eq 0^) {
        echo     $shadow = Get-WmiObject Win32_ShadowCopy ^| Where-Object { $_.ID -eq $s.ShadowID }
        echo     Write-Output $shadow.DeviceObject
        echo } else { exit 1 }
    ) > "!ps_vss!"

    set "shadowPath="
    for /f "usebackq tokens=*" %%i in (`powershell -ExecutionPolicy Bypass -NoProfile -File "!ps_vss!"`) do set "shadowPath=%%i"
    if exist "!ps_vss!" del /q "!ps_vss!"

    if "!shadowPath!"=="" (
        echo !WARN_VSS_FAIL!
        echo !MSG_VSS_REASON!
        echo.
        echo !MSG_TRY_DIRECT!
        echo.
        
        REM Doğrudan kaynak yolunu kullan
        set "captureSource=!fullsourcepath!"
        
        REM Eğer GUID/Letter modundaysa ve sonunda \ yoksa ekleyelim mi? 
        REM DISM CaptureDir için sonuna \ istiyor mu? Evet genellikle.
        REM fullsourcepath zaten S: veya C:\Temp\Mount şeklindeydi.
        REM Letter S: ise, S:\ yapmalıyız.Mount ise Mount\ yapmalıyız.
        
        if "!sourcepath_mode!"=="LETTER" (
             set "captureSource=!fullsourcepath!\"
        ) else (
             REM MOUNTPOINT ise
             set "captureSource=!fullsourcepath!"
        )
        
        set dismresult=0
    ) else (
        set "mountDir=%TEMP%\vss_mount_!RANDOM!"
        REM mklink oluşturulacak klasörün önceden var OLMAMASI gerekir
        if exist "!mountDir!" rmdir /s /q "!mountDir!"
        
        REM mklink ile bağla (sonuna \ ekleyerek kaynağı belirt)
        mklink /d "!mountDir!" "!shadowPath!\" >nul
        echo !MSG_VSS_MOUNT! !mountDir!

        REM Bağlantının çalıştığını kontrol et
        if not exist "!mountDir!" (
            echo !ERR_VSS_MOUNT!
            REM Burada fallback yapmayalım, VSS var ama bağlanamadı ise ciddi sorundur.
            set dismresult=998
        ) else (
            REM Windows klasörü kontrolünü sadece C: sürücüsü için yapmak gerekir. 
            REM EFI için Windows klasörü olmaz.
            REM Sadece boş mu diye bakalım? dir çıktısı ile.
            
            echo !MSG_VSS_VERIFY!
            dir "!mountDir!" | find "File(s)"
            echo.
            
            set "captureSource=!mountDir!"
        )
    )
    )

    REM Unified DISM Execution Block for ONLINE Mode
    if defined captureSource (
        
        REM EFI Staging Logic (Specific for Server BCD Lock)
        set "StagingDir=%TEMP%\EFI_Staging_!RANDOM!"
        set "use_staging=false"
        
        if exist "!captureSource!\EFI" (
            echo !MSG_EFI_DETECT!
            echo !MSG_STAGING!
            set "use_staging=true"
            
            if exist "!StagingDir!" rmdir /s /q "!StagingDir!"
            mkdir "!StagingDir!"
            
            echo !MSG_COPYING!
            robocopy "!captureSource!." "!StagingDir!" /E /ZB /R:0 /W:0 /COPY:DAT /XF BCD BCD.LOG /MT:8 /NFL /NDL /NJH /NJS >nul 2>&1
            
            echo !MSG_BCD_EXPORT!
            if exist "!StagingDir!\EFI\Microsoft\Boot" (
                bcdedit /export "!StagingDir!\EFI\Microsoft\Boot\BCD" >nul
                if !errorlevel! equ 0 (
                    echo !MSG_BCD_OK!
                ) else (
                    echo !WARN_BCD_FAIL!
                )
            )
            
            set "realSource=!captureSource!"
            set "captureSource=!StagingDir!"
        )
        
        REM ConfigFile bazen kod sayfası (UTF8) yüzünden bozuk olabiliyor. 
        REM EFI/FAT32 için ConfigFile kullanmadan deneyelim (daha güvenli).
        
        REM ConfigFile kullanmadan (daha güvenli)
        
        if "!dismaction!"=="/Capture-Image" (
            dism /Capture-Image /ImageFile:"!destpath!\!destfile!" /CaptureDir:!captureSource! /Name:"!imagename!" /Description:"Cevrimici yedek - Volume %sourcevol% - !date! !time!" /Compress:max /CheckIntegrity /Verify /ScratchDir:"!DismScratch!" /LogPath:"!DismLog!"
        ) else (
            dism /Append-Image /ImageFile:"!destpath!\!destfile!" /CaptureDir:!captureSource! /Name:"!imagename!" /Description:"Cevrimici yedek - Volume %sourcevol% - !date! !time!" /CheckIntegrity /Verify /ScratchDir:"!DismScratch!" /LogPath:"!DismLog!"
        )
        set dismresult=!ERRORLEVEL!
        
        REM Staging temizliği
        if "!use_staging!"=="true" (
            echo !MSG_STAGING_CLEAN!
            if exist "!StagingDir!" rmdir /s /q "!StagingDir!"
            REM Kaynağı eski haline getir (loglarda doğru görünsün diye gerekirse)
            set "captureSource=!realSource!"
        )
    )

    REM Cleanup VSS Mount Point
    if defined mountDir (
        if exist "!mountDir!" rmdir "!mountDir!"
    )

    REM Cleanup VSS Snapshot
    if defined shadowPath (
        echo VSS Snapshot Cleaning...
        powershell -Command "$shadow = Get-WmiObject Win32_ShadowCopy | Where-Object { $_.DeviceObject -eq '!shadowPath!' }; if($shadow) { $shadow.Delete() }" >nul 2>&1
    )
    


)

if "!capturemode!"=="OFFLINE" (
    REM OFFLINE mod - Standart yedekleme
    echo !MSG_OFFLINE_BACKUP!
    
    REM DismLog ve Scratch yukarıda global tanımlandı.

    if "!dismaction!"=="/Capture-Image" (
        dism /Capture-Image /ImageFile:"!destpath!\!destfile!" /CaptureDir:!fullsourcepath!\ /Name:"!imagename!" /Description:"Cevrimdisi yedek - Volume %sourcevol% - !date! !time!" /ConfigFile:"!configlistpath!" /Compress:max /CheckIntegrity /Bootable /Verify /ScratchDir:"!DismScratch!" /LogPath:"!DismLog!"
    ) else (
        dism /Append-Image /ImageFile:"!destpath!\!destfile!" /CaptureDir:!fullsourcepath!\ /Name:"!imagename!" /Description:"Cevrimdisi yedek - Volume %sourcevol% - !date! !time!" /ConfigFile:"!configlistpath!" /Bootable /CheckIntegrity /Verify /ScratchDir:"!DismScratch!" /LogPath:"!DismLog!"
    )
    set dismresult=!ERRORLEVEL!
)
:end_of_backup_ops
if !dismresult! equ 0 (
    set succeeded=true
) else (
    set succeeded=false
)

set dismend=!date! !time!

REM ======== SONUÇ RAPORU ========
echo.
echo ========================================================
echo   !MSG_RESULT_HEADER!
echo ========================================================
if "!succeeded!"=="true" (
    echo   !MSG_STATUS! !MSG_SUCCESS!
    echo   !MSG_FILE! !destpath!\!destfile!
) else (
    echo   !MSG_STATUS! !MSG_FAIL!
    echo   !MSG_ERR_CODE! !dismresult!
    if "!capturemode!"=="OFFLINE" (
        echo   !MSG_LOG_FILE! !DismLog!
    ) else (
        echo   !MSG_LOG_FILE! C:\Windows\Logs\DISM\dism.log
    )
)
echo   !MSG_START! !dismstart!
echo   !MSG_END! !dismend!
echo   !MSG_MOD! !capturemode!
echo ========================================================
echo.

if "!succeeded!"=="true" (
    echo !MSG_DONE!
) else (
    echo !MSG_ERR_DONE!
)

:cleanup
REM ======== TEMİZLİK ========
echo.
echo !MSG_CLEAN!

REM SADECE geçici atanan harfleri kaldır
if "!source_needs_cleanup!"=="true" (
    if defined sourcedrive (
        echo !MSG_TEMP_REMOVE! !sourcedrive!:
        echo sel vol %sourcevol% > "%scriptpath%"
        echo remove letter=!sourcedrive! >> "%scriptpath%"
        echo exi >> "%scriptpath%"
        diskpart /s "%scriptpath%" >nul 2>&1
    )
)

if "!dest_needs_cleanup!"=="true" (
    if defined destdrive (
        echo !MSG_TEMP_REMOVE! !destdrive!:
        echo sel vol %destvol% > "%scriptpath%"
        echo remove letter=!destdrive! >> "%scriptpath%"
        echo exi >> "%scriptpath%"
        diskpart /s "%scriptpath%" >nul 2>&1
    )
)

REM Geçici dosyaları temizle
if exist "%scriptpath%" del /q "%scriptpath%" 2>nul
if exist "%selectsource%" del /q "%selectsource%" 2>nul
if exist "%selectdest%" del /q "%selectdest%" 2>nul
if exist "%configlistpath%" del /q "%configlistpath%" 2>nul
if exist "%netdrivelist%" del /q "%netdrivelist%" 2>nul
if exist "%TEMP%\vollist.txt" del /q "%TEMP%\vollist.txt" 2>nul
if exist "%TEMP%\vollist2.txt" del /q "%TEMP%\vollist2.txt" 2>nul
if exist "%TEMP%\thisvol.txt" del /q "%TEMP%\thisvol.txt" 2>nul
if exist "%TEMP%\thisvol2.txt" del /q "%TEMP%\thisvol2.txt" 2>nul
if exist "%TEMP%\volid.txt" del /q "%TEMP%\volid.txt" 2>nul
if defined ps_vss (
     if exist "!ps_vss!" del /q "!ps_vss!" 2>nul
)

REM Scratch klasörünü sil
if defined DismScratch (
    if exist "!DismScratch!" rmdir /s /q "!DismScratch!" >nul 2>&1
)

echo !MSG_CLEAN_DONE!
echo !MSG_CLEAN_EXIT!
pause >nul 2>&1
exit /b

REM ======== FONKSİYONLAR ========
:create_config_list
setlocal
set drivepath=%~1
echo !MSG_EXCLUSION_PREP! !drivepath!:\
echo. > "%configlistpath%"
echo [ExclusionList] >> "%configlistpath%"
echo \$ntfs.log >> "%configlistpath%"
echo \hiberfil.sys >> "%configlistpath%"
echo \Windows\System32\DriverStore\Temp >> "%configlistpath%"
echo \pagefile.sys >> "%configlistpath%"
echo \swapfile.sys >> "%configlistpath%"
echo \System Volume Information >> "%configlistpath%"
echo \RECYCLER >> "%configlistpath%"
echo \$Recycle.Bin >> "%configlistpath%"
echo \Windows\CSC >> "%configlistpath%"
echo \Windows\Temp >> "%configlistpath%"
echo \Temp >> "%configlistpath%"
echo \PerfLogs >> "%configlistpath%"

REM Kullanıcı profillerindeki bulut klasörleri
if exist "!drivepath!:\Users\" (
    pushd "!drivepath!:\Users"
    for /d %%f in (*) do (
        if exist "!drivepath!:\Users\%%f\OneDrive" echo \Users\%%f\OneDrive >> "%configlistpath%"
        if exist "!drivepath!:\Users\%%f\SkyDrive" echo \Users\%%f\SkyDrive >> "%configlistpath%"
        if exist "!drivepath!:\Users\%%f\Google Drive" echo \Users\%%f\Google Drive >> "%configlistpath%"
        if exist "!drivepath!:\Users\%%f\Dropbox" echo \Users\%%f\Dropbox >> "%configlistpath%"
        if exist "!drivepath!:\Users\%%f\AppData\Local\Temp" echo \Users\%%f\AppData\Local\Temp >> "%configlistpath%"
    )
    popd
)

echo. >> "%configlistpath%"
echo [CompressionExclusionList] >> "%configlistpath%"
echo *.mp3 >> "%configlistpath%"
echo *.mp4 >> "%configlistpath%"
echo *.avi >> "%configlistpath%"
echo *.mkv >> "%configlistpath%"
echo *.zip >> "%configlistpath%"
echo *.rar >> "%configlistpath%"
echo *.7z >> "%configlistpath%"
echo *.cab >> "%configlistpath%"
echo *.jpg >> "%configlistpath%"
echo *.jpeg >> "%configlistpath%"
echo *.png >> "%configlistpath%"
echo \WINDOWS\inf\*.pnf >> "%configlistpath%"
echo \WINDOWS\System32\DriverStore\*.cab >> "%configlistpath%"

endlocal
goto :eof