Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA28FFEFB5D
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 15:08:52 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.98205.1772204922957083292
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Feb 2026 07:08:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=bn4NGu6H;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5Pcwup8fMA9f0qaR5rWsDq8dyKZyPysJimQwGE0Mjbc=; b=bn4NGu6Hhvy/iUtO476sqCPWNR
	1PPk3l1r5KxBMC7b99tovqdvOB2JqP1xGmHZUw8VjX3N5jxoA2LQFh2j3M1zIzvL/CkORoZpDNANY
	9srV0gTU6f2sXIB935JA8u7Oi1PsdjgAEFFzzLLUki8u3SJCDk3JhOd1buNYU0tlwFIwcOCO/gTZx
	RYTELV/+HyqNKTQhpfNjKUTewFRScj7h3b2iN9mz0LcboGQFWKqS0j3DGJ/X6WadTtjeFgpl5gRS1
	YchzA56W3D7bN8iqUfgNBGUSfeVaXynbXaIyvB+BhCEuveT6SqFrMpsFbvF1Ur/Yv8YxoGzk+OipQ
	Qv1BXNQw==;
Received: from [147.129.179.166] (port=44828 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vvzSK-00000003vU2-0iYb;
	Fri, 27 Feb 2026 10:08:40 -0500
Date: Fri, 27 Feb 2026 10:08:00 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Quentin Schulz <quentin.schulz@cherry.de>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] correct small number of "Bitbake" to
 "BitBake"
In-Reply-To: <21748143-bb17-43b2-98ce-e296f126e00e@cherry.de>
Message-ID: <b1c925b2-e7fb-dcc9-c57c-d96587c8b7f2@crashcourse.ca>
References: <10c820e1-5872-f256-d5ad-13316afa6d19@crashcourse.ca> <f250f160-a76e-486a-934c-52f0496fee3a@cherry.de> <0b1db344-464f-94f7-6345-cae207c29402@crashcourse.ca> <21748143-bb17-43b2-98ce-e296f126e00e@cherry.de>
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
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Feb 2026 15:08:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19094

On Fri, 27 Feb 2026, Quentin Schulz wrote:

> On 2/27/26 1:20 PM, Robert P. J. Day wrote:
> > On Fri, 27 Feb 2026, Quentin Schulz wrote:
> >
> > > Hi Robert,
> > >
> > > On 2/24/26 6:20 PM, Robert P. J. Day via lists.openembedded.org wrote:
> > > >
> > > > Use correct spelling of "BitBake" in a few places.
> > > >
> > >
> > > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> > >
> > > FWIW, we could "enforce" that by using a substitution, c.f.
> > > https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#substitutions
> > >
> > > .. |bitbake| replace:: BitBake
> > >
> > > (e.g. in rst_prolog variable in conf.py, c.f.
> > > https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-rst_prolog)
> > >
> > > And then throughout the docs, use |bitbake| instead of BitBake.
> >
> >    except we don't want that substitution if using "bitbake" as the
> > command name. it's like referring to the SCM "Git" as opposed to the
> > command name "git".
> >
>
> Sure, but then we know for sure what's the name of the command (use
> ``bitbake``) or the name of the project (|bitbake|) for example.

  ah, i see your point. for now, we can just fix the small number i
found manually, and get fancier in the long run.

rday

