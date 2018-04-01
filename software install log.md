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

## New Laptop (Lenovo X230) (`LENOVO_X230`)
### 02-Apr-2018 0020
Renamed from `DESKTOP-R0CBSLO` to `LENOVO_X230`

My Documents etc... redirection - see notes below...

### 01-Apr-2018 1600
Switched from DHCP to fixed IP: 192.168.1.9, netmask: 255.255.254.0, DNS: 192.168.0.2, 208.67.222.222 (Open DNS)

### 31-Mar-2018 1630
- On train to Newport (1630 MAN - NWP 1934), battery been in use 10 minutes from full charge and reporting as 3h 38m to go (92%)
- 31-Mar-2018: 1645 - been editing this Github page over the EE box wifi (needed Evernote and the train wifi is unsecured, and Evernote refuses to allow the connection - this is an interesting piece of learning about Evernote by the way...), so battery been in use about 25 minutes from full charge and is reporting as 4h 47m to go (88%)... or in sum: this is a *cool* laptop, especially now all the Lenovo drivers and stuff are installed and the touchpad is working OK.
- 31-Mar-2018: 1755 - been browsing & reading, nothing too strenuous, still 3h 39m (65%) remaining.
- 31-Mar-2018: 1836 - watched 8m video clip online, more browsing, on and off the train wifi and the EE box, still 2h 33m (49%) remaining.

### Previously...
#### Commissioning this for Dad:
- screen size is small, will need to massively increase the size
- magnifier possibly OK, though it tends to hover and get in the way
- get him on Facebook annoying people
- and stop both of their Facebook notifications from e-mailing them, it seriously pisses Mum off, and it'll drive him nuts too

#### Getting VNC over SSH to work...
- install [Cygwin](https://cygwin.com/install.html)
- install Open SSH, Open SSL and nano
- run Cygwin as Administrator
  - ssh-host-config and follow your nose
  - one or more of: [Gina Trapani's Life Hacker instructions from 2006](https://lifehacker.com/205090/geek-to-live--set-up-a-personal-home-ssh-server) (that really only need a little updating), [this](https://dev.to/zduey/how-to-set-up-an-ssh-server-on-a-home-computer), [this](https://crl.ucsd.edu/handbook/vnc/), [this](https://helpdeskgeek.com/how-to/tunnel-vnc-over-ssh/), [this](https://wiki.centos.org/HowTos/Network/SecuringSSH), [this](https://superuser.com/questions/1032971/permission-denied-on-ssh-access-with-cygwin) and [this](https://dbaportal.eu/2015/03/05/installing-openssh-cygwin-1-7-35-on-windows-2012-r2/)
  - basically use the hall PC as the proving and documenting ground for all of this
  - [ports to open](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers): 22 (UDP and TCP in both directions), the "higher order" port, 259xx, again UDP and TCP in both directions
  - I did get the laptop in the living room to connect to the Lenovo X230 on port 25933, though I have port 22 open for SSHD to respond on, though the session from the living room laptop was on port 25933 - ah, hang on, I have added a listener to TightVNC on port 25933 - so was the session from the laptop truly SSH secured?
  - Re-run this by checking if 25933 is the open port through the router at 7BC - that might be what was in my head: connect on 25931 when inside the house and 25933 when outside so you could quickly administer access at a port level while leaving either internal or external open

## Hall PC (`HALL_PC`)
IP: 192.168.1.5, netmask: 255.255.254.0, DNS: 192.168.0.2, 208.67.222.222 (Open DNS)
### Sun 01-Apr-2018
Cygwin installed, SSH tunnelling configured, VNC-over-SSH enabled and tested from inside and outside.

You still can connect by VNC over a non-encrypted tunnel, and the way you have to leave the non-encrypted port open on the route leads me to suspect once the SSH tunnel has logged-in and setup VNC, there's no real reason why the VNC session would stay encrypted.

Notes/thoughts on this are in other Pastebin documents.


## Rome (`ROME`)
### Fri 16-Mar-2018
#### ntp
Power lost at the start of March (cold weather, power cut in the area for a few minutes). Once power returned, the clock reset to 01-Jan-1970. This has a weird side-effect, any files saved from a Windows machine through to this file server gets a date/time stamp that the Windows machine cannot understand - or that Samba doesn't return (you end up with blank space in the display in Windows explorer).

Getting ntpd to run at boot is easy - and I think happens out of the box, just enable the execute flag on ```/etc/rc.d/rc.ntpd``` and make sure there's some servers specified in ```/etc/ntp.conf```.  But... this won't work as the daemon runs in the background and monitors the time all the time, and will adjust it as the clock shifts.  When it reboots and the date/time is 1st Jan 1970, the difference/offset is too great and it won't set the time correctly.

So... to fix this, before starting ```ntpd```, run ```ntpdate``` first to force the clock to be corrected, then start ```ntpd```.  Modify ```/etc/rc.d/rc.ntpd``` and I've added a special ```ntp_start1()``` section that calls the ```ntp_stop()``` section first to ensure the daemon isn't running, then waits a second, then runs ```ntp_date``` to set the clock correctly.  Finally run the ```ntp_start()``` section to start the daemon as normal.

Change the default behaviour of ```rc.ntpd``` and the behaviour if 'start' is passed as a command-line prompt to both use the new ```ntp_start1()``` section and away you go, the time is set correctly whenever the machine restarts, even from a loss of power.  I did try adding just ```ntpdate``` to ```rc.local``` but... it must be called after the daemon is running as nothing happens.  Change to ```rc.local``` reverted.

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

### 29-Dec-2014
#### rc.local - noip
Created ```rc.local``` to allow noip2 to run.  Following instructions from [noip.com](noip.com) website and script sample in: ```/usr/local/src/noip-2.1.9-1/README.FIRST```.

#### rc.local - killproc line
Line from noip or already in ```rc.local``` has:
* ```. /etc/rc.d/init.d/functions  # uncomment/modify for your killproc```
it isn't needed so is commented out


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
   1. Session Manager plugin added to Firefox
      * Go through the settings and switch off notification after update
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
