Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QRvU5-0003uK-OF
	for bitbake-devel@lists.openembedded.org;
	Thu, 02 Jun 2011 02:09:57 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 01 Jun 2011 17:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,305,1304319600"; d="scan'208";a="12256441"
Received: from unknown (HELO [10.255.13.103]) ([10.255.13.103])
	by fmsmga001.fm.intel.com with ESMTP; 01 Jun 2011 17:05:25 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 01 Jun 2011 17:05:20 -0700
X-Mailer: Evolution 3.0.1 (3.0.1-1.fc15) 
Message-ID: <1306973125.2240.18.camel@scimitar>
Mime-Version: 1.0
Cc: poky <poky@yoctoproject.org>
Subject: [RFC] BitBake GUI work, the state of things
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 02 Jun 2011 00:09:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi all,

I've been plugging away at a GUI to pilot BitBake with and think that
now would be a reasonable time to solicit some feedback on the 'design'.

(There's a copy of this emails contents with inline screenshots at:
https://wiki.yoctoproject.org/wiki/BitBake/GUI/CurrentState)

The purpose of the tool is to allow the user to create and build a
custom image as well as enabling parameters of the build to be
configured.

Here's a screenshot:

https://wiki.yoctoproject.org/wiki/File:Screenshot-yHob-240511.png

I've tried to apply the principle of least surprise and tried to make
the app fit in on a Gnome desktop by following their HIG. One possibly
unexpected outcome of this is that you modify Preferences which equate
to values in local.conf

https://wiki.yoctoproject.org/wiki/File:Screenshot-Preferences.png

There are several issues with the GUI as is that I will be working on
next, as well as some extra features that I am intending to implement in
the coming weeks.

Issues:
* I wanted to allow users to store recipes for their newly created
images on disk and buildFile didn't seem to work as expected (only
building the rootfs of the image and complaining when packages where
missing, rather than building all dependencies then the rootfs) so I
hacked a temporary alternative entry point to the program
bitbake-commander (I know we have a program using this name already,
which is fine because I don't want this entry point to last).

I want to remove this entry point but first need to figure out a way to
be able to modify layers and re-parse with the new layers' contents.
Hacking in this entry point enabled me to remain focused on the actual
GUI whilst I worked out interaction models.

This entry points shows a "workspace selector" dialog (like Eclipse's)
and once the user selects/creates a workspace layer it is added to the
bblayers.conf file and BitBake is then started.

https://wiki.yoctoproject.org/wiki/File:Hob-workspace-selector.png

* In a similar vein I implemented a layer editor which helps the user
set up bblayers.conf, however the layer parsing and setting of BBPATH,
etc is done really early in the cooker initialisation. I need to work
out a clean way to allow modifying the bblayers.conf and having those
changes reflected in the UI without having to restart the GUI (i.e:
triggering a re-parse of the metadata).

https://wiki.yoctoproject.org/wiki/File:Screenshot-Layers.png

* I was hoping I'd just be able to create files and use the buildFile
command to build the image rather than having the workspace layer but as
mentioned above calling the buildFile command didn't seem to handle
building the images contents, instead the build would just go straight
to rootfs generation and bail with missing packages.
Furthermore I think using buildTargets is the right solution so that the
user can build a cross toolchain and rootfs from the same GUI.

I'm aware that the coding style is all over, I had started out carryin
on with the gtk+ coding style of the other files in lib/bb/ui/crumbs but
I think I will end up switching the coding style of everything in
lib/bb/ui to be consistent with the rest of BitBake.

Feedback, particularly on the areas above marked as issues, is extremely
welcome.

I'm trying to keep an up-to-date To Do list at:
https://wiki.yoctoproject.org/wiki/BitBake/GUI/PostOneOh

I've also started to track possible future GUI work:
https://wiki.yoctoproject.org/wiki/BitBake/GUI/Future

The current state of the code is in my josh/hob branch on poky-contrib:
http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=josh/hob
(
Being more explicit the patch with HACK HACK HACK as the subject is one
I'm not at all happy with and the patch with WIP WIP WIP as the subject
is one which certainly needs more work.)

There's even a Yocto bugzilla component for the 'image creator':
http://bugzilla.yoctoproject.org/buglist.cgi?product=Build%
20System&component=image%20creator&resolution=---

The GUI is probably not yet useful enough for day-to-day use, there's a
particularly irritating bug I've introduced whereby clicking to remove
something form the images contents removes *everything* - this is high
on my list of things to work on.

Regards,
Joshua
-- 
Joshua Lock
        Yocto Build System Monkey
        Intel Open Source Technology Centre



