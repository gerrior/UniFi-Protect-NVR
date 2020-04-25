# Comcast Genetec
A process to restart Chrome to get a semi-reliable way to view Comcast/Genetec security cameras. 

When I think of security cameras; I think of a screen with a view onto those cameras. Comcast's SmartOffice security camera product is a white label of Genetec's product. The way you view your cameras is through a webpage.

I've found this very unreliable: disconnections, freezes, failure to load, etc. I've worked with Comcast (and they with Genetec) to try and get it reliable but to no avail. 

I've given up on them and instead have come up with a script the will restart Chrome and navigate to the camera page every 15 minutes. I take a before and after picture and save it to Dropbox so I can monitor it from afar. 

A "Refresh?" link will sometimes appear in place of a camera image. A one-minute timer will click the screen in the 6 areas where a "Refresh?" link might appear. If the "Refresh?" link is not visible then a HUD will dispay briefly and go away. This process is skipped if the "restart Chrome" function is in progress. 

**Approach**

***Restart Chrome***

* Every 15 minutes
* Using AutoHotKey on Windows 7, take a screenshot (with MiniCap)
* Save screenshot to Dropbox
* Close Chrome
* Start Chrome
* Press “Log on with Microsoft”
* Enter email address
* wait and take a second screenshot
* Save it to Dropbox

***Refresh Links***

* Every minute
* Press the "Refresh?" link(s)

**Technology Used**

* [AutoHotKey](https://www.autohotkey.com)
* [MiniCap](http://www.donationcoder.com/software/mouser/popular-apps/minicap)
* Dropbox for screenshot syncing.
* Set Chrome Start Page to <https://app.smartoffice.comcast.com/EndUsers#url=/EndUsers/16249/Monitoring>

**Windows Configuration**

* Turn off Dropbox notifications
* Hide task bar
* Disable automatic windows updates (set to download only)
* Put shortcut to script and Chrome in startup folder. 
* Change BIOS to power-on after power failure. 

A prior version of this scritpt used NirCmd for screen capture but I found MiniCap could get a 95% reduction in file size. I'm not looking for perfection in my screen captures. I'm looking for quick validation things are working as expected. MiniCap allows me to compress and convert the screen capture to black & white to achive the goal of less storage space. The prior version using NirCmd is in an earlier commit of the script.

**To Do**

* Wait for the page to finish loading instead of relying on a timer
* Programmatically find the button and click on it instead of blind x, y coordinates
