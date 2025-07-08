Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA86C83F0A
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 11:42:33 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.web11.16451.1751974952389791743
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Jul 2025 04:42:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=lQjfxCIM;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UU83OrXLPumWTLRUzh8cG1LaT96TOuiKPjqgtcA2050=; b=lQjfxCIM5mhxG2YR2g52aZv8+2
	4zKQDgy4tAg32vwmdRNTOVa4IPEL7qbFqDGrxAgp9KWrtzEy7AfU2qQbQBqEA+c+KNn3txD59zAG0
	lLyxmSQ5TAASQAhxuzKLjIJNTpf7XuDamBxnifRggbNC2wiyN/VUSanIWcDZV4jYlmIHqqtEKr6BU
	pJQ/E6dU8f9ViCA1l0noKWwR6L0cVYGUjM7OxveSVQIuW+O/GCEv0wV2WXlL5HcPCXbJl/WLiIjfj
	j28A8ryJKlDvysyOcj2n76mU+bPITCBzsINICa8rbf3WA3WX6JaiGRgpD9+shZx4fdZvbQa4nXQdE
	sobOKyIA==;
Received: from pool-174-114-102-5.cpe.net.cable.rogers.com ([174.114.102.5]:45438 helo=asus)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1uZ6iS-0000000700V-3GJd;
	Tue, 08 Jul 2025 07:42:30 -0400
Date: Tue, 8 Jul 2025 07:42:25 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: antonin.godard@bootlin.com
cc: YP docs mailing list <docs@lists.yoctoproject.org>, 
    BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH] Mention existence of three supported "classes"
 directories
In-Reply-To: <DB6N6S3RH1TM.1HFNXT9E75TR8@bootlin.com>
Message-ID: <f2ab85c5-e703-ebf2-7c97-9ebe1353f817@crashcourse.ca>
References: <7f7b0bf4-2fdf-d216-6488-7576a79b19ed@crashcourse.ca> <DB6N6S3RH1TM.1HFNXT9E75TR8@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel10.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel10.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel10.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 11:42:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17757

On Tue, 8 Jul 2025, Antonin Godard via lists.yoctoproject.org wrote:

> On Tue Jul 8, 2025 at 1:29 PM CEST, Robert P. J. Day wrote:
> >
> > Early in Section 1, mention that BitBake supports three related
> > classes directories.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> >
> > ---
> >
> >   I'm not thrilled with this explanation in terms of where it is, but
> > it's better than not explaining this at all.
> >
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> > index 539bb62d8..feab1df9d 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> > @@ -206,6 +206,18 @@ installing (empty by default) and packaging (empty by default). These
> >  tasks are often overridden or extended by other classes added during the
> >  project development process.
> >
> > +.. note::
> > +
> > +   While BitBake comes with just the one ``base.bbclass`` file in the
> > +   ``classes`` directory, it supports class files also being installed
> > +   in related directories ``classes-global`` and ``classes-recipe`` and
> > +   will automatically search all three directories for a selectd class
>
> s/selectd/selected/

  already submitted that fix.

> > +   file.
> > +
> > +   This means that, in this documentation, when you see a reference to
> > +   class files being in the ``classes`` directory, you can interpret that
> > +   as meaning in any one of the above three directories.
>
> I don't think this is enough explanation on these directories, and as-is it
> would create confusion I think.
>
> There are some details about these directories here:
> https://bootlin.com/doc/training/yocto/yocto-slides.pdf#19
>
> Maybe that can help you add the explanation?
>
> I would also explain the difference between these directories (classes,
> classes-recipe and classes-global) in a paragraph of its own, not in a note.

  Except that, once again, we would be going outside the bounds of
BitBake. I totally agree that there should be a comprehensive
explanation of these directories, but where does that belong?

rday

