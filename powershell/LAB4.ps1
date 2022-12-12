"###############################System Report#########################"
#function for hardware discription
function hardware
{
"System Hardware description"
Get-WmiObject win32_computersystem | Format-List
"##################################################################################
"
}


#function for operating system description
function operatingsystem {
"Operating System description"
Get-WmiObject win32_operatingsystem|Format-List name, version
"######################################################################################
"}


#function for processor description
function processor  {
"Processor description"
Get-WmiObject -class Win32_processor  | ft NumberOfCores,NumberOfLogicalProcessors
gwmi win32_processor | format-list 

"#########################################################################################
"
}


#function for RAM summary
function ram {
"RAM summary"
$ramc=0
$Sysram = Get-WmiObject win32_physicalmemory 
foreach ($ram in $Sysram) {
                     new-object -typename psobject -property @{Venetworkor=$ram.Manufacturer
                                                               Description=$ram.Description
                                                               "Size(GB)"=$ram.Capacity / 1gb -as [int]
                                                               BankLabel= $ram.banklabel
                                                               Slot = $ram.Devicelocator
                                                               }
                                                               $ramc = $ram.capacity/1gb -as [int]
                                                               }
                                                               "
Total RAM (GB) = $($ramc)"
                            
"####################################################################################################
"
}


#function for physical drive summary
function dr {
"Physical drive summary"
$diskdrives = Get-CimInstance cim_diskdrive
foreach ($disk in $diskdrives)
{
$partitions = $disk|Get-CimAssociatedInstance -resultclassname cim_diskpartition
foreach ($partition in $partitions )
{
$logicaldisks = $partition | Get-CimAssociatedInstance -ResultClassName cim_logicaldisk
foreach ($logicaldisk in $logicaldisks)
{
New-Object -TypeName psobject -Property @{Venetworkor=$disk.Manufacturer
                                            Model=$disk.Model
                                          "Size(GB)"=$logicaldisk.size/1gb -as [int]
                                          "Freespace(GB)"=$logicaldisk.freespace/1gb -as [int]
                                          "Percentage free"=($logicaldisk.freespace)/($logicaldisk.size)*100
                                          }|Format-Table
}
}
}
"##################################################################################################
"}


#function for network adapter summary 
function network {
"Network Adapter summary"
get-ciminstance win32_networkadapterconfiguration | where-object ipenabled | select-object Description,Inetworkex,ipaddress,ipsubnet,dnsdomain,dnsserversearchorder | format-table



"#########################################################################################################
"
}

#function for displaying vedio card summary
function vid {
"Video Card summary"
Get-WmiObject win32_videocontroller | Format-List name, description, videomodedescription
}
hardware
operatingsystem
ram
processor 
dr
network
vid

"###########################################________END________##################################################"