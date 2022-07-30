# Input bindings are passed in via param block.
param($Timer)

# Resolve SendGrid FQDN
$result = [system.net.dns]::GetHostByName($env:TARGET_FQDN).AddressList.IPAddressToString

# Update NSG RUle
$SetNSG = Get-AzNetworkSecurityGroup -Name $env:NSG_NAME -ResourceGroupName $env:NSG_RESOURCEGROUP `
| Set-AzNetworkSecurityRuleConfig `
-Name $env:NSG_RULE_NAME `
-Protocol $env:NSG_RULE_PROTOCOL `
-SourcePortRange $env:NSG_RULE_SOURCE_PORTRANGE `
-DestinationPortRange $env:NSG_RULE_DEST_PORTRANGE `
-SourceAddressPrefix $env:NSG_RULE_SOURCE_ADDRESSPREFIX `
-DestinationAddressPrefix $result `
-Access $env:NSG_RULE_ACCESS `
-Priority $env:NSG_RULE_PRIORITY `
-Direction $env:NSG_RULE_DIRECTION `
| Set-AzNetworkSecurityGroup