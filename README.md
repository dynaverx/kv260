# kv260
To enable kria k26 SOM to boot from SD card on kv260 starter kit, use scripts provided with the "device registers to boot from SD" file. XSCT console screenshot might be useful for those who need to program flash newly purchased kr6 SOM.
![xsct](https://user-images.githubusercontent.com/15190686/230725678-cf99243d-0216-47f7-857d-c0a4ca06442f.png)
Use "set_DP-1.sh" script adds and sets a new mode to DP-1 of display while maintaining the running of your application at startup.
Use and locate .desktop file under "etc/xdg/autostart" to run your app at startup of petalinux automatically.
![KV260_alt_boot_mode](https://user-images.githubusercontent.com/15190686/230727844-7349e99e-3c67-4e16-a36c-9c97e23d3541.png)
go to:[https://www.xilinx.com/htmldocs/registers/ug1087/ug1087-zynq-ultrascale-registers.html]
search for "Boot" within contents on the left side
