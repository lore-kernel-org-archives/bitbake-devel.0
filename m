Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBMV9-0007fz-C3
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 09:39:07 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 24 Mar 2012 01:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124566373"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 24 Mar 2012 01:30:08 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>
In-Reply-To: <20120324091905.0a64617b@eb-e6520>
References: <20120322122219.0df320be@eb-e6520>
	<20120323091314.5b5d00a0@eb-e6520>
	<1332503125.1849.0.camel@dongxiao-osel>
	<1332556685.1849.29.camel@dongxiao-osel>
	<20120324091905.0a64617b@eb-e6520>
Date: Sat, 24 Mar 2012 16:27:57 +0800
Message-ID: <1332577677.1849.36.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Hob : IndexError: list index out of range
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
X-List-Received-Date: Sat, 24 Mar 2012 08:39:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

I have send out a patch in my previous pull request [Patch 8/8] to
address this issue. You can have a try of that after it is checked into
master.

Thanks,
Dongxiao

On Sat, 2012-03-24 at 09:19 +0100, Eric Bénard wrote:
> Le Sat, 24 Mar 2012 10:38:05 +0800,
> "Xu, Dongxiao" <dongxiao.xu@intel.com> a écrit :
> 
> > I can reproduce it locally, thanks for reporting it.
> > 
> reported here :
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=2169
> 
> Eric




