# Comcast Genetec
A process to restart Chrome to get a semi-reliable way to view security cameras. 

When I think of security cameras; I think of a screen with a view onto those cameras. Comcast's SmartOffice security camera product is a white label of Genetec's product. The way you view your cameras is through a webpage.

I've found this very unreliable: disconnections, freezes, failure to load, etc. I've worked with Comcast (and they with Genetec) to try and get it reliable but to no avail. 

I've given up on them and instead have come up with a script the will restart Chrome and navigate to the camera page every 15 minutes. I take a before and after picture and save it to Dropbox so I can monitor it from afar. 

**Approach**
Using AutoHotKey on Windows 7, take a screenshot (with MiniCap); save it to Dropbox; close Chrome; start Chrome; press “Log on with Microsoft”; wait and take a screenshot; save it to Dropbox.

**Technology Used**
* [AutoHotKey][https://www.autohotkey.com]
* [MiniCap][http://www.donationcoder.com/software/mouser/popular-apps/minicap]
* Dropbox for screenshot syncing.
* Set Chrome Start Page to https://app.smartoffice.comcast.com/EndUsers#url=/EndUsers/16249/Monitoring
	
**Windows Configuration**
* Turn off Dropbox notifications
* Hide task bar
* Disable automatic windows updates (set to download only)
* Put shortcut to script and Chrome in startup folder. 

A prior version of this scritpt used NirCmd for screen capture but I found MiniCap could get a 95% reduction in file size. I'm not looking for perfection in my screen captures. I'm looking for quick validation things are working as expected. MiniCap allows me to compress and color ship the screen capture to achive goal of less storage space. The prior version using NirCmd is in an earlier commit of the script.

**To Do**
* Wait for the page to finish loading instead of relying on a timer
* Programmatically find the button and click on it instead of blind x, y coordinates