Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SzWkz-0005Gm-15
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Aug 2012 19:42:49 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 09 Aug 2012 10:30:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,741,1336374000"; d="scan'208";a="178077803"
Received: from unknown (HELO helios.localnet) ([10.252.121.69])
	by orsmga001.jf.intel.com with ESMTP; 09 Aug 2012 10:30:58 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Peter Seebach <peter.seebach@windriver.com>
Date: Thu, 09 Aug 2012 18:30:57 +0100
Message-ID: <1356576.1YqSGvrhCQ@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9 (Linux/3.2.0-27-generic-pae; KDE/4.9.0; i686; ; )
In-Reply-To: <9005aeb8b41113f05121842055434fdeeda8c63c.1344467794.git.peter.seebach@windriver.com>
References: <cover.1344467794.git.peter.seebach@windriver.com>
	<9005aeb8b41113f05121842055434fdeeda8c63c.1344467794.git.peter.seebach@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] cooker.py: Remove explicit build targets from the ignored list
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
X-List-Received-Date: Thu, 09 Aug 2012 17:42:49 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 08 August 2012 18:19:42 Peter Seebach wrote:
> If something is in ASSUMED_PROVIDED, and a user tries to build it
> explicitly, Nothing Happens. Bitbake just says it ran 0 out of 0
> tasks. No diagnostics or explanations are offered.
> 
> In practice, the right thing is probably to assume that explicit
> targets are intentional. So far as I can tell, cooker.buildTargets
> is called only from the command line or from command.py, and both
> cases seem to be explicit user actions.

I'd rather we not change it to behave this way - the better approach would 
seem to me to be to just print a warning that the requested target is in 
ASSUME_PROVIDED and then not do anything else; if the user really wants to 
build the thing they can just remove it from ASSUME_PROVIDED.

If there is a genuine need to be able to force an item in ASSUME_PROVIDED to 
be built I'd probably want to hear a bit more background.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


