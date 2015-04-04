## ROME
### Sat 04-Apr-2015
1. Finally got samba config for all users to always `rwx/0777` all files on shared drive
1.* Trick is to not use create mask but force create mask and force directory mask
1.** [this discussion](http://serverfault.com/questions/562875/samba-default-file-creation-mask-calculation) explains to comment-out/remove create mask and use force create mask
1.** [and this discussion](https://lists.samba.org/archive/samba/2003-March/063429.html) mentions create mask and directory mask
1.** [and a quick reminder of how file masks work numerically](http://www.computerhope.com/unix/uchmod.htm)
2. Installed `geeknote`
2.* which requires `python_setuptools`
2.* see notes in magnentius install log
