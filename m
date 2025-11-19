Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DFCCF34D0
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:09:59 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9261.1763564990124600565
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 07:09:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=DbuETnJ8;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8Bm+1wul9/kSJeZDpU7PR6cMA/VgPUjEVmQxskldVvA=; b=DbuETnJ84RZIXZBBXhtCE4BdoV
	dCDe8BosQ27urwiPguCq95//SLPmnlE4pOs0Lb2lASHeHtyGAd2AKsJwS1mrbUaxDGuWVNNeejgfs
	99npOPWEkX5r9/yMFh2cv68zF46Rtxc2vJGEkqPxN9/BdzcsAqAsA4mJ5uj8ID/f3dJDoIsIAihn1
	XUdSwPevusU9rr0DLAYAuaNKzpFH9JkxOmMYTAJ7mFrt1E1V1tTjvtRQNyr2gY0IuRT8H9Hd9Kq40
	z1aOLYF1zCYMNCqxkTXWvHCKvjBi5AgMLcC2Br+WiLDN+PPzsjnsKP8H9nuSKoojd5tbbSEH2ynEX
	jSkxSE6A==;
Received: from [147.129.179.166] (port=38996 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vLjoX-00000003Pi7-1zsr;
	Wed, 19 Nov 2025 10:09:48 -0500
Date: Wed, 19 Nov 2025 10:10:25 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Joshua Watt <jpewhacker@gmail.com>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] why is "bitbake-setup list" trying to *create*
 bitbake-builds directory?
In-Reply-To: <CAJdd5GZZNGyPePiJEQnn-0mZK0cX9dzTh7KM3uqkFJtnJ6dVQg@mail.gmail.com>
Message-ID: <47d2ddfd-d3bc-e1be-33d3-193b7e6c8168@crashcourse.ca>
References: <42bcc23e-27ae-8bf4-486d-3e552d58c701@crashcourse.ca> <CAJdd5GZZNGyPePiJEQnn-0mZK0cX9dzTh7KM3uqkFJtnJ6dVQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-521544058-1763565028=:3386664"
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
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 15:09:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18460

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-521544058-1763565028=:3386664
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 19 Nov 2025, Joshua Watt wrote:

> On Wed, Nov 19, 2025 at 7:58 AM Robert P. J. Day via
> lists.openembedded.org <rpjday=crashcourse.ca@lists.openembedded.org>
> wrote:
> >
> >
> >   i'm confused about why "bitbake-setup list" is not just attempting
> > to "list" stuff, but is actively creating a "bitbake-builds" directory
> > in my current location.
> >
> >   if i have no bitbake-builds in my home directory and i'm *in* that
> > directory, then:
> >
> > $ bitbake-setup list
> > Bitbake-setup is using /home/rpjday/bitbake-builds as top directory
> > ("bitbake-setup settings --help" shows how to change it).
>
> Does this still happen on the latest master? I think it might have
> been fixed by: 0ae46d39c ("bitbake-setup: create top-dir later in
> init")

  i just pulled bitbake master and it is still behaving this way -- i
will make absolutely sure i'm up to date. can you not reproduce this?

rday
--8323329-521544058-1763565028=:3386664--

