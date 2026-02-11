Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114ECECD6E9
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 20:43:49 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28937.1770842627105907737
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 12:43:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=UsqyvA+d;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DVQvFR77OaY8RU7ZLEt1qoQBlal/p2FK4a3e2XdXGvM=; b=UsqyvA+dYofjWCMMSqQWdn8AuJ
	d5dSUg/Ejhmhw8mHsoUK8vt9ICQTGxP5304gXNlLcpNmGRydgVibbZLDnioaox5JsUi5Tm5OUnzJN
	ixhaRWwByTbg2W9BgsGVEW2ArBGHwt1f1mTk6eQOF/XyMkJBHUILcDaKR3zjnKtEaL5v9ph+uIfdD
	0bvY+5nOc33TC4yAV3RCyPdTmuq5SUVseZeorU4Wv8F/SxTM4Yoj4badWR7DGGmP63U0hUZnCKi/O
	mGQJ/OEmwDzKD4UnK8H6fJJ5icU19hyyPnIfQnqsZwAbLYo462wCF3B6/C7YYs5v4FtDDcTNVIpHV
	D0XPQ76Q==;
Received: from pool-174-115-41-146.cpe.net.cable.rogers.com ([174.115.41.146]:40884 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vqH3p-00000000m0K-1Fp3;
	Wed, 11 Feb 2026 15:43:45 -0500
Date: Wed, 11 Feb 2026 15:45:00 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: foss@0leil.net
cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
    Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [docs] [PATCH 0/4] doc: bitbake-user-manual-ref-variables:
 clarify BBMASK examples
In-Reply-To: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
Message-ID: <d56ebe51-571e-b960-854c-34729ab18cb0@crashcourse.ca>
References: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
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
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 20:43:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19013

On Wed, 11 Feb 2026, Quentin Schulz via lists.yoctoproject.org wrote:

> Robert reported being confused by the leading slash inconsistencies
> in our BBMASK examples and wondered if it had any significance.
> After reading the code and testing, it does, so this tries to
> explain the difference and why you would want a leading slash in
> most cases.

  thanks, quentin, for tolerating my relentless whining about stuff
and proceeding to resolve it. i will try to get back to contributing
some of my own stuff in the near future. i already have plenty of
ideas for docs improvement.

rday

