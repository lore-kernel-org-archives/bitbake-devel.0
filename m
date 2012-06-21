Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Shhsy-0008FM-Pu
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 15:57:24 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 21 Jun 2012 06:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="156709333"
Received: from unknown (HELO helios.localnet) ([10.252.120.141])
	by orsmga001.jf.intel.com with ESMTP; 21 Jun 2012 06:46:36 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Thu, 21 Jun 2012 14:46:34 +0100
Message-ID: <10234534.IIAnCopgg5@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.3 (Linux/3.2.0-25-generic-pae; KDE/4.8.3; i686; ; )
In-Reply-To: <1340285156.1640.114.camel@ted>
References: <1340018907-8814-1-git-send-email-rep.dot.nop@gmail.com>
	<CAC1BbcSr8K79m6idqVvDDrYG1KxgrMEVwmDVb2KWZ8xrUC0Z9Q@mail.gmail.com>
	<1340285156.1640.114.camel@ted>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: do not try to checksum a socket
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
X-List-Received-Date: Thu, 21 Jun 2012 13:57:25 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 21 June 2012 14:25:56 Richard Purdie wrote:
> It will then attempt to checksum everything in a file:// url which is
> why it finds the socket and then fails. So your change does point at a
> potentially valid issue. Paul might have a better idea on which level we
> might want to fix this at?

Regarding the patch in question, I'm not opposed to a change to avoid errors 
like this, however it looks to me that if the file is missing the 
os.path.isfile() call will return false and bypass the warning that we 
currently show, which would not be desirable. I think it would need to do 
something like call os.stat() and then interpret the results, then we're just 
making one call.

> > Indeed, this was failing for me a couple of weeks ago with a similar
> > SRC_URI. Back then i could not use file:///mydir;protocol=git (i.e.
> > create a clone from a clone living on the local filesystem) so had to
> > resort back to protocol=rsync.
> > There was a socket lying around in that directory, a leftover from
> > some testsuite run.
> 
> FWIW, the url you want is git:///mydir;protocol=file which should work.
> As of the patches today, this also works as mirror syntax so you could
> even add this in local.conf as a PREMIRROR and leave the recipe
> pristine.

Also, if what you want is to have a local source directory you can modify for 
development purposes, you may find the recently added externalsrc.bbclass is 
helpful since that's what it was designed to handle. I guess it depends on 
what you're trying to achieve and what your workflow is.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


