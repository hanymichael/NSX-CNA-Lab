##!/bin/bash
if [ -z "$2" ]
  then
    echo "Arguments supplied not complete. Please provide the NSX-T release and build number."
    echo "Syntax: ./nsx-t-auto-deploy.sh 1.1 4978068 4978109 4978108 4978110"
    exit 1
fi
echo ""
echo "███╗   ██╗███████╗██╗  ██╗  ████████╗     █████╗ ██╗   ██╗████████╗ ██████╗       ██████╗ ███████╗██████╗ ██╗      ██████╗ ██╗   ██╗"
echo "████╗  ██║██╔════╝╚██╗██╔╝  ╚══██╔══╝    ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗      ██╔══██╗██╔════╝██╔══██╗██║     ██╔═══██╗╚██╗ ██╔╝"
echo "██╔██╗ ██║███████╗ ╚███╔╝█████╗██║       ███████║██║   ██║   ██║   ██║   ██║█████╗██║  ██║█████╗  ██████╔╝██║     ██║   ██║ ╚████╔╝ "
echo "██║╚██╗██║╚════██║ ██╔██╗╚════╝██║       ██╔══██║██║   ██║   ██║   ██║   ██║╚════╝██║  ██║██╔══╝  ██╔═══╝ ██║     ██║   ██║  ╚██╔╝  "
echo "██║ ╚████║███████║██╔╝ ██╗     ██║       ██║  ██║╚██████╔╝   ██║   ╚██████╔╝      ██████╔╝███████╗██║     ███████╗╚██████╔╝   ██║   "
echo "╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝     ╚═╝       ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝       ╚═════╝ ╚══════╝╚═╝     ╚══════╝ ╚═════╝    ╚═╝   "
                                                                                                                                                                                                                                                                      
echo ""
echo "╔══════════════════════════╗"
echo "║- Author: Hany Michael    ║"
echo "║- eMail: hany@vmware.com  ║"
echo "║- Version: 1.0            ║"
echo "╚══════════════════════════╝"
echo ""
echo ""
# vCenter Server Params 
vcip="192.168.110.20"
vcadmin="administrator@core.hypervizor.com"
vcpass="VMware1!"

# NSX-T Manager Params
mgrname="NSX-T-Manager-$1-$2"
mgrdatastore="DatastoreCluster-CAI"
mgrnetwork="DPortGroup-CAI-VM-Management-Networks"
mgrip="192.168.110.26"
mgrnetmask="255.255.255.0"
mgrgw="192.168.110.2"
mgrdns="192.168.110.10"
mgrdomain="core.hypervizor.com"
mgrntp="192.168.110.2"
mgrssh="True"
mgrroot="True"
mgrcorfu="CorfuDao: false"
mgrpasswd="VMware1!"
mgrhostname="nsxtmgr"
mgresxhost="192.168.110.41"

# NSX-T Controller Params
ctrlname="NSX-T-Controller-$1-$2"
ctrldatastore="DatastoreCluster-CAI"
ctrlnetwork="DPortGroup-CAI-VM-Management-Networks"
ctrlip="192.168.110.29"
ctrlnetmask="255.255.255.0"
ctrlgw="192.168.110.2"
ctrldns="192.168.110.10"
ctrldomain="core.hypervizor.com"
ctrlntp="192.168.110.2"
ctrlssh="True"
ctrlroot="True"
ctrlpasswd="VMware1!"
ctrlhostname="nsxtcont"
ctrlesxhost="192.168.110.42"
ctrlsecpasswd="VMware1!"

# NSX-T Edge01 Params
e1name="NSX-T-Edge01-$1-$2"
e1datastore="DatastoreCluster-CAI"
e1deploymentsize="small"
e1net0="DPortGroup-CAI-VM-Management-Networks"
e1net1="DPortGroup-CAI-VM-Management-Networks"
e1net2="ToR-CAI-Edge-Net-TRUNK-VLANs55-59"
e1net3="DPortGroup-CAI-Edge-Net01"
e1ip="192.168.110.65"
e1netmask="255.255.255.0"
e1gw="192.168.110.2"
e1dns="192.168.110.10"
e1domain="core.hypervizor.com"
e1ntp="192.168.110.2"
e1ssh="True"
e1root="True"
e1passwd="VMware1!"
e1hostname="nsxtedge01"
e1esxhost="192.168.110.43"

# NSX-T Edge02 Params
e2name="NSX-T-Edge02-$1-$2"
e2datastore="DatastoreCluster-CAI"
e2deploymentsize="small"
e2net0="DPortGroup-CAI-VM-Management-Networks"
e2net1="DPortGroup-CAI-VM-Management-Networks"
e2net2="ToR-CAI-Edge-Net-TRUNK-VLANs55-59"
e2net3="DPortGroup-CAI-Edge-Net01"
e2ip="192.168.110.66"
e2netmask="255.255.255.0"
e2gw="192.168.110.2"
e2dns="192.168.110.10"
e2domain="core.hypervizor.com"
e2ntp="192.168.110.2"
e2ssh="True"
e2root="True"
e2passwd="VMware1!"
e2hostname="nsxtedge02"
e2esxhost="192.168.110.43"

# NSX Buildweb URL - These URLs are masked. Contact me if you are a VMware employee to get the internal URLs
# For external use, login to myvmware, go to the NSX download area and paste the URL here.
nsxMgrBuildweb_URL=""
nsxCtrlBuildweb_URL=""
nsxEdgeBuildweb_URL=""

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ NSX-T Release: $1                                    ║"
echo "║ NSX-T General Build: $2                          ║"
echo "║ NSX-T Manager Build: $3                          ║"
echo "║ NSX-T Controller Build: $4                       ║"
echo "║ NSX-T Edge Node Build: $5                        ║"
echo "╚═══════════════════════════════════════════════════════╝"

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ Deploying the NSX-T Manager OVA                       ║"
echo "╚═══════════════════════════════════════════════════════╝"
ovftool --name=$mgrname --X:injectOvfEnv --X:logFile=mgrovftool.log --allowExtraConfig --datastore=$mgrdatastore --network=$mgrnetwork --acceptAllEulas --noSSLVerify --diskMode=thin --powerOn --prop:nsx_ip_0=$mgrip --prop:nsx_netmask_0=$mgrnetmask --prop:nsx_gateway_0=$mgrgw --prop:nsx_dns1_0=$mgrdns --prop:nsx_domain_0=$mgrdomain --prop:nsx_ntp_0=$mgrntp --prop:nsx_isSSHEnabled=$mgrssh --prop:nsx_allowSSHRootLogin=$mgrroot --prop:nsx_passwd_0=$mgrpasswd --prop:nsx_cli_passwd_0=$mgrpasswd  --prop:extraPara="CorfuDao: false" --prop:nsx_hostname=$mgrhostname $nsxMgrBuildweb_URL'nsx-manager-'$1'.0.0.0.'$3'.ova' vi://$vcadmin:$vcpass@$vcip/?ip=$mgresxhost

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ Deploying the NSX-T Controller OVA                    ║"
echo "╚═══════════════════════════════════════════════════════╝"
ovftool --name=$ctrlname --X:injectOvfEnv --X:logFile=ctrlovftool.log --allowExtraConfig --datastore=$ctrldatastore --network=$ctrlnetwork --acceptAllEulas --noSSLVerify --diskMode=thin --powerOn --prop:nsx_ip_0=$ctrlip --prop:nsx_netmask_0=$ctrlnetmask --prop:nsx_gateway_0=$ctrlgw --prop:nsx_dns1_0=$ctrldns --prop:nsx_domain_0=$ctrldomain --prop:nsx_ntp_0=$ctrlntp --prop:nsx_isSSHEnabled=$ctrlssh --prop:nsx_allowSSHRootLogin=$ctrlroot --prop:nsx_passwd_0=$ctrlpasswd --prop:nsx_cli_passwd_0=$ctrlpasswd --prop:nsx_hostname=$ctrlhostname $nsxCtrlBuildweb_URL'nsx-controller-'$1'.0.0.0.'$4'.ova' vi://$vcadmin:$vcpass@$vcip/?ip=$ctrlesxhost

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ Deploying the NSX-T Edge01 OVA                        ║"
echo "╚═══════════════════════════════════════════════════════╝"
ovftool --name=$e1name --deploymentOption=$e1deploymentsize --X:injectOvfEnv --X:logFile=e1ovftool.log --allowExtraConfig --datastore=$e1datastore --net:"Network 0=$e1net0" --net:"Network 1=$e1net1" --net:"Network 2=$e1net2" --net:"Network 3=$e1net3" --acceptAllEulas --noSSLVerify --diskMode=thin --powerOn --prop:nsx_ip_0=$e1ip --prop:nsx_netmask_0=$e1netmask --prop:nsx_gateway_0=$e1gw --prop:nsx_dns1_0=$e1dns --prop:nsx_domain_0=$e1domain --prop:nsx_ntp_0=$e1ntp --prop:nsx_isSSHEnabled=$e1ssh --prop:nsx_allowSSHRootLogin=$e1root --prop:nsx_passwd_0=$e1passwd --prop:nsx_cli_passwd_0=$e1passwd --prop:nsx_hostname=$e1hostname $nsxEdgeBuildweb_URL'nsx-edge-'$1'.0.0.0.'$5'.ova' vi://$vcadmin:$vcpass@$vcip/?ip=$e1esxhost 

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ Deploying the NSX-T Edge02 OVA                        ║"
echo "╚═══════════════════════════════════════════════════════╝"
ovftool --name=$e2name --deploymentOption=$e2deploymentsize --X:injectOvfEnv --X:logFile=e2ovftool.log --allowExtraConfig --datastore=$e2datastore --net:"Network 0=$e1net0" --net:"Network 1=$e1net1" --net:"Network 2=$e1net2" --net:"Network 3=$e1net3" --acceptAllEulas --noSSLVerify --diskMode=thin --powerOn --prop:nsx_ip_0=$e2ip --prop:nsx_netmask_0=$e2netmask --prop:nsx_gateway_0=$e2gw --prop:nsx_dns1_0=$e2dns --prop:nsx_domain_0=$e2domain --prop:nsx_ntp_0=$e2ntp --prop:nsx_isSSHEnabled=$e2ssh --prop:nsx_allowSSHRootLogin=$e2root --prop:nsx_passwd_0=$e2passwd --prop:nsx_cli_passwd_0=$e2passwd --prop:nsx_hostname=$e2hostname $nsxEdgeBuildweb_URL'nsx-edge-'$1'.0.0.0.'$5'.ova' vi://$vcadmin:$vcpass@$vcip/?ip=$e2esxhost

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ Getting NSX-T Manager Thumbprint                      ║"
echo "╚═══════════════════════════════════════════════════════╝"
thumbp=$(sshpass -p $mgrpasswd ssh admin@nsxtmgr -o StrictHostKeyChecking=no "get certificate api thumbprint")
echo "NSX-T Thumbprint : $thumbp"

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ Joining the NSX-T Controller to the NSX-T Manager     ║"
echo "╚═══════════════════════════════════════════════════════╝"
nsxtcontjoinresult=$(sshpass -p $mgrpasswd ssh admin@$mgrhostname -o StrictHostKeyChecking=no "join management-plane $mgrip username admin password $mgrpasswd thumbprint $thumbp")
echo "Result: $nsxtcontjoinresult"

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ Setting Controller Cluster Security                   ║"
echo "╚═══════════════════════════════════════════════════════╝"
nsxtcontsecresult=$(sshpass -p $ctrlpasswd ssh admin@$ctrlhostname -o StrictHostKeyChecking=no "set control-cluster security-model shared-secret secret $ctrlsecpasswd")
echo "Result: $nsxtcontsecresult"

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ Initializing The Controller Cluster                   ║"
echo "╚═══════════════════════════════════════════════════════╝"
nsxtcontinitresult=$(sshpass -p $ctrlpasswd ssh admin@$ctrlhostname -o StrictHostKeyChecking=no "initialize control-cluster")
echo "Result: $nsxtcontinitresult"

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ Joining Edge Node 01 to the NSX-T Manager             ║"
echo "╚═══════════════════════════════════════════════════════╝"
e1joinresult=$(sshpass -p $e1passwd ssh admin@$e1hostname -o StrictHostKeyChecking=no "join management-plane $mgrip username admin password $mgrpasswd thumbprint $thumbp")
echo "Result: $e1joinresult"

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ Joining Edge Node 02 to the NSX-T Manager             ║"
echo "╚═══════════════════════════════════════════════════════╝"
e2joinresult=$(sshpass -p VMware1! ssh admin@$e2hostname -o StrictHostKeyChecking=no "join management-plane $mgrip username admin password $mgrpasswd thumbprint $thumbp")
echo "Result: $e2joinresult"



echo ' ____  _  _   ___   ___  ____  ____  ____'
echo '/ ___)/ )( \ / __) / __)(  __)/ ___)/ ___)'
echo '\___ \) \/ (( (__ ( (__  ) _) \___ \\___ \'
echo '(____/\____/ \___) \___)(____)(____/(____/'
