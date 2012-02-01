Received: from vms173007pub.verizon.net ([206.46.173.7])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <denis@denix.org>)
	id 1Rsi1Y-0007UB-Ib; Wed, 01 Feb 2012 22:47:28 +0100
Received: from gandalf.denix.org ([unknown] [71.178.225.66])
	by vms173007.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009))
	with ESMTPA id <0LYQ00ACHEP5QNQ1@vms173007.mailsrvcs.net>; Wed,
	01 Feb 2012 14:39:06 -0600 (CST)
Received: by gandalf.denix.org (Postfix, from userid 1000)	id CFC1320137; Wed,
	01 Feb 2012 15:39:05 -0500 (EST)
Date: Wed, 01 Feb 2012 15:39:05 -0500
From: Denys Dmytriyenko <denis@denix.org>
To: Martin Jansa <martin.jansa@gmail.com>
Message-id: <20120201203905.GB11070@denix.org>
References: <CAMKF1so7zfZSiGq+txWdBkONMtMi8iKRhqV_TOPt3FV3fTTEpQ@mail.gmail.com>
	<CAEsOVNekW4Zo6YRHyNCTMJ_GsgrzaOE8QvWr70tRNAZQNokcig@mail.gmail.com>
	<CAP9ODKo5EQEWr2CU9uQdz6mXKPJfN6zhbSkTcC01k8rU2D4kQg@mail.gmail.com>
	<CAEsOVNeh8GTOcU+jF1jxs1FJTi84vq0_AVX9osvU1R83gzq2nA@mail.gmail.com>
	<CAMKF1sqkdApUR9YPamhtxtUHoanHZ5Sxp8ggUnp8PS0v_qPPgg@mail.gmail.com>
	<20120201181909.GC6969@jama.jama.net>
MIME-version: 1.0
In-reply-to: <20120201181909.GC6969@jama.jama.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] should we switch off patchwork for oe-core and bitbake projects
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
X-List-Received-Date: Wed, 01 Feb 2012 21:47:28 -0000
Content-type: text/plain; charset=us-ascii
Content-disposition: inline

On Wed, Feb 01, 2012 at 07:19:09PM +0100, Martin Jansa wrote:
> On Wed, Feb 01, 2012 at 10:07:14AM -0800, Khem Raj wrote:
> > On Wed, Feb 1, 2012 at 9:51 AM, McClintock Matthew-B29882
> > <B29882@freescale.com> wrote:
> > > I'm saying leave it there even if its not maintained. I can still go search
> > > for patches sent by me or other specific people.
> > 
> > thats what mailing list archives are for.
> 
> is there something like
> oe/contrib/patchwork/pw-am.sh
> for some mailing list archive?
> 
> When I see some interesting patch in ML, easiest way for me to get it to
> development branch is to open patchwork web (from any computer) and then
> call pw-am.sh NUMBER in screen session on my development workstation.
> 
> Even when reading mail in mutt on the same machine it's easier for me to
> use pw-am.sh to get that patch to my chroot for OE builds.
> 
> And that git hook marking them as applied works very well.. so usually I
> just have to mark cover letters as applied.

I'd vote for keeping patchworks as well - there are rare patches submitted to 
oe-core w/o corresponding pull requests...

-- 
Denys


