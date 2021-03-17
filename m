Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web10.73.1616013475711903702
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Mar 2021 13:37:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:36140 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lMcvR-005OfV-NM; Wed, 17 Mar 2021 16:37:54 -0400
Date: Wed, 17 Mar 2021 16:37:50 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Khem Raj <raj.khem@gmail.com>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] doc: Mention OE routine for setting BB_NUMBER_THREADS
In-Reply-To: <CAMKF1sqWmgCeJ4VcLFA=SPF_Tx3oB-z=YUetzsqzBBKyvzcDaw@mail.gmail.com>
Message-ID: <a1742529-bd95-6986-5473-4651e4c3d3f@crashcourse.ca>
References: <9914cbb9-eb88-c215-4fec-185762583ed@crashcourse.ca> <CAMKF1so2rS8miJHs-V+DHV5SXLAMd=F1FizmnQ9GzuaTfQ4mKw@mail.gmail.com> <ff65454a-d7d5-7f28-e785-b3eb5b4f724@crashcourse.ca> <CAMKF1sqWmgCeJ4VcLFA=SPF_Tx3oB-z=YUetzsqzBBKyvzcDaw@mail.gmail.com>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel8.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel8.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel8.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Content-Type: text/plain; charset=US-ASCII

On Wed, 17 Mar 2021, Khem Raj wrote:

> On Wed, Mar 17, 2021 at 8:56 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> > On Wed, 17 Mar 2021, Khem Raj wrote:
> >
> > > On Wed, Mar 17, 2021 at 3:34 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > > >
> > > > Given the discussion of BB_NUMBER_THREADS, what it means and how to
> > > > set it, it seems only fair to mention that it's probably already set.
> > > >
> > > > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> > > >
> > > > ---
> > > >
> > > > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> > > > index d74e768f..a2003997 100644
> > > > --- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> > > > +++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> > > > @@ -45,6 +45,13 @@ the BitBake command and its options, see ":ref:`The BitBake Command
> > > >     A possibly simpler solution is that some Linux distributions (e.g.
> > > >     Debian and Ubuntu) provide the ``ncpus`` command.
> > > >
> > > > +   If you're using a relatively recent version of Poky or Openembedded,
> > >
> > > I think it would be better to avoid distro names in generic documentation
> >
> > ... snip ...
> >
> >   normally, i'd agree, but given that 99.4237 per cent of bitbake
> > usage is in the context of OE or YP, if you're going to tell people
> > about BB_NUMBER_THREADS, it is not out of line to point out that they
> > almost certainly have that value calculated for them automatically
> > already.
>
> OpenEmbedded is perhaps more appropriate here, since its the build
> system and would tend to cover all
> OE based distributions including poky

  i'm good with that, will re-submit.

rday
