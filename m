Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD37FD33A30
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:51 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31313.1768466145394748226
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 00:35:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=n7YZz3Pd;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F+IjsCcc7tHrrkqvDfsLym8+F0VDkh98e0i2otH50gI=; b=n7YZz3Pdc5rgDzmkQzom2r3mB0
	OEWdc4k2O2PGsOeDnYf50kISDjuynPIZ1jxo7pXxjhEalNhALh0xpDsTqgcbfLsaDnDT4Q0u3PEFu
	bc69vqECnOKGth0YKRFH9ZMdTw1udbeHlfdZVZNvyUJ7F18hqgMVH3IIFLMM2YD4xp5KhAZSvdHdk
	IvS5UZ9Svfs8adjFeQBeMyhQWsRLwpN7u6M+UOwMAYfFUz+YobW89Oaly8iYUuvSXegDBcR7aPppX
	FVlV2vdeGmX2IlONUQfup1u5G8O3SbsPL4R69R8DAgdRkwqV0vQBJ8HcL09+7/tcmEZVsjRklxwGu
	J4kOdsUw==;
Received: from pool-174-115-41-146.cpe.net.cable.rogers.com ([174.115.41.146]:47118 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vgIpU-00000008f7a-0bqp;
	Thu, 15 Jan 2026 03:35:43 -0500
Date: Thu, 15 Jan 2026 03:39:12 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: YP docs mailing list <docs@lists.yoctoproject.org>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] doc: BBFILE_COLLECTIONS assignment should
 use "+=", not "="
In-Reply-To: <188ADA6920329A2D.2595076@lists.openembedded.org>
Message-ID: <f3f6a956-c8ab-e7e9-9097-a3de3f2a37de@crashcourse.ca>
References: <188ADA6920329A2D.2595076@lists.openembedded.org>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 08:35:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18767


  ARGH, never mind, should have fixed BBFILES at the same time. v2
coming...




On Thu, 15 Jan 2026, Robert P. J. Day wrote:

>
> In a layer.conf file, the assignment to BBFILE_COLLECTIONS should use
> "+=", not simply "=". Even though this is just meant as an example, it
> should still be correct.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> index d407f59c0..b624fe8f6 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> @@ -241,7 +241,7 @@ upstream repository, but with custom modifications that one does not
>  want upstream. Here is an example::
>
>    BBFILES = "/stuff/openembedded/*/*.bb /stuff/openembedded.modified/*/*.bb"
> -  BBFILE_COLLECTIONS = "upstream local"
> +  BBFILE_COLLECTIONS += "upstream local"
>    BBFILE_PATTERN_upstream = "^/stuff/openembedded/"
>    BBFILE_PATTERN_local = "^/stuff/openembedded.modified/"
>    BBFILE_PRIORITY_upstream = "5"
>

