Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S2Qiq-0008V5-Lg
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Feb 2012 18:20:20 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 28 Feb 2012 09:11:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="112701627"
Received: from unknown (HELO helios.localnet) ([10.252.123.68])
	by orsmga001.jf.intel.com with ESMTP; 28 Feb 2012 09:11:51 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: McClintock Matthew-B29882 <B29882@freescale.com>
Date: Tue, 28 Feb 2012 17:11:50 +0000
Message-ID: <2039899.xPofPYZzs0@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.0 (Linux/3.0.0-16-generic-pae; KDE/4.8.0; i686; ; )
In-Reply-To: <CAEsOVNcu_viCVVsoO9jg-eB9bA8GYBs33B4_7KYidqyuh9Ft8w@mail.gmail.com>
References: <cover.1330368761.git.paul.eggleton@linux.intel.com>
	<2548258.gq2qYr9CFK@helios>
	<CAEsOVNcu_viCVVsoO9jg-eB9bA8GYBs33B4_7KYidqyuh9Ft8w@mail.gmail.com>
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/2] bitbake: fix setscene task start/failure handling
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
X-List-Received-Date: Tue, 28 Feb 2012 17:20:20 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 28 February 2012 16:32:29 McClintock Matthew-B29882 wrote:
> I was referring to when the setscene tasks fails and we emit an ERROR
> when it's not really a fatal error as we can just rerun the real task.
> It's still an "issue" - but when I check my build logs for issues I
> grep for ERROR and I'd rather leave ERROR for FATAL ERRORS.

I agree and I'm happy to look at that as a separate issue if it is indeed 
still occurring in master; my immediate concern was not getting any message at 
all though.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


