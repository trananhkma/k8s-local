#!/bin/bash

vboxmanage hostonlyif create
vboxmanage hostonlyif ipconfig vboxnet0 --ip 192.168.68.1 --netmask 255.255.255.0
