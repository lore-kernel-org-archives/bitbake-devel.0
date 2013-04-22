Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1UUErK-0002x0-Js
	for bitbake-devel@lists.openembedded.org;
	Mon, 22 Apr 2013 13:24:35 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Apr 2013 04:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,526,1363158000"; d="scan'208";a="298915881"
Received: from unknown (HELO helios.localnet) ([10.255.13.204])
	by orsmga001.jf.intel.com with ESMTP; 22 Apr 2013 04:05:41 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Purcareata Bogdan-B43198 <B43198@freescale.com>
Date: Mon, 22 Apr 2013 12:05:38 +0100
Message-ID: <3109661.1Vn9mzWreB@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.2 (Linux/3.5.0-27-generic; KDE/4.10.2; i686; ; )
In-Reply-To: <E7E317BD5B5D764682EEAC13B01676E26731F2@039-SN2MPN1-023.039d.mgd.msft.net>
References: <E7E317BD5B5D764682EEAC13B01676E2650BB2@039-SN2MPN1-021.039d.mgd.msft.net>
	<1366443597.10502.140.camel@ted>
	<E7E317BD5B5D764682EEAC13B01676E26731F2@039-SN2MPN1-023.039d.mgd.msft.net>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake clean / cleanall / cleansstate not working
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
X-List-Received-Date: Mon, 22 Apr 2013 11:24:35 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 22 April 2013 09:42:07 Purcareata Bogdan-B43198 wrote:
> Richard Purdie wrote:
> > What exactly are you trying to clean? The above messages say it ran 1, 2
> > or 3 tasks and they all succeeded.
> 
> In my example, "gcc" can be replaced with any package provided by the Yocto
> recipes. The problem is that nothing is being run - "0 didn't need to be
> rerun " - so the built package is never cleaned. This issue is present when
> running all clean commands - clean, cleanall, cleansstate.

"0 didn't need to be rerun" does not mean nothing was done - it means the 
opposite. The number reported here is the number of tasks that were able to be 
restored from shared state - none (0) in this case because this is not 
applicable to the clean* tasks.

Other than the message above, how are you determining that these tasks are not 
doing anything?

> > Keep in mind there are several "gcc" components such as gcc-cross,
> > gcc-cross-initial and so on. "gcc" is the one used on target.
> 
> Do you think that a certain package can't be cleaned because of its
> dependencies?

No, that's very unlikely to be the case.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


