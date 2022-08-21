#!/usr/bin/env bash
pacman -S qemu-full libvirt
systemctl enable libvirtd
systemctl start libvirtd
