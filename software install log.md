## ROME
### Sat 04-Apr-2015
1. Finally got samba config for all users to always rwx/0777 all files on shared drive
1.1. Trick is to not use create mask but force create mask and force directory mask
1.2. http://serverfault.com/questions/562875/samba-default-file-creation-mask-calculation
1.2.1. this explains to comment-out/remove create mask and use force create mask
1.3. https://lists.samba.org/archive/samba/2003-March/063429.html
1.3.1. and this mentions create mask and directory mask
1.4. http://www.computerhope.com/unix/uchmod.htm
1.4.1. and this is a quick reminder of how file masks work numerically
2. Installed geeknote
2.1. which requires python_setuptools
2.2. see notes in magnentius install log
