Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SgyEz-00073B-Qh
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Jun 2012 15:13:06 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 19 Jun 2012 06:02:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="182128520"
Received: from unknown (HELO helios.localnet) ([10.252.120.167])
	by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2012 06:02:20 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Jason Wessel <jason.wessel@windriver.com>
Date: Tue, 19 Jun 2012 14:02:19 +0100
Message-ID: <28515527.frR1roArDb@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.3 (Linux/3.2.0-25-generic-pae; KDE/4.8.3; i686; ; )
In-Reply-To: <4FE065F9.6010300@windriver.com>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
	<4FE065F9.6010300@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Signature-based rebuild improvements
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
X-List-Received-Date: Tue, 19 Jun 2012 13:13:06 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 19 June 2012 06:43:53 Jason Wessel wrote:
> While the use cases described in the defect work, there is a new side
> effect.  The sstate dir starts to fill up with new sums for the what ever
> package you compile.  Perhaps this is some kind of trade off we have to
> live with, but I do thing it is worth discussing.
> 
> I start with a fully populated sstate.  I didn't make any code changes at
> all to any package, I just wanted to see the compile log from acl in this
> case.
> 
>     bitbake -f -c compile acl
>     bitbake acl

> The sstate sum is completely different due to the hash injection, but the
> code compiled for everything is the same.  There is probably no easy, cheap
> (as in cpu/wall time) way to have the best of both worlds.

Agreed, I think this is the simplest way to implement this feature in a way 
that the system remains consistent with shared state. Fortunately these days 
disk space is cheap, and there's always the sstate-cache-management.sh script 
in OE-Core/Poky which can help clean up the cache if buildup is a concern.

We could look at some code to try to clean up older files in the sstate cache 
on the fly, but I'd like to let the dust settle on some of these changes (and 
have a chance to work on some of the more pressing issues) before looking at 
that in detail if that's OK.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


