# This file is applicable for automatic installation of CentOS 7.9 and RHEL7.9
# Sample kickstart file for current EL, Fedora based distributions.

# Set the platform architecture, can be x86, AMD64, or Intel EM64T
#platform=x86, AMD64, or Intel EM64T

# System authorization information, use shadow file and enable MD5 encryption
auth  --useshadow  --enablemd5

# System bootloader configuration, install on the MBR (Master Boot Record)
bootloader --location=mbr

# Partition clearing information, clear all partitions and initialize the partition table
clearpart --all --initlabel

# Use graphical mode install
graphical
# Use text mode install (commented out)
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
url --url=http://192.168.10.100/cblr/links/centos7.9-x86_64/

# Network information, configure network using DHCP, device is eth0
network  --bootproto=dhcp --device=eth0
# Alternative network configuration (commented out)
#network  --bootproto=dhcp --device=eth1

# Reboot the system after installation
reboot

# Set root password, the password is encrypted
rootpw --iscrypted $1$afasdf$3Z59fZWtyPR7eYDutEzK91
# Create a user named admin, the password is encrypted, and set full name to "admin"
user --name=admin --password=$1$afasdf$3Z59fZWtyPR7eYDutEzK91 --iscrypted --gecos="admin"

# Disable SELinux
selinux --disabled

# Do not configure the X Window System (commented out)
skipx

# Set system timezone to Asia/Shanghai
timezone  Asia/Shanghai

# Install the OS instead of upgrading
install

# Clear the Master Boot Record
zerombr

# Use only the sda disk
ignoredisk --only-use=sda
# Create /boot/efi partition, filesystem type is efi, size is 1024MB
part /boot/efi --fstype="efi" --ondisk=sda --size=1024
# Create swap partition, filesystem type is swap, size is 16384MB
part swap --fstype="swap" --ondisk=sda --size=16384
# Create root partition, filesystem type is xfs, size is 60000MB, auto-expand
part / --fstype="xfs" --ondisk=sda --size=60000 --grow

# Pre-install script, includes some log and network configuration snippets
%pre
%end

# Package selection section, selects some package groups and individual packages for installation
%packages
@^graphical-server-environment
@base
@core
@desktop-debugging
@dial-up
@fonts
@gnome-desktop
@guest-agents
@guest-desktop-agents
@hardware-monitoring
@input-methods
@internet-browser
@multimedia
@print-client
@x11
chrony
kexec-tools
%end

# Post-install script, sets default target to graphical interface
%post
#/usr/bin/systemctl set-default graphical.target
/usr/bin/systemctl set-default multi-user.target
%end