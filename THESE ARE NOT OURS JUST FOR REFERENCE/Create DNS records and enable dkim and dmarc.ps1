## Prerequisites = 2
## Need to connect to Exchange Online
## Need to connect to an Azure tenant and have a DNS Zone for domain already set up

$domain="customdomain.com"
$res_grp="domain" ## Resource group in Azure

$dkim = Get-DKIMSigningConfig $domain ## Get the correct configuration

$cname1 = $dkim.Selector1Cname ## Create the first DKIM selector CNAME
$cname2 = $dkim.Selector2Cname ## Create the second DKIM selector CNAME
$hostname1 = "selector1._domainkey"
$hostname2 = "selector2._domainkey"

New-AzureRmDnsRecordSet -Name $hostname1 -RecordType CNAME -ZoneName $domain -ResourceGroupName $res_grp -Ttl 3600 -DnsRecords (New-AzureRmDnsRecordConfig -Cname $cname1)

New-AzureRmDnsRecordSet -Name $hostname2 -RecordType CNAME -ZoneName $domain -ResourceGroupName $res_grp -Ttl 3600 -DnsRecords (New-AzureRmDnsRecordConfig -Cname $cname2)

set-dkimsigningconfig -identity $domain -enabled $true ## Enable DKIM for custom domain

New-AzureRmDnsRecordSet -Name "_dmarc" -RecordType TXT -ZoneName $domain -ResourceGroupName $res_grp -Ttl 3600 -DnsRecords (New-AzureRmDnsRecordConfig -value "v=DMARC1; p=none; pct=100; aspf=r; adkim=r")