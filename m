Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 809AB6FEE3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jun 2014 11:14:03 +0000 (UTC)
Received: from [69.196.158.250] (port=59089 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WxaI7-0003kt-Dr; Thu, 19 Jun 2014 07:14:03 -0400
Date: Thu, 19 Jun 2014 07:10:19 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <3352925.8xZMaK1Xg6@peggleto-mobl5.ger.corp.intel.com>
Message-ID: <alpine.LFD.2.11.1406190659450.31011@localhost>
References: <alpine.LFD.2.11.1406181050550.28390@localhost>
	<3352925.8xZMaK1Xg6@peggleto-mobl5.ger.corp.intel.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: more pedantry involving the proper use of PREFERRED_PROVIDER_*
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
X-List-Received-Date: Thu, 19 Jun 2014 11:14:06 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 19 Jun 2014, Paul Eggleton wrote:

> On Wednesday 18 June 2014 11:10:47 Robert P. J. Day wrote:
> >   and now, some picky questions about the use and processing of
> > PREFERRED_PROVIDER, once again using actual examples pulled from
> > the poky repository.
> >
> >   first, is there anything magical about the use of the prefix
> > "virtual/" when defining and selecting providers? i'm well aware
> > of the most common usage of this -- "virtual/kernel". and there
> > are other good examples like "virtual/bootloader",
> > "virtual/xserver" and so on.
>
> By and large, no. It is really just a convention. (I say by and
> large because there are a few bits of the code in BitBake and OE
> that do check for this, but they are fairly isolated to the point
> where mentioning them would be confusing.)

  thanks for clearing that up ... i'm not aware of any of the docs
that actually spells that out and i think it's worth mentioning
somewhere.

> >   but there are other non-virtual definitions, such as:
> >
> >   PREFERRED_PROVIDER_console-tools ?= "kbd"
> >
> > so if i select "console-tools" to be incorporated into my eventual
> > image, that line will end up selecting the "kbd" recipe.
>
> So, you have to be careful here; we are selecting a *build-time*
> provider of "console-tools", so we shouldn't muddy the waters by
> starting to talk about packages. The assumption here is that the kbd
> recipe has "console-tools" in its PROVIDES (as does the actual
> console-tools recipe, implicitly). PROVIDES matches up with DEPENDS,
> so if another recipe DEPENDS on "console-tools" then kbd PROVIDES
> that and PREFERRED_PROVIDER ensures it gets selected to do so
> instead of the actual "console-tools" recipe.

  quite so, i could have written that more clearly.

> > so why are some of these preferences using "virtual/" and some
> > not? is it just a philosophical choice? could i do something goofy
> > like define and select names like "rday/recipename" just as well?
>
> Yep.
>
> >   next, wouldn't the preferred provider for a recipe be, by default,
> > that same name? it seems odd to see something like:
> >
> >   PREFERRED_PROVIDER_ltp ?= "ltp"
> >
> > even if something else provides "ltp", isn't the above redundant? or
> > is there something subtle here i'm missing?
>
> We do this kind of thing when one recipe provides the functionality
> of another and thus can stand in its place. I'm not sure if we
> always make an active decision to use one or the other, but I can
> imagine cases where the reverse of the relationship isn't true -
> maybe one can replace the other's functionality but not the other
> way around.

  fair enough, but i don't think that addresses my question -- what's
the value in explicitly setting the PREFERRED_PROVIDER for a recipe to
the same name, which is the default. the ChangeLog file for bitbake
even states, way back for version 1.7.x:

  - Make PREFERRED_PROVIDER_foobar defaults to foobar if available

so while that line above doesn't hurt, it seems pretty clearly
superfluous, and possibly even potentially confusing if a reader
starts to wonder what the point of that line is.

> >   finally, i found this simple example i want to use as a teaching
> > example involving make and remake. there's a definition for the "make"
> > recipe that looks perfectly normal, and there is also a recipe
> > definition for an alternative, remake, whose .bb file contains:
> >
> >   PROVIDES += "make"
> >
> > and whose remake.inc file includes:
> >
> >   ALTERNATIVE_${PN} = "make"
> >   ALTERNATIVE_LINK_NAME[make] = "${bindir}/make"
> >   ALTERNATIVE_TARGET[make] = "${bindir}/remake"
> >   ALTERNATIVE_PRIORITY = "100"
>
> This is alternatives.bbclass in OE, and whilst that it is a
> mechanism for selecting between providers, it is for runtime files
> and doesn't tie in with PREFERRED_PROVIDER at all.

  right, again, i could have worded that more clearly. so, just to be
precise, the line:

  PROVIDES += "make"

defines the "remake" recipe as an alternative to "make" at build time,
while the "ALTERNATIVE" lines are then processed at run-time to set up
the symlinks properly, does that sound right?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

