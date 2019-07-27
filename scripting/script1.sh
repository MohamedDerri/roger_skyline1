#!/bin/sh

echo  "\e[32m================================= DATE =================================\e[39m" >> /var/log/update_script.log
date >> /var/log/update_script.log
echo "\e[32m========================================================================\e[39m" >> /var/log/update_script.log
echo "\e[32m=============================== UPDATING ..  ============================\e[39m" >> /var/log/update_script.log
apt-get update -y >> /var/log/update_script.log
echo "\e[32m========================================================================\e[39m" >> /var/log/update_script.log
echo "\e[32m=============================== UPGRADING .. ===========================\e[39m" >> /var/log/update_script.log
apt-get upgrade -y >> /var/log/update_script.log
echo "\e[32m========================================================================" >> /var/log/update_script.log


