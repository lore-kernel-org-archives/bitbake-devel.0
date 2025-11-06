Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDCBCCFA05
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 15:23:58 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18184.1762442637828264302
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 07:23:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=N+NwcFUx;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=skmNc0buoXKi14wdeBP0f8cvtnEK7hYZhf747pg+TfU=; b=N+NwcFUxss3VEmPUQqtfqst+xe
	BokfLSBTA8J193jQnXQkry4RqE8Su4RXNPUNlpixb/PMCWFfSqDqqTK6E1hpVtSN62/NOCb3/E+0f
	i4AF6fWI2G7H64ayv1T3R1b764aY8SNQaACDS2HHJqJbm7qcBc/+eekKtUTpVWPBgx0q5TSpsylO5
	4gzKCrLGh4tUHWYAbNZ1OBdIPdLUrnLARJk4t7toO9h8ggCbUFYGgvimH1m6z1WkmoQSg5nVT/Tll
	uVRQAywKiQrybwOrKFrvjX+waN+ZQzMktRjZUKNaDyoBYNFHDASTymv0zxsHzeZXjSmotvIangkzk
	EYhIXoXQ==;
Received: from [147.129.179.166] (port=54204 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vH1q7-0000000APgQ-0qh5;
	Thu, 06 Nov 2025 10:23:55 -0500
Date: Thu, 6 Nov 2025 10:26:50 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: richard.purdie@linuxfoundation.org
cc: alex.kanavin@gmail.com, Antonin Godard <antonin.godard@bootlin.com>, 
    bitbake-devel@lists.openembedded.org, 
    Alexander Kanavin <alex@linutronix.de>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
In-Reply-To: <278bb2544a713588af57889f35197e0c6f424c8b.camel@linuxfoundation.org>
Message-ID: <88d8a127-0232-01d4-130f-c59162b4f818@crashcourse.ca>
References: <20251106114714.918370-1-alex.kanavin@gmail.com>  <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com>  <CANNYZj-pgb6SMxhzB4g-siGY7oWaNjb=jOSk3m-TRKLwHPytFQ@mail.gmail.com> <278bb2544a713588af57889f35197e0c6f424c8b.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1042225670-1762442834=:4020824"
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
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 15:23:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18292

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1042225670-1762442834=:4020824
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 6 Nov 2025, Richard Purdie via lists.openembedded.org wrote:

> On Thu, 2025-11-06 at 13:28 +0100, Alexander Kanavin via lists.openembedded.org wrote:
> > On Thu 6. Nov 2025 at 13.11, Antonin Godard <antonin.godard@bootlin.com> wrote:
> > > Hi,
> > >
> > > On Thu Nov 6, 2025 at 12:47 PM CET, Alexander Kanavin via lists.openembedded.org wrote:
> > > > From: Alexander Kanavin <alex@linutronix.de>
> > > >
> > > > {THISDIR} is a special value token that can be used in the list of enabled
> > > > layers to specify the layer location relative to the confguration file:
> > > > https://git.openembedded.org/bitbake/commit/?id=b3153be29de8b8570b0c184369bd41f4c646cf92
> > > >
> > > > This replaces the token with an explicit separate keyword for such layers:
> > > > so that special processing to determine the final value can be avoided, and
> > > > the feature can be formalized in the json schema:
> > > >
> > > > instead of
> > > >     "bb-layers": [
> > > >          "{THISDIR}/meta-my-project"
> > > >      ]
> > > >
> > > > this allows
> > > >     "bb-layers-relative-to-this-file": [
> > >
> > > Can I suggest naming it "bb-layers-local"? "bb-layers-relative-to-this-file"
> > > feels bit overwhelming, I think with associated documentation users will be
> > > able to figure what "local" stands for in this case.
> > >
> >
> >
> >
> > ‘Local’ implies the path can be absolute, which is not supported, and it doesn’t suggest what the path should be relative to. I’d rather make it longer but clearer.
>
> bb-layers-relative maybe?
>
> bb-layers-relative-to-this-file is precise but does feel a bit too
> unwieldy. Any other options?

  the qualifier "-to-this-file" seems implied and thus superfluous.

rday
--8323329-1042225670-1762442834=:4020824--

