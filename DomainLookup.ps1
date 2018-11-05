# -------------------------------------------------------------
# DNS lookup script
#
# DomainLookup.ps1
# dnsLookup {}
#
# Author: J Shand & B Western
# Version: 1.0
# 
# This script ill provide the DNS records for the given domain
#
# -------------------------------------------------------------

Function dnsLookup {

$domain = Read-Host "Please enter domain to get records for: "
$file = "${env:\userprofile}\Documents\DNS_$domain.txt"
Resolve-DnsName -Name $domain -Type MX | Out-File $file
Resolve-DnsName -Name $domain -Type TXT | Out-File $file -Append
Resolve-DnsName -Name $domain -Type CNAME | Out-File $file -Append
Resolve-DnsName -Name $domain -Type SRV | Out-File $file -Append
Resolve-DnsName -Name $domain -Type A_AAAA | Out-File $file -Append
Resolve-DnsName -Name $domain -Type NS | Out-File $file -Append

}