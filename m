Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1U8r4d-0006rE-7N
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Feb 2013 12:46:26 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 22 Feb 2013 03:28:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,715,1355126400"; d="scan'208";a="266176047"
Received: from unknown (HELO helios.localnet) ([10.252.120.142])
	by orsmga001.jf.intel.com with ESMTP; 22 Feb 2013 03:28:35 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Feb 2013 11:28:33 +0000
Message-ID: <1848600.mfyoAxLOA5@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10 (Linux/3.5.0-24-generic; KDE/4.10.0; i686; ; )
In-Reply-To: <CAKFDafUoMXKYr_xdabpNdfz+yJcBnWLunK6pTL2J5dspkQEr2w@mail.gmail.com>
References: <CAKFDafUoMXKYr_xdabpNdfz+yJcBnWLunK6pTL2J5dspkQEr2w@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: How to get additional binaries in tmp/deploy/images
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
X-List-Received-Date: Fri, 22 Feb 2013 11:46:32 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 21 February 2013 16:57:25 Pr Pe wrote:
> I have an image recipe (appending to core-image-minimal) that builds
> components specific to my project and I get a bzImage and a
> core-image-minimal.iso out of it. I want to add some bootloader code to be
> built as a separate entity  like bzImage and not as part of the
> core-image-minimal.iso. Is there a way to do this in yocto?

This is more of a question for the Yocto Project or OE mailing lists.

To answer your question though, with Poky/OE-Core you would add the items you 
wanted built alongside to EXTRA_IMAGEDEPENDS - see meta-yocto-
bsp/conf/machine/beagleboard.conf for an example.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


