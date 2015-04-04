# ROME
## Sat 04-Apr-2015
##- Finally got samba config for all users to always rwx/0777 all files on shared drive
##-- Trick is to not use create mask but force create mask and force directory mask
##-- http://serverfault.com/questions/562875/samba-default-file-creation-mask-calculation
##--- this explains to comment-out/remove create mask and use force create mask
##-- https://lists.samba.org/archive/samba/2003-March/063429.html
##--- and this mentions create mask and directory mask
##-- http://www.computerhope.com/unix/uchmod.htm
##--- and this is a quick reminder of how file masks work numerically
##- Installed geeknote
##-- which requires pythin_setuptools
##-- see notes in magnentius install log
