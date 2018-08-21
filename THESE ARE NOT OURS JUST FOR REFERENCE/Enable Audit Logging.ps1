## Prerequisites = 1
## 1. Connection to Office 365 Exchange Online

get-AdminAuditLogConfig ## get complete Office 365 Audit Log properties

get-AdminAuditLogConfig | select unifiedauditlogingestionenabled ## get Audit Log status

Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $true ## enable Audit loggings