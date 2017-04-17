## Rome (`ROME`)
### Sat 04-Apr-2015
1. Finally got samba config for all users to always `rwx/0777` all files on shared drive
   * Trick is to not use create mask but force create mask and force directory mask
     * [this discussion](http://serverfault.com/questions/562875/samba-default-file-creation-mask-calculation) explains to comment-out/remove create mask and use force create mask
     * [and this discussion](https://lists.samba.org/archive/samba/2003-March/063429.html) mentions create mask and directory mask
     * [and a quick reminder of how file masks work numerically](http://www.computerhope.com/unix/uchmod.htm)
   * Settings for /etc/samba/smb.conf
     * `;   create mask = 0777`
     * `force create mode = 0777`
     * `force directory mode = 0777`
1. Installed `geeknote`
  * which requires `python_setuptools`
  * see notes in magnentius install log

## Living Room TV PC (`LIVING-RM-TV-PC`)
### Sun 16-Apr-2017
First-time went through default configuration for Windows 10.  Turned off geo-location and some data reporting/leakage to Microsoft.  Enabled Windows Defender and let it scan (took 40 minutes)

1. Removed docked icons from taskbar for:
   * Microsoft Edge
   * Microsoft Store
1. Added to `SENATE` workgroup though left using DHCP for everything
1. Installed:
   1. Firefox
      * Set homepage to: `https://www.google.co.uk`
   1. VLC 64-bit
      * default/auto-detected download is 32-bit
      * go find manually from their FTP site
   1. Libre Office
      * 5.2.6 64-bit (latest "still" version)
      * Help for offline use: English (GB), also 5.2.6
   1. Logitech K400 plus driver
      * tap trackpad = single-left-click disabled
      * two finger scrolling and pinch-zoom left enabled
      * bizarrely the configuration app is unusable if you zoom the resolution to 200%
 1. Changed default Windows "zoom" to 200% to assist usability for Dad
    * Slider is from 100%-200% in 25% increments
 1. Changed time to auto-update from `uk.pool.ntp.org` (was `time.windows.com`)
    * And when setting up, I chose "UTC+0, Dublin, Lisbon, London", when you do this during BST it gets the time one hour out
