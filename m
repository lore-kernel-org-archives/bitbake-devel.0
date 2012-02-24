Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S0lGH-0002HT-6w
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Feb 2012 03:51:57 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 23 Feb 2012 18:42:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="128863436"
Received: from unknown (HELO [10.255.15.55]) ([10.255.15.55])
	by fmsmga002.fm.intel.com with ESMTP; 23 Feb 2012 18:42:29 -0800
Message-ID: <4F46F915.5010705@linux.intel.com>
Date: Thu, 23 Feb 2012 18:42:29 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1330004101.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1330004101.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 0/1][PULL] Hob2: A new implementation for Human Oriented Builder
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
X-List-Received-Date: Fri, 24 Feb 2012 02:51:57 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 23/02/12 05:48, Dongxiao Xu wrote:
> Hi Richard,
>
> This pull request is a new implementation for Human Oriented Builder, please help to review and pull.

Please, let's not call it the Human Oriented Builder. It was always just 
Hob, not HOB - are we changing that now?

> Changes from previous pull requests:
>   - Re-implemented a lot of code according to Belen's new GUI design.

This is really hard to review as a several thousand line patch... It's 
difficult to know where what seems like an odd decision in the code was 
made for a sane reason without any git history or code comments to 
follow the logic of the development.

The fact that the patch was rejected by the mailing list is a good 
indication that we need to separate into smaller logical commits.

I could review coding style, but that is probably pretty useless at this 
point and so  offer somewhat superficial comments below regarding UI 
implementation with Gtk+.

First things first, I can't run the BitBake in the submitted branch:

joshual@shamshir:~/Projects/Yocto/poky/build [master *]
$ ../bitbake/bin/bitbake -u hob

Traceback (most recent call last):
   File "../bitbake/bin/bitbake", line 258, in <module>
     ret = main()
   File "../bitbake/bin/bitbake", line 178, in main
     ui_main = get_ui(configuration)
   File "../bitbake/bin/bitbake", line 68, in get_ui
     module = __import__("bb.ui", fromlist = [interface])
   File "../bitbake/lib/bb/ui/hob.py", line 33, in <module>
     from bb.ui.crumbs.hoblistmodel import RecipeListModel, PackageListModel

I found and ran a recent poky-contrib branch for Hob, though I've no 
idea if it reflects what's in this patch, just so that I had something 
to look at and offer feedback on.

The Build environment tab of the settings dialogue doesn't fit in the 
allocated space - I had to resize the dialogue to see Save and Cancel 
buttons. This is also true of the Others tab though less so.
These buttons don't follow the GNOME HIG in several ways, perhaps this 
is intentional?

It's also worth noting that the visual style 'leaks' in the Settings 
dialogue and I see standard Gtk light-bulb info icons rather than the 
steely i displayed on the main page.

The 'Package list may be incomplete' dialogue is a very nice piece of 
functionality but interface-wise I'd expect to see the buttons labelled 
along the lines of 'Get full list' 'View existing'.

It seems like the Stop Build tracking isn't consistently reset between 
builds so when I was playing around started & stopped a build then 
played some more and started another build and tried to stop it I only 
had the option to Force Stop or Cancel...

Taking a look at the code the first thing I notice is multiples of 5 for 
spacing, why is that? I thought we'd agreed with Belen that we'd follow 
the GNOME HIG for consistent visuals amongst Gtk+ apps?
Further, there are still hard-coded colour values. Are these issues on 
the "to fix later" list?

I'm not suggesting these hold up merging - just asking the question. I 
can play HIG zealot and write a patch once this is merged? I think it's 
important we present a professional GUI which matches the visuals of the 
host OS.

The buttons that act like tabs for changing between notebook pages (i.e. 
on the 'Package Selection' view) took me a long time to figure out as 
they look like they are depressed (mid-click) buttons for the inactive 
tabs and ready to click buttons for the active tabs - confusing visual.

There's at least one instance of commented out code (a signal handler 
connection in builder.py) - we can probably drop those, right?

Setting the size and position of windows on each launch (as in 
builder.py) is generally considered to be hostile to users - it should 
be sufficient to start with a sane default size and then as the UI 
allows the user to resize it we should remember the size for the next 
launch.

This UI has come on leaps and bounds and I look forward to seeing this 
foundation polished over the coming weeks. Maybe I can even submit some 
changes myself.

Hopefully this splash of feedback gives you something to work with...

Cheers,
Joshua
-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


