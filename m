Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>)
	id 1R9gmm-0007Qk-EA; Fri, 30 Sep 2011 19:22:09 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 30 Sep 2011 10:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,468,1312182000"; d="scan'208";a="22213476"
Received: from unknown (HELO [10.255.15.62]) ([10.255.15.62])
	by AZSMGA002.ch.intel.com with ESMTP; 30 Sep 2011 10:16:37 -0700
From: Joshua Lock <josh@linux.intel.com>
To: Koen Kooi <koen@dominion.thruhere.net>
Date: Fri, 30 Sep 2011 10:16:32 -0700
In-Reply-To: <689D3FDE-CD3B-48CE-9426-AE59008C0609@dominion.thruhere.net>
References: <4E85D3E0.7070807@intel.com> <1317397804.11645.7.camel@scimitar>
	<689D3FDE-CD3B-48CE-9426-AE59008C0609@dominion.thruhere.net>
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Message-ID: <1317402997.11645.13.camel@scimitar>
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
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
X-List-Received-Date: Fri, 30 Sep 2011 17:22:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-09-30 at 11:32 -0500, Koen Kooi wrote:
> 
> Op 30 sep. 2011 om 10:49 heeft Joshua Lock <josh@linux.intel.com> het volgende geschreven:
> 
> > On Fri, 2011-09-30 at 08:36 -0600, Yu, Ke wrote:
> >> Hi,
> >> 
> >> As you may already know, a new GUI has been added to bitbake recently, 
> >> i.e. HOB (Human Oriented Builder). 
> > 
> > It's not an acronym, it's just a name - Hob.
> > 
> >> It is a graphical image creator that 
> >> allows user to freely choose which packages to be built in the image. 
> >> The wiki https://wiki.yoctoproject.org/wiki/BitBake/GUI/Hob  has more 
> >> detail.
> > 
> > I'll be changing this page and adding more user-centric info in the
> > coming weeks.
> > 
> >> This email is to collect your feedback on the HOB. Current HOB is our 
> >> first version, and it surely has many place to improve. We has the plan 
> >> to enhance it in Yocto 1.2. So we really hope that you can use it and 
> >> provide your valuable feedback . We do think user's feedback/requirement 
> >> is the right way to go. Looking forward your valuable input.
> >> 
> >> Best Regards
> >> Ke
> >> 
> >> Ps. The simple way to run hob is:
> >> # touch conf/hob-pre.conf conf/hob-post.conf
> >> # bitbake -u hob -r conf/hob-pre.conf -R conf/hob-post.conf
> > 
> > In oe-core (and therefore Poky) we have a wrapper script so from an
> > oe-init-build-env'd build directory you can just call hob.
> > 
> > The script will create the required configuration files with some
> > required values.
> 
> Can we have it use local.conf by default please? I hate having to put the same info in multiple places

We do use local.conf in that if values are set there and not in either
of the hob configuration files the values from local.conf are used
however I had an explicit feature request to not modify local.conf.

I actually started looking at having Hob use an independent
configuration file so that Hob settings would persist across build
directories, this didn't make it in the 1.1 time frame unfortunately.

Cheers,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



