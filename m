Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S1p1O-0007uB-4Z
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 02:04:58 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 26 Feb 2012 16:56:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="115096583"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 26 Feb 2012 16:56:31 -0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1330107431.9617.6.camel@ted>
References: <cover.1330004101.git.dongxiao.xu@intel.com>
	<1330107431.9617.6.camel@ted>
Date: Mon, 27 Feb 2012 08:54:46 +0800
Message-ID: <1330304086.7571.15.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Mon, 27 Feb 2012 01:04:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-02-24 at 18:17 +0000, Richard Purdie wrote:
> On Thu, 2012-02-23 at 21:48 +0800, Dongxiao Xu wrote:
> > Hi Richard,
> > 
> > This pull request is a new implementation for Human Oriented Builder, please help to review and pull.
> > 
> > Changes from previous pull requests:
> >  - Re-implemented a lot of code according to Belen's new GUI design.
> > 
> > Note that this pull request depends on the following pull requests:
> >  - hob2-bitbake-changes
> >  - hob2-oecore-changes
> > 
> > Thanks,
> > Dongxiao
> > 
> > 
> > The following changes since commit cec8b6e6c33582be660dd35c6050efc3f28e6baa:
> > 
> >   runqueue: fire sceneQueueTaskStarted event when a setscene queue starts (2012-02-23 21:04:49 +0800)
> > 
> > are available in the git repository at:
> >   git://git.pokylinux.org/poky-contrib dxu4/hob2
> >   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob2
> > 
> > Dongxiao Xu (1):
> >   Hob: A new implemetation for Human Oriented Builder
> 
> I just merged this branch however there are some things I need to make
> clear, particularly why I've done it and why this should never happen
> again.
> 
> Having everything as one huge monster patch effectively means its
> impossible to review. I've taken it since it would probably take weeks
> to split into changesets and I'm not sure that would be productive work.
> At least if its in master, people can test it out and send
> patches/incremental improvements from now on so I have taken it on this
> basis. I want to make it clear this is a one time exception and isn't
> going to be acceptable in future.
> 
> Secondly, I merged the patch but didn't realise it was corrupt, some
> files had the prefix "bitbake/" and some did not. I've corrected this
> but it caused me quite a bit of confusion.
> 
> Joshua's reply in this thread also has some valid questions I'd like to
> see answered. 
> 
> I'd also like to stress the Human Oriented Builder name needs to die
> (sorry Dave), I removed it from the commit message.
> 
> All the above isn't to say I don't love the progress we're making with
> the UI btw, we just also need to keep an eye on the housekeeping stuff
> too.

Thanks Richard, we will pay more attention to it.

Thanks,
Dongxiao

> 
> Cheers,
> 
> Richard
> 
> 




