$targetServers = "TS1","TS2","TS3"
$resWidth = 1024
$resHgt = 768
$domain = "DOMAIN"
#####################

$hereString = @"

audiomode:i:2
authentication level:i:0
autoreconnection enabled:i:1
bitmapcachepersistenable:i:1
compression:i:1
disable cursor setting:i:0
disable full window drag:i:1
disable menu anims:i:1
disable themes:i:1
disable wallpaper:i:1
displayconnectionbar:i:1
keyboardhook:i:2
redirectclipboard:i:1
redirectcomports:i:0
redirectdrives:i:0
redirectprinters:i:0
redirectsmartcards:i:0
session bpp:i:16
prompt for credentials:i:0
promptcredentialonce:i:1
"@

$list = import-csv rdpList.csv
forEach ($ts in $targetServers) {
 forEach ($item in $list) {
  $out = @()
  $out += "full address:s:" + $ts
  $out += "screen mode id:i:1"
  $out += "desktopwidth:i:" + $resWidth
  $out += "desktopheight:i:" + $resHgt
  $out += "username:s:" + $domain + "\" + $item.username
  $out += $hereString
  $outFileName = ".\" + $ts + "-" + $item.username + ".rdp"
  $out | out-file $outFileName
  $destPath = "\\" + $item.comp + "\c$\users\" + $item.username + "\documents\"
  copy-item $outFileName $destPath  
 } #closes foreach item
} #closes foreach ts