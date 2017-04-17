# TO-DO
1. Living Room TV PC
   1. Use my Kitchen PC to experiment with on-start-up NTP set programs
      * have to allow *massive* time differences from last time
      * script you're using on the Raspberry Pi boxes might work on Windows with the right GnuWin32 programs
      * hunt from [ideas in here](http://stackoverflow.com/questions/426071/how-can-i-sync-the-computers-clock-upon-startup)
   1. write-up full IP list and assign a fixed-IP to this machine
   1. think on whether to install VNC to allow tunnelling-in from outside
      * though the broadband router is not playing ball at the moment to allow it to be configured
      * also need to switch from TigerVNC to something that a) has >8 character passwords and b) operates over SSL
      * then change the other machines to do the same

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
      * Make sure Firefox is the default browser in Windows
        * You get prompted by the installer, but Windows is sneaky and you get dropped into the Windows default app thing
      * Set homepage to: `https://www.google.co.uk`
      * Customised position of 'home' to the left of the address bar
      * GitHub announces itself as a possible search engine causing a little '+' sign to appear next to the magnifying glass in the Search bar
        * Click on it and 'Add GitHub'
        * Click again on the magnifying glass, click on 'Change Search Settings'
        * Unselect GitHub as an option (do not remove it otherwise the '+' will appear again)
   1. VLC 64-bit
      * Default/auto-detected download is 32-bit
      * Go find manually from their FTP site
      * Make sure VLC is the default media player in Windows
        * Go find the Windows default app thing
   1. Libre Office
      * 5.2.6 64-bit (latest "still" version)
      * Help for offline use: English (GB), also 5.2.6
   1. Logitech K400 plus driver
      * tap trackpad = single-left-click disabled
      * two finger scrolling and pinch-zoom left enabled
      * bizarrely the configuration app is unusable if you zoom the resolution to 200%
   1. Games from old Windows XP/7/8
      * Copy from Rome into 'obvious' folders on `C:\`
      * `CARDS.DLL` is missing, though...
   1. [7-Zip](http://7-zip.org/) 64-bit version
   1. [GNU Utils](http://getgnuwin32.sourceforge.net/) 32-bit version
      * Save the `GetGnuWin32.exe` application
      * Run it as Administrator
      * The GPL licence display box is blank (either the text is missing or the font is wrong/borked)
      * Change the install location to: `C:\Program Files\GnuWin32` and create the `GnuWin32` folder there 
      * After install, move contents of the `GetGnuWin32` folder in the install folder up one level and remove `GetGnuWin32`
      * Hmmm... this might be a mistake, it looks like I've got the wrong downloader/installer or that GnuWin32 now goes and gets the latest packages after download - don't care right now
   1. Download `CARDS.DLL` from my Google Drive and store in the `C:\Program Files\GnuWin32\bin` folder
      * Add `C:\Program Files\GnuWin32\bin` to the `PATH`
      * Interesting user interface glitch - have already changed the Windows "zoom" to 200% and the Environment Variables screen is off the bottom and you can't get at the "OK" and "Cancel" buttons - tab through, "OK" is first and press Enter
      * Finally check the cards games all work
        * Start Solitaire and change the settings to "Draw 1" card
   1. Notepad++ 64-bit version
1. Changed default Windows "zoom" to 200% to assist usability for Dad
   * Slider is from 100%-200% in 25% increments
1. Changed time to auto-update from `uk.pool.ntp.org` (was `time.windows.com`)
   * And when setting up, I chose "UTC+0, Dublin, Lisbon, London", when you do this during BST it gets the time one hour out
1. Configure Windows Explorer to connect Documents, Pictures, Music and Videos to appropriate shares on Rome
   * First browse through Windows Explorer to `ROME` and login as Dad and get Windows to save the credentials
   * Now right-click each of Documents, Pictures, Music and Videos and got through their Properties, Location and set to the right places
   * When prompted to Move existing files, yes and skip any that already there (you're moving from a new machine to a lot of existing stuff)
   * Leave Downloads and Desktop local, though Desktop will have to have some things like Phone Book and Banking added
1. Back to the time - it reverted to UTC from BST
   * Have stopped it from automatically detecting the time zone, and forced a change by +1 hour then a sync with `uk.pool.ntp.org`
   * Strongly suspect Windows will write the UTC time into the system/BIOS when it shuts down then tomorrow will get the time 1 hour out again
   * Worse - the hardware doesn't have a RTC, on restart the clock was still 2.54am (previous day shutdown time).  Need to research Windows start-up programs to force an NTP sync
