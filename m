Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SWz0e-0006EQ-IX
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 02:01:00 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 22 May 2012 16:50:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="146502694"
Received: from unknown (HELO helios.localnet) ([10.252.120.180])
	by azsmga001.ch.intel.com with ESMTP; 22 May 2012 16:50:49 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Wed, 23 May 2012 00:50:48 +0100
Message-ID: <1486170.3Ec8bBqrfQ@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.2 (Linux/3.2.0-24-generic-pae; KDE/4.8.2; i686; ; )
In-Reply-To: <4FBC2513.4090607@windriver.com>
References: <cover.1337728949.git.paul.eggleton@linux.intel.com>
	<470bb8bf282b2fa038947bd81a3b48d9b18607c8.1337728949.git.paul.eggleton@linux.intel.com>
	<4FBC2513.4090607@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] bitbake: implement checksums for local files in SRC_URI
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
X-List-Received-Date: Wed, 23 May 2012 00:01:00 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 22 May 2012 18:45:23 you wrote:
> On 5/22/12 6:23 PM, Paul Eggleton wrote:
> > Gathers a list of paths to have checksums calculated at parse time, and
> > processes these when calculating task hashes. Checksums are cached with
> > the file's current mtime. Thus, changing any local file in SRC_URI will
> > now cause the do_fetch taskhash to change, thus forcing a rebuild.
> 
> Does the mtime change invalidate the checksum, or just cause the checksum to
> be re-interpreted?

The latter.

> The issue I see is that you share a ccache file with someone else, their
> files may simply have a different mtime on them.

I'm guessing s/ccache/sstate cache/ ?

This will be fine - only the checksum of the file contents goes into the sstate 
signature.

>  From reading the code below, I think the comment is just confusing me.  The
> checksum is computed and stored bases on a hash + mtime.  If the mtime
> changes, that will cause the system to recalculate the checksum, which may
> end up being the same.. (and if it is, no rebuild) right?

Correct.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


