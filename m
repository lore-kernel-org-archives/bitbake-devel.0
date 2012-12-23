Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TmrhL-0001E6-2w
	for bitbake-devel@lists.openembedded.org;
	Sun, 23 Dec 2012 20:58:59 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 23 Dec 2012 11:43:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,343,1355126400"; d="scan'208";a="184089571"
Received: from unknown (HELO helios.localnet) ([10.252.123.19])
	by AZSMGA002.ch.intel.com with ESMTP; 23 Dec 2012 11:43:02 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Bob Cochran <openembedded@mindchasers.com>
Date: Sun, 23 Dec 2012 19:43 +0000
Message-ID: <5680339.a2UlTKzCpO@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9.3 (Linux/3.5.0-21-generic; KDE/4.9.3; i686; ; )
In-Reply-To: <50D53C11.5030404@mindchasers.com>
References: <50D50E7A.6060201@mindchasers.com>
	<50D53C11.5030404@mindchasers.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: executable metadata not supported in bbappend files?
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
X-List-Received-Date: Sun, 23 Dec 2012 19:59:00 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 21 December 2012 23:50:25 Bob Cochran wrote:
> On 12/21/2012 08:35 PM, Bob Cochran wrote:
> > I just noticed that the current bitbake manual states in the "Defining
> > executable metadata" section that executable metadata is only supported
> > in .bb and .bbclass files, but I find that I can put (at least some
> > basic) tasks in .bbappend files, too.
> > 
> > Is this an oversight in the documentation, or are there gotchas adding
> > tasks to bbappend files that I haven't come across?  If it's the former,
> > I'll submit a patch.
>
> I see that bbappend isn't mentioned anywhere in the bitbake manual.
> That's a little confusing?

This is just an example of where the bitbake manual needs updating - bbappends 
weren't implemented when it was written. I believe the bitbake manual is being 
updated at the moment but I'm sure patches would still be welcome to extend it 
to mention bbappends in the appropriate places.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


