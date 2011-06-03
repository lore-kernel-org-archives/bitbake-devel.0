Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dvhart@linux.intel.com>) id 1QSMw0-00009P-BH
	for bitbake-devel@lists.openembedded.org;
	Fri, 03 Jun 2011 07:28:37 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 02 Jun 2011 22:24:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,313,1304319600"; 
   d="scan'208";a="6376562"
Received: from unknown (HELO [10.255.13.71]) ([10.255.13.71])
	by azsmga001.ch.intel.com with ESMTP; 02 Jun 2011 22:24:07 -0700
Message-ID: <4DE86FF7.30009@linux.intel.com>
Date: Thu, 02 Jun 2011 22:24:07 -0700
From: Darren Hart <dvhart@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: Joshua Lock <josh@linux.intel.com>
References: <1306973125.2240.18.camel@scimitar>
In-Reply-To: <1306973125.2240.18.camel@scimitar>
Cc: poky <poky@yoctoproject.org>, bitbake-devel@lists.openembedded.org
Subject: Re: [poky] [RFC] BitBake GUI work, the state of things
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
X-List-Received-Date: Fri, 03 Jun 2011 05:28:37 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



On 06/01/2011 05:05 PM, Joshua Lock wrote:
> Hi all,
> 
> I've been plugging away at a GUI to pilot BitBake with and think that
> now would be a reasonable time to solicit some feedback on the 'design'.
> 
> (There's a copy of this emails contents with inline screenshots at:
> https://wiki.yoctoproject.org/wiki/BitBake/GUI/CurrentState)
> 
> The purpose of the tool is to allow the user to create and build a
> custom image as well as enabling parameters of the build to be
> configured.
> 
> Here's a screenshot:
> 
> https://wiki.yoctoproject.org/wiki/File:Screenshot-yHob-240511.png


Does it harvest all known machines from the configured layers? Assuming
so, but thought I'd check as it hadn't come up in our previous discussions.


> 
> I've tried to apply the principle of least surprise and tried to make
> the app fit in on a Gnome desktop by following their HIG. One possibly
> unexpected outcome of this is that you modify Preferences which equate
> to values in local.conf


It seems to me this might be less surprising if the tools was presented
as an image "configurator" as opposed to an image builder. I'm not
arguing for a name change here, but something to consider about how the
tool is perceived. The assisted configuration is where this tool is the
most valuable in my opinion, the building part is mostly just eye candy.


> 
> https://wiki.yoctoproject.org/wiki/File:Screenshot-Preferences.png


Is "Exclude GPLv3 packages" the only license related option of significance?


> 
> There are several issues with the GUI as is that I will be working on
> next, as well as some extra features that I am intending to implement in
> the coming weeks.
> 
> Issues:
> * I wanted to allow users to store recipes for their newly created
> images on disk and buildFile didn't seem to work as expected (only
> building the rootfs of the image and complaining when packages where
> missing, rather than building all dependencies then the rootfs) so I
> hacked a temporary alternative entry point to the program
> bitbake-commander (I know we have a program using this name already,
> which is fine because I don't want this entry point to last).
> 
> I want to remove this entry point but first need to figure out a way to
> be able to modify layers and re-parse with the new layers' contents.
> Hacking in this entry point enabled me to remain focused on the actual
> GUI whilst I worked out interaction models.
> 
> This entry points shows a "workspace selector" dialog (like Eclipse's)
> and once the user selects/creates a workspace layer it is added to the
> bblayers.conf file and BitBake is then started.
> 
> https://wiki.yoctoproject.org/wiki/File:Hob-workspace-selector.png
> 


In my workflow, the build area is also a key part of my "workspace". I
keep one for each permutation of
(bernard|master)*(n450|beagleboard|qemux86|...). I find I run into fewer
issues this way. I share downloads and may eventually share sstate as I
learn how to work with it and not just periodically delete it ;-)

The point being that if the concept of "Workspace" also included the
build directory, then the changes to local.conf and bblayers.conf
wouldn't be any surprise to the user at all. Having a configurable build
directory is pretty important for performance reasons as well where you
may have a RAID0 array for your build partition and don't want to use
./build.

It's certainly usable as is, but it could reach a broader audience if
the concept of workspace were to include the build dir.


> * In a similar vein I implemented a layer editor which helps the user
> set up bblayers.conf, however the layer parsing and setting of BBPATH,
> etc is done really early in the cooker initialisation. I need to work
> out a clean way to allow modifying the bblayers.conf and having those
> changes reflected in the UI without having to restart the GUI (i.e:
> triggering a re-parse of the metadata).
> 
> https://wiki.yoctoproject.org/wiki/File:Screenshot-Layers.png
> 


I really like this bit. It just occurred to me though that it would be
nice to be able to adjust the priority of these layers, and then resort
the rows accordingly. Unfortunatley, that really involves changing the
layer config file, which should probably be off limits to this tool for
layers it isn't creating... maybe... hrm. Something to consider anyway.


> * I was hoping I'd just be able to create files and use the buildFile
> command to build the image rather than having the workspace layer but as
> mentioned above calling the buildFile command didn't seem to handle
> building the images contents, instead the build would just go straight
> to rootfs generation and bail with missing packages.
> Furthermore I think using buildTargets is the right solution so that the
> user can build a cross toolchain and rootfs from the same GUI.
> 
> I'm aware that the coding style is all over, I had started out carryin
> on with the gtk+ coding style of the other files in lib/bb/ui/crumbs but
> I think I will end up switching the coding style of everything in
> lib/bb/ui to be consistent with the rest of BitBake.
> 
> Feedback, particularly on the areas above marked as issues, is extremely
> welcome.
> 
> I'm trying to keep an up-to-date To Do list at:
> https://wiki.yoctoproject.org/wiki/BitBake/GUI/PostOneOh
> 
> I've also started to track possible future GUI work:
> https://wiki.yoctoproject.org/wiki/BitBake/GUI/Future
> 
> The current state of the code is in my josh/hob branch on poky-contrib:
> http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=josh/hob
> (
> Being more explicit the patch with HACK HACK HACK as the subject is one
> I'm not at all happy with and the patch with WIP WIP WIP as the subject
> is one which certainly needs more work.)
> 
> There's even a Yocto bugzilla component for the 'image creator':
> http://bugzilla.yoctoproject.org/buglist.cgi?product=Build%
> 20System&component=image%20creator&resolution=---
> 
> The GUI is probably not yet useful enough for day-to-day use, there's a
> particularly irritating bug I've introduced whereby clicking to remove
> something form the images contents removes *everything* - this is high
> on my list of things to work on.
> 
> Regards,
> Joshua

Really coming along and looking great.

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel


