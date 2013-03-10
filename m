Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1UEnIZ-0007Ry-1m
	for bitbake-devel@lists.openembedded.org;
	Sun, 10 Mar 2013 21:56:57 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 10 Mar 2013 13:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,819,1355126400"; d="scan'208";a="212317191"
Received: from unknown (HELO helios.localnet) ([10.255.13.12])
	by AZSMGA002.ch.intel.com with ESMTP; 10 Mar 2013 13:39:07 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Chris Larson <clarson@kergoth.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Sun, 10 Mar 2013 20:39:07 +0000
Message-ID: <2406047.qZssv5BGAg@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.1 (Linux/3.5.0-25-generic; KDE/4.10.1; i686; ; )
In-Reply-To: <CABcZANmT5Z6B=PoD9k06aqFq08nzDjUt9DYkBUwdgSTFLKM+6w@mail.gmail.com>
References: <1362833241.9443.208.camel@ted>
	<CABcZANmT5Z6B=PoD9k06aqFq08nzDjUt9DYkBUwdgSTFLKM+6w@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] data_smart: Add _remove operator
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
X-List-Received-Date: Sun, 10 Mar 2013 20:56:58 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 09 March 2013 16:20:10 Chris Larson wrote:
> On Sat, Mar 9, 2013 at 5:47 AM, Richard Purdie <
> 
> richard.purdie@linuxfoundation.org> wrote:
> > There are long standing complaints about the fact its very difficult
> > to remove a portion of a variable. The immediate request is for a -=
> > and =- operator. The trouble is that += and =+ are "immediate"
> > operators and are applied straight away. Most people would expect
> > -= and =- to be deferred to have the effect most people desire and
> > therefore implementing -= and =- would just make the situation more
> > confusing.
> > 
> > This deferred operation is much more similar to the override syntax
> > which happens at data store finalisation. The _remove operator is
> > therefore in keeping with the _append and _prepend operations.
> > 
> > This code is loosely based on a patch from Peter Seebach although it
> > has been rewritten to be simpler, more efficient and avoid some
> > potential bugs.
> 
> This is a nice idea, though I'm slightly concerned about the naive
> implementation (use of str.replace). Without it being either word-based
> (limits flexibility to optimize for the common case) or regex-based (more
> complex), we may be greatly limiting the usefulness. I wouldn't want to try
> to remove a word from DISTRO_FEATURES and end up removing part of a word,
> for example.

I can't recall if we've discussed this before, but shouldn't we be looking at 
introducing some understanding of list type variables into BitBake itself? If 
BitBake knew the variable was a list it would be possible to have language 
elements that understood how to behave in this situation.

(I've been thinking about this for a while. It could also help to implement 
better dependencies on values of list variables, to only rebuild what's really 
necessary when DISTRO_FEATURES changes for example).

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


