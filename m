Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T9cFD-00066b-H1
	for bitbake-devel@lists.openembedded.org;
	Thu, 06 Sep 2012 15:35:43 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 06 Sep 2012 06:23:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,380,1344236400"; d="scan'208";a="218566254"
Received: from unknown (HELO helios.localnet) ([10.252.121.173])
	by fmsmga002.fm.intel.com with ESMTP; 06 Sep 2012 06:22:57 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Baurzhan Ismagulov <ibr@radix50.net>
Date: Thu, 06 Sep 2012 14:22:56 +0100
Message-ID: <4900668.FanvGGHKG9@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9 (Linux/3.2.0-30-generic-pae; KDE/4.9.0; i686; ; )
In-Reply-To: <20120807212006.GC13756@radix50.net>
References: <20120807212006.GC13756@radix50.net>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake under msys
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
X-List-Received-Date: Thu, 06 Sep 2012 13:35:43 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 07 August 2012 23:20:08 Baurzhan Ismagulov wrote:
> I've tried to use bitbake under msys. First, I used python 2.6 for
> Windows; this failed due to import fcntl. Then I tried cygwin python;
> this failed with the following message:
> 
> ERROR: Unable to parse conf/bitbake.conf: file conf/bitbake.conf not
> found in c:/Data/home/ibr/src/hellobb/bb
> 
> Is there a combination that works under msys?

I'm not sure that this is supported. Patches to improve the situation might be 
accepted if they're not too invasive though.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


