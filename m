Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S9bPp-0006Yb-6i
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 13:10:21 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 19 Mar 2012 05:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="141146782"
Received: from unknown (HELO helios.localnet) ([10.252.123.198])
	by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2012 05:01:28 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Mon, 19 Mar 2012 12:01:27 +0000
Message-ID: <1927112.bGsHOkriYo@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.0 (Linux/3.0.0-16-generic-pae; KDE/4.8.1; i686; ; )
In-Reply-To: <alpine.DEB.2.02.1203190741220.22293@oneiric>
References: <alpine.DEB.2.02.1203190741220.22293@oneiric>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: some preliminary questions about bitbake manual
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
X-List-Received-Date: Mon, 19 Mar 2012 12:10:21 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 19 March 2012 07:49:59 Robert P. J. Day wrote:
>   i'm about to write some tutorials on OE/bitbake/poky/yocto (from a
> position of moderate ignorance, hoping that will change), so a couple
> questions/observations before i get started.
> 
>   at risk of repetition, i already noted that if you google on
> "bitbake user manual", you end up here:
> 
>   http://bitbake.berlios.de/manual/
> 
> which is *way* out of date, so perhaps a link to something newer would
> be useful.

Yes, we acknowledge it is quite out of date. The problem with the BitBake 
manual is it must cover only BitBake generically, and not OE. Of course 
there's a lot that could be added to it, but having complete documentation 
there is less important than documenting OE. That's not to say we won't 
welcome patches though ;)

>   next, is it fair to say that the current version of the bitbake
> manual is the one that's part of bitbake itself, in the doc/
> directory?  so if i want to submit some patches, i'd post them to this
> list and those patches would always be relative to my current "git
> pull" of bitbake?

Yes, that's correct.
 
>   finally (for now), over at yocto, here's a quick tutorial on getting
> started with oe-core:
> 
>   https://wiki.yoctoproject.org/wiki/OpenEmbedded-Core
> 
> it all looks reasonable but what you end up with in the oe-core
> directory is two "bitbake.conf" files:
> 
> $ find . -name bitbake.conf
> ./meta/conf/bitbake.conf
> ./bitbake/conf/bitbake.conf
> $
> 
>   i'm assuming that's by design and there are no weird conflicts
> between the two files, right?

Sort of - the last one is actually an example config and since it never ends up 
in BBPATH it will never be used. Now that you mention it, Richard mentioned to 
me recently that it should probably be renamed to bitbake.conf.sample to avoid 
confusion.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


