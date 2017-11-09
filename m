Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id C90CD784E9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Nov 2017 03:48:24 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga105.jf.intel.com with ESMTP; 08 Nov 2017 19:48:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.44,367,1505804400"; d="scan'208";a="171430375"
Received: from skanwarx-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.73.22])
	by orsmga005.jf.intel.com with ESMTP; 08 Nov 2017 19:48:22 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Neal Gompa <ngompa13@gmail.com>
Date: Thu, 09 Nov 2017 16:48:19 +1300
Message-ID: <8732517.rS9bQnFJfK@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <CAEg-Je9okCK9dEaV9Ytk6SvyzcCT=LeViP5o53F7B4oL+eR0vw@mail.gmail.com>
References: <CAEg-Je9okCK9dEaV9Ytk6SvyzcCT=LeViP5o53F7B4oL+eR0vw@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Releases of BitBake to package for Fedora?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 09 Nov 2017 03:48:24 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Neal,

On Thursday, 9 November 2017 12:58:08 AM NZDT Neal Gompa wrote:
> I'm looking reintroduce BitBake into Fedora, but it seems like there
> hasn't been releases in two years. I also cannot identify anywhere
> that provides tarballs of BitBake to package.
> 
> The Fedora package previously referenced snapshot tarballs generated
> by tagged releases in OE Git, but there haven't been new tagged
> releases in two years.
> 
> I'd previously asked this on oe-core ML and was redirected to
> bitbake-devel, so apologies to cross-list subs. But it was also
> pointed out there that apparently BitBake has moved to a model where
> they don't have stable points of releases, which seems rather odd for
> a tool that is used by more than OpenEmbedded.

It's not that we don't have stable points - we do, it's that from the other 
side, each stable release of OE-Core is only tested with the corresponding 
stable release of BitBake, so if people start using BitBake from their distro 
we are probably going to have extra mismatch issues to deal with. We really 
ought to be tagging releases, not having done that is an oversight but it's 
reflective of the current typical usage.

It would be nice to get some exposure of BitBake as a standalone tool, and 
having it packaged by distros might be one way to help that, but my concern 
for OE usage would be that when this has been done in the past we have had 
situations where BitBake from the distro has been older than needed by OE-Core 
and users end up having to fetch it themselves anyway, so we'd have to have a 
strategy for handling that.

(This is not necessarily an official answer - I'd be interested to hear what 
RP and others have to say about it.)

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

