Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id E96E96FDF3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jun 2014 10:55:17 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 19 Jun 2014 03:55:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,506,1400050800"; d="scan'208";a="550307780"
Received: from akagikob-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.96])
	by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2014 03:55:12 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Thu, 19 Jun 2014 11:55:11 +0100
Message-ID: <3352925.8xZMaK1Xg6@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.12.5 (Linux/3.14.7-200.fc20.x86_64; KDE/4.12.5; x86_64; ; )
In-Reply-To: <alpine.LFD.2.11.1406181050550.28390@localhost>
References: <alpine.LFD.2.11.1406181050550.28390@localhost>
MIME-Version: 1.0
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
X-List-Received-Date: Thu, 19 Jun 2014 10:55:18 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 18 June 2014 11:10:47 Robert P. J. Day wrote:
>   and now, some picky questions about the use and processing of
> PREFERRED_PROVIDER, once again using actual examples pulled from the
> poky repository.
> 
>   first, is there anything magical about the use of the prefix
> "virtual/" when defining and selecting providers? i'm well aware of
> the most common usage of this -- "virtual/kernel". and there are other
> good examples like "virtual/bootloader", "virtual/xserver" and so on.

By and large, no. It is really just a convention. (I say by and large because 
there are a few bits of the code in BitBake and OE that do check for this, but 
they are fairly isolated to the point where mentioning them would be 
confusing.)

>   but there are other non-virtual definitions, such as:
> 
>   PREFERRED_PROVIDER_console-tools ?= "kbd"
> 
> so if i select "console-tools" to be incorporated into my eventual
> image, that line will end up selecting the "kbd" recipe. 

So, you have to be careful here; we are selecting a *build-time* provider of 
"console-tools", so we shouldn't muddy the waters by starting to talk about 
packages. The assumption here is that the kbd recipe has "console-tools" in 
its PROVIDES (as does the actual console-tools recipe, implicitly). PROVIDES 
matches up with DEPENDS, so if another recipe DEPENDS on "console-tools" then 
kbd PROVIDES that and PREFERRED_PROVIDER ensures it gets selected to do so 
instead of the actual "console-tools" recipe.

> so why are
> some of these preferences using "virtual/" and some not? is it just a
> philosophical choice? could i do something goofy like define and
> select names like "rday/recipename" just as well?

Yep.

>   next, wouldn't the preferred provider for a recipe be, by default,
> that same name? it seems odd to see something like:
> 
>   PREFERRED_PROVIDER_ltp ?= "ltp"
> 
> even if something else provides "ltp", isn't the above redundant? or
> is there something subtle here i'm missing?

We do this kind of thing when one recipe provides the functionality of another 
and thus can stand in its place. I'm not sure if we always make an active 
decision to use one or the other, but I can imagine cases where the reverse of 
the relationship isn't true - maybe one can replace the other's functionality 
but not the other way around.

>   finally, i found this simple example i want to use as a teaching
> example involving make and remake. there's a definition for the "make"
> recipe that looks perfectly normal, and there is also a recipe
> definition for an alternative, remake, whose .bb file contains:
> 
>   PROVIDES += "make"
> 
> and whose remake.inc file includes:
> 
>   ALTERNATIVE_${PN} = "make"
>   ALTERNATIVE_LINK_NAME[make] = "${bindir}/make"
>   ALTERNATIVE_TARGET[make] = "${bindir}/remake"
>   ALTERNATIVE_PRIORITY = "100"

This is alternatives.bbclass in OE, and whilst that it is a mechanism for 
selecting between providers, it is for runtime files and doesn't tie in with 
PREFERRED_PROVIDER at all.

> so i'm assuming i could just do something like:
> 
>   PREFERRED_PROVIDER_make = "remake"
> 
> yes? 

Yes.

> is this explained anywhere in the yocto docs in more detail?
> thanks.

I don't know, but if not it should be (perhaps the BitBake manual is the best 
place though.)

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

