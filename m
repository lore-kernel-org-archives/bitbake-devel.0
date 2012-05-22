Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SWz6U-0006HV-1e
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 02:07:02 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 22 May 2012 16:55:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="143525395"
Received: from unknown (HELO helios.localnet) ([10.252.120.180])
	by orsmga001.jf.intel.com with ESMTP; 22 May 2012 16:55:46 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Wed, 23 May 2012 00:55:45 +0100
Message-ID: <5052782.3c2ltfUpqO@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.2 (Linux/3.2.0-24-generic-pae; KDE/4.8.2; i686; ; )
In-Reply-To: <1486170.3Ec8bBqrfQ@helios>
References: <cover.1337728949.git.paul.eggleton@linux.intel.com>
	<4FBC2513.4090607@windriver.com> <1486170.3Ec8bBqrfQ@helios>
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
X-List-Received-Date: Wed, 23 May 2012 00:07:02 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 23 May 2012 00:50:48 Paul Eggleton wrote:
> On Tuesday 22 May 2012 18:45:23 you wrote:
> > On 5/22/12 6:23 PM, Paul Eggleton wrote:
> > > Gathers a list of paths to have checksums calculated at parse time, and
> > > processes these when calculating task hashes. Checksums are cached with
> > > the file's current mtime. Thus, changing any local file in SRC_URI will
> > > now cause the do_fetch taskhash to change, thus forcing a rebuild.
> > 
> > Does the mtime change invalidate the checksum, or just cause the checksum
> > to be re-interpreted?
> 
> The latter.

Er, I think I may have misread your question. To be totally clear - the mtime 
is not a component of the checksum; we merely store it next to the checksum in 
a cache so that we don't have to re-compute the checksum if the file hasn't 
been modified. If mtime changes but the file content does not, the checksum will 
be re-computed but will not change.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


