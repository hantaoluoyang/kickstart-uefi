#This file is applicable for automatic installation of RHEL9.4, almalinux 9.4, and Rocky linux9.4
# Sample kickstart file for current EL, Fedora based distributions.
# In RHEL 8, two parameters have changed: the auth parameter has been replaced by authselect, and the install parameter has been deprecated.

# Set the platform architecture, can be x86, AMD64, or Intel EM64T
#platform=x86, AMD64, or Intel EM64T

# System authorization information, use shadow file and enable MD5 encryption
authselect  --useshadow  --enablemd5

# System bootloader configuration, install on the MBR (Master Boot Record)
bootloader --location=mbr

# Partition clearing information, clear all partitions and initialize the partition table
clearpart --all --initlabel

# Use graphical mode install(commented out)
graphical
# Use text mode install 
#text

# Firewall configuration, disable the firewall
firewall --disabled

# Disable the setup agent on first boot
firstboot --disable

# Set system keyboard layout to US English
keyboard us

# Set system language to US English
lang en_US

# Use network installation, specify the installation URL
url --url=http://192.168.10.100/cblr/links/rocky9.4-x86_64/

# Network information, configure network using DHCP, device is eth0
network  --bootproto=dhcp --device=eth0 --onboot=on
# Alternative network configuration (commented out)
#network  --bootproto=dhcp --device=eth1 --onboot=on

# Reboot the system after installation
reboot

# Set root password, the password is encrypted
rootpw --iscrypted $1$afasdf$3Z59fZWtyPR7eYDutEzK91
# Create a user named admin, the password is encrypted, and set full name to "admin"
user --name=admin --password=$1$afasdf$3Z59fZWtyPR7eYDutEzK91 --iscrypted --gecos="admin"

# Disable SELinux
selinux --disabled

# Do not configure the X Window System
skipx

# Set system timezone to Asia/Shanghai
timezone  Asia/Shanghai

# Clear the Master Boot Record
zerombr

# Use only the nvme0n1 disk（Optional sda）
ignoredisk --only-use=nvme0n1
# Create /boot/efi partition, filesystem type is efi, size is 1024MB
part /boot/efi --fstype="efi" --ondisk=nvme0n1 --size=1024
# Create swap partition, filesystem type is swap, size is 16384MB
part swap --fstype="swap" --ondisk=nvme0n1 --size=16384
# Create root partition, filesystem type is xfs, size is 60000MB, auto-expand
part / --fstype="xfs" --ondisk=nvme0n1 --size=60000 --grow

# Pre-install script, includes some log and network configuration snippets
%pre
%end

# Package selection section, selects some package groups and individual packages for installation
%packages
@^graphical-server-environment
@additional-devel
@development
@platform-devel
bash-completion
chrony
dos2unix
kexec-tools
lrzsz
sysstat
tree
vim
wget
git
net-tools
%end

# Post-install script, sets default target to graphical interface
%post
#/usr/bin/systemctl set-default graphical.target
/usr/bin/systemctl set-default multi-user.target
%end



