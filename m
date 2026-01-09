Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5E3D1680F
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 11:01:37 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7743.1767956486747944512
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Jan 2026 03:01:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=V9q7yKYz;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KqPJAY8m7d9Ege8Uahn7cqydV+p2FeIr5o3Q8ouKmFE=; b=V9q7yKYzIin8+aNfMqSrmGXnZV
	GWFfiJAUvqUUlwJyYlUhu8IapdnTospCK9kvBb7/0V9InioGrec3TC447smxqZzFz1tVGhzrPc2n4
	5CxWZkb0LSB0bUWNYmFv1JAv3SxfQ+5O555EZXP4NbBK14wf4cF7QyekcAv4Dcv5nMfvS5dj1OIl+
	7ospt5Ke4AaHZ8ZLg9LAqqW4sR0/E17HY4JpueTfW41QJste5W6+HgR/3T6u7fgj2cE0EKHwZvMk/
	hcQbj/Ud4YsdRRafpevTx68YIwl+jMaLVPV+9LnzNUNdRf0pL8QEUNco3lG161zYunkTsmithWsAc
	2AwiJRUg==;
Received: from [147.129.179.166] (port=53816 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1veAF9-00000004r33-3yRp;
	Fri, 09 Jan 2026 06:01:25 -0500
Date: Fri, 9 Jan 2026 06:04:24 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: antonin.godard@bootlin.com
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>, 
    YP docs mailing list <docs@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] [docs] [PATCH] doc: bitbake ch 2: use example
 of nginx to explain DEFAULT_PREFERENCE
In-Reply-To: <DFJYMW8QAZ22.1GOY96LCY19VK@bootlin.com>
Message-ID: <f2ade0a5-f600-b5a0-637d-128df8dcad59@crashcourse.ca>
References: <5113f81f-1b33-a4ac-f71d-432caf8e709a@crashcourse.ca> <DFJYMW8QAZ22.1GOY96LCY19VK@bootlin.com>
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
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 11:01:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18721

On Fri, 9 Jan 2026, Antonin Godard via lists.openembedded.org wrote:

> Hi,
>
> On Thu Jan 8, 2026 at 11:08 PM CET, Robert P. J. Day wrote:
> >
> > At the moment, the section on explaining DEFAULT_PREFERENCE uses an
> > example of busybox, which does not even use this feature anymore.
> > Replace this with an example using "nginx", which does.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> >
> > ---
> >
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> > index d407f59c0..1638a8f5c 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> > @@ -337,21 +337,22 @@ file that BitBake parses, you can change that preference::
> >
> >  .. note::
> >
> > -   It is common for a recipe to provide two versions -- a stable,
> > -   numbered (and preferred) version, and a version that is automatically
> > -   checked out from a source code repository that is considered more
> > -   "bleeding edge" but can be selected only explicitly.
> > -
> > -   For example, in the OpenEmbedded codebase, there is a standard,
> > -   versioned recipe file for BusyBox, ``busybox_1.22.1.bb``, but there
> > -   is also a Git-based version, ``busybox_git.bb``, which explicitly
> > -   contains the line ::
> > -
> > -     DEFAULT_PREFERENCE = "-1"
> > -
> > -   to ensure that the
> > -   numbered, stable version is always preferred unless the developer
> > -   selects otherwise.
> > +   It is not uncommon for a given recipe to provide more than one
> > +   version -- a stable (and preferred) version that should be selected
> > +   by default, and a newer, development or "bleeding edge" version that
> > +   will be selected only explicitly by the developer.
> > +
> > +   For example, at the moment, in the OpenEmbedded codebase, there are
> > +   two versions of the ``nginx`` webserver: a stable "1.28.0" version
> > +   that would be selected by default, and a newer "1.29.1" development
> > +   version that a developer would need to choose explicitly.
> > +
> > +   This can be seen based on this snippet from the ``nginx`` 1.29.1
> > +   recipe file::
> > +
> > +      # 1.28.x branch is the current stable branch, the recommended default
> > +      # 1.29.x is the current mainline branches containing all new features
> > +      DEFAULT_PREFERENCE = "-1"
>
> We should consider dropping these kinds of phrasings in favor of generic
> examples inspired from real life, e.g. "Consider the following example
> recipe...". That way, no maintenance burden like this one.

  to *some* extent, i agree with you, but i also feel that it's
valuable to demonstrate some explanations with examples ripped
straight from the source code so that beginning developers can see
those things in action. i agree that this is not the *best* example to
use for this, though, but it will do for now.

rday

