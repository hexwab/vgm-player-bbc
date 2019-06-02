vgm_demo.ssd: vgm_demo.asm
	beebasm -i vgm_demo.asm -do vgm_demo.ssd -boot Main -v >out.txt
speedtest.ssd: speedtest.asm speedtest.bas
	beebasm -i speedtest.asm -do speedtest.ssd -opt 3
