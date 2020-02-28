Return-Path: <rpjday@crashcourse.ca>
Received: from cpanel7.indieserve.net (cpanel7.indieserve.net [199.212.143.8])
	by mail.openembedded.org (Postfix) with ESMTP id 3736961956
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2020 19:38:12 +0000 (UTC)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com
	([174.114.57.56]:53476 helo=localhost.localdomain)
	by cpanel7.indieserve.net with esmtpsa (TLS1.2) tls
	TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1j7lSe-000tv7-UF; Fri, 28 Feb 2020 14:38:13 -0500
Date: Fri, 28 Feb 2020 14:38:09 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: Mikko.Rapeli@bmw.de
In-Reply-To: <20200228140919.GO104502@korppu>
Message-ID: <alpine.LFD.2.21.2002281435580.6574@localhost.localdomain>
References: <20200228083336.Horde.2i5ag6ZVWX3JF5j5y3bF1q2@crashcourse.ca>
	<20200228140919.GO104502@korppu>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel7.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel7.indieserve.net: authenticated_id:
	rpjday+crashcourse.ca/only user confirmed/virtual account not
	confirmed
X-Authenticated-Sender: cpanel7.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: can i get a list of only bbappend'ed recipes that were *used* in a build?
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
X-List-Received-Date: Fri, 28 Feb 2020 19:38:13 -0000
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Feb 2020, Mikko.Rapeli@bmw.de wrote:

> Hi,
>
> On Fri, Feb 28, 2020 at 08:33:36AM -0500, rpjday@crashcourse.ca wrote:
> > looked around and i don't see an immediately obvious way to do
> > this ... is there a way to generate a list of *only* those recipes
> > that were used in the current build that had associated .bbappend
> > files?
> >
> > "bitbake-layers show-appends" will show all recipes with .bbappend
> > files, including those that are not included and processed for the
> > current build/image. here's the rationale, in case i'm missing
> > something.
>
> I'm doing "find meta* -name \*recipe\*bb\*" and reviewing every one
> of them. More visibility to this including parsing order would be
> nice to store in e.g. buildhistory.

  thanks for clarifying that there wasn't a massively trivial way to
do this that i just didn't see.

> > been handed an existing vendor layer, with *tons* of bbappend'ed
> > recipes, some basic, some from meta-openembedded and many from the
> > vendor's proprietary layer. my go-to strategy is to always try to
> > build a core-image-minimal to establish a working baseline and,
> > when that works, it would be nice to know which of the recipes
> > that contributed to that core-image-minimal build were modified in
> > any way via a .bbappend file, then work my way out.
> >
> > does that make sense? is there a way to do this, other than wander
> > down to tmp/work/... and try to figure out which recipes were
> > modified from the original? am i overlooking something simple?
>
> I start off by reviewing every single file in vendor and BSP SW
> layers before I add them to builds. Sadly this does not catch bad
> things which get integrated later in updates.
>
> Resulting distro config in my projects is full of BBMASK paths to
> the various layers which are intrusive with their bbappends.

  yup, i'd already thought of that ... a methodical way to slowly add
recipes/layers to the build.

> Maybe recording all bbappends and their relative paths in the
> project and parsing order to buildhistory would help.
>
> I would also like to limit layers from adding bbappends to certain
> recipes but I don't see ways for this currently without external
> scripts.

  yeah, there's lots of cool things i can think of that would assist
in a migration from an older version of OE/YP to a more recent one.

rday

