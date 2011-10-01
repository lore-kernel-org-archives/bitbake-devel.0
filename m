Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R9ngB-0007b3-IW
	for bitbake-devel@lists.openembedded.org;
	Sat, 01 Oct 2011 02:43:47 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 30 Sep 2011 17:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,470,1312182000"; d="scan'208";a="73112789"
Received: from unknown (HELO [10.255.15.62]) ([10.255.15.62])
	by fmsmga002.fm.intel.com with ESMTP; 30 Sep 2011 17:38:17 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Sep 2011 17:38:12 -0700
In-Reply-To: <33AB447FBD802F4E932063B962385B3512DAF448FC@shsmsx501.ccr.corp.intel.com>
References: <4E85D3E0.7070807@intel.com> <1317397804.11645.7.camel@scimitar>
	<689D3FDE-CD3B-48CE-9426-AE59008C0609@dominion.thruhere.net>
	<33AB447FBD802F4E932063B962385B3512DAF448FC@shsmsx501.ccr.corp.intel.com>
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Message-ID: <1317429497.11645.33.camel@scimitar>
Mime-Version: 1.0
Subject: Re: [OE-core] Feedback on HOB (new image creator GUI)
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
X-List-Received-Date: Sat, 01 Oct 2011 00:43:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2011-10-01 at 08:30 +0800, Yu, Ke wrote:
> > -----Original Message-----
> > From: Koen Kooi [mailto:koen@dominion.thruhere.net]
> > Sent: Saturday, October 01, 2011 12:33 AM
> > To: Patches and discussions about the oe-core layer
> > Cc: Yu, Ke; bitbake-devel@lists.openembedded.org; openembedded-core
> > Subject: Re: [OE-core] Feedback on HOB (new image creator GUI)
> > 
> > 
> > 
> > Op 30 sep. 2011 om 10:49 heeft Joshua Lock <josh@linux.intel.com> het
> > volgende geschreven:
> > 
> > > On Fri, 2011-09-30 at 08:36 -0600, Yu, Ke wrote:
> > >> Hi,
> > >>
> > >> As you may already know, a new GUI has been added to bitbake
> > >> recently, i.e. HOB (Human Oriented Builder).
> > >
> > > It's not an acronym, it's just a name - Hob.
> > >
> > >> It is a graphical image creator that allows user to freely choose
> > >> which packages to be built in the image.
> > >> The wiki https://wiki.yoctoproject.org/wiki/BitBake/GUI/Hob  has more
> > >> detail.
> > >
> > > I'll be changing this page and adding more user-centric info in the
> > > coming weeks.
> > >
> > >> This email is to collect your feedback on the HOB. Current HOB is our
> > >> first version, and it surely has many place to improve. We has the
> > >> plan to enhance it in Yocto 1.2. So we really hope that you can use
> > >> it and provide your valuable feedback . We do think user's
> > >> feedback/requirement is the right way to go. Looking forward your valuable
> > input.
> > >>
> > >> Best Regards
> > >> Ke
> > >>
> > >> Ps. The simple way to run hob is:
> > >> # touch conf/hob-pre.conf conf/hob-post.conf # bitbake -u hob -r
> > >> conf/hob-pre.conf -R conf/hob-post.conf
> > >
> > > In oe-core (and therefore Poky) we have a wrapper script so from an
> > > oe-init-build-env'd build directory you can just call hob.
> > >
> > > The script will create the required configuration files with some
> > > required values.
> > 
> > Can we have it use local.conf by default please? I hate having to put the same
> > info in multiple places
> 
> Yes, this is valid. We should be able to use local.conf as pre and post
> conf file, if they are not specified by user. Thanks for the input. I
> will add it to my plan.

I'm not sure we should promise that - the plan, per bug #1441 (and as
alluded to earlier) is to have the configuration be independent of
BitBake and persistent to the UI (i.e. hob configuration is the same
even if I launch it from a clean build dir).

This isn't a mandate but we should certainly weigh up the pro's and
con's of either side before we propose which one to implement.

http://bugzilla.pokylinux.org/show_bug.cgi?id=1441

Cheers,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



