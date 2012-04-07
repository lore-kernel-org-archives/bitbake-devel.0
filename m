Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SGexu-0003sc-UL
	for bitbake-devel@lists.openembedded.org;
	Sun, 08 Apr 2012 01:22:43 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 07 Apr 2012 16:13:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="128290386"
Received: from unknown (HELO helios.localnet) ([10.252.123.252])
	by azsmga001.ch.intel.com with ESMTP; 07 Apr 2012 16:13:25 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Wang, Shane" <shane.wang@intel.com>
Date: Sun, 08 Apr 2012 00:13:23 +0100
Message-ID: <2067049.LazVmZAO5W@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.2 (Linux/3.0.0-17-generic-pae; KDE/4.8.2; i686; ; )
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23B15B7F@SHSMSX102.ccr.corp.intel.com>
References: <A25F549E4D43CD42B4C02DF47A1913230FCFCD6A@SHSMSX102.ccr.corp.intel.com>
	<A25F549E4D43CD42B4C02DF47A1913230FCFCF0F@SHSMSX102.ccr.corp.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23B15B7F@SHSMSX102.ccr.corp.intel.com>
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: hob2: make xterm automatically exit after qemu exits?
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
X-List-Received-Date: Sat, 07 Apr 2012 23:22:43 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 07 April 2012 06:50:48 Wang, Shane wrote:
> Cui, Dexuan wrote on 2012-04-06:
> > Why do we use /usr/bin/xterm here by hardcode?
> > Can we change it to matchbox-terminal? Or, can we use some kind of
> > algorithm to determine the available terminal?
> 
> Is matchbox-terminal the minimal terminal on Linux distributions, compared
> with xterm? If so, we can replace xterm with that. Yes, we can, feature
> enhancement.

I don't think we can replace it as xterm is much more likely to be available 
than matchbox-terminal on standard desktop distros, but for self-hosted-image 
purposes it ought to be trivial to make it use matchbox-terminal as a fallback 
if xterm is unavailable.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


