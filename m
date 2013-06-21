Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id A420A601D6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jun 2013 17:03:51 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 21 Jun 2013 10:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,914,1363158000"; d="scan'208";a="320655489"
Received: from unknown (HELO helios.localnet) ([10.252.122.78])
	by azsmga001.ch.intel.com with ESMTP; 21 Jun 2013 10:03:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Bill Traynor <btraynor@gmail.com>
Date: Fri, 21 Jun 2013 18:03:49 +0100
Message-ID: <1608914.fljIic3iX6@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.3 (Linux/3.8.0-25-generic; KDE/4.10.3; i686; ; )
In-Reply-To: <CAN20qYpwykZ7bMwO3kOvm2hGjZ+ZM5QMa6XWTO6ckt6Km4WeNQ@mail.gmail.com>
References: <CAN20qYpYGS6huZ+MV8xTpJDyfwJR9mN6o=m5qKMwuJVEqFqf9A@mail.gmail.com>
	<CAN20qYpwykZ7bMwO3kOvm2hGjZ+ZM5QMa6XWTO6ckt6Km4WeNQ@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: User Manual: HelloWorld example questions.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 21 Jun 2013 17:03:51 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Bill,

On Friday 21 June 2013 11:40:27 Bill Traynor wrote:
> On Wed, Jun 19, 2013 at 9:51 AM, Bill Traynor <btraynor@gmail.com> wrote:
> > NOTE:  The following questions are posed within the context of the
> > BitBake User Manual rewrite.
> > 
> > In working through the following two HelloWorld examples:
> > 
> > http://www.mail-archive.com/yocto@yoctoproject.org/msg09379.html
> > http://hambedded.org/blog/2012/11/24/from-bitbake-hello-world-to-an-image/
> > 
> > there are some concepts that I don't quite understand.
> > 
> > 1.  The simplest HelloWorld possible would only require a recipe and
> > source, correct?  The concepts of Classes and Layers is beyond the
> > basics, is it not?  Or is the simplest of HelloWorld examples without
> > concepts such as Classes and Layers essentially pointless?
> 
> To answer myself as I work through my hello world project from first
> priciples, i.e. beginning with an empty directory and solving errors
> one by one I realize that the concept of Layers is necessary given
> that the first configuration file BitBake looks for is bblayers.conf,
> which is where I set BBPATH.

BitBake does implement most of the support for layers, yes, so as a concept it 
should be covered in the BitBake documentation. You may be able to bring in 
non-OE-specific portions of the Yocto Project manuals to help get started here.
 
> > 2.  Why isn't there a sample base.bbclass in the bitbake source tree?
> 
> Oops, I meant a sample bblayers.conf, NOT base.bbclass which does
> indeed exist.  Does it not make sense to have a bblayers.conf
> containing at minimum:
> 
> BBPATH := "${TOPDIR}"
> 
> Perhaps even comment out the latter with a short explanation of what
> un-commenting out implies?

I think maybe it ought to have both, since base.bbclass is directly referred 
to by bitbake and thus required. I do wonder if it ought to be made clearer 
that the bitbake.conf provided by bitbake (plus whatever other files we 
provide) is an example that's meant to be copied and built upon rather than 
used and edited in-place; perhaps adjusting the directory structure might help 
with this.

> > 3.  I think it would be very beneficial to understanding BitBake to
> > build out the HelloWorld example beyond the basics, incorporating and
> > explaining each concept along the way.  My thinking is that given the
> > true value of BitBake is in the building of complex systems, it would
> > be beneficial to walk through the concepts as simply as possible to
> > demonstrate the concepts that require leverage to accomplish this.
> > This would both demonstrate how BitBake works whiile avoiding overuse
> > of OE or YP project examples.  Is this idea reasonable, or beyond the
> > scope of the User manual?
> 
> I'm finding it very valuable to step through a simple example using
> the -DDD debug parameter to understand what's going on when I issue
> the BitBake command.

Stepping through the HelloWorld example sounds reasonable, however I would 
caution that the debug output does tend to change over time, so introducing it 
may increase the burden of maintaining the manual.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

