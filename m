Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECE1E6BF34
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 18:33:42 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1055.1769798020129764231
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jan 2026 10:33:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=IdLiRr+B;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kie/EvhZ00/fQXahD3bG44ua7FOtjRLrKVsqFur3FuU=; b=IdLiRr+BLPbrbs1z+6FXf1hJxq
	UuJoNmQflqQWkK7v64LZAQ83oXlvFKj6FyuEEvcxj4EFqOaeQ5/UH8FIn5ouYxup1qMacKfT2/oo0
	h8MNSiUmTvnm7EoY+//mKnraN5G3EuiCEB5FUWlprl39CUzm+6sSZOJigWPdb9suyc4zwluVKusrV
	hTxw2UuLFfawOo1zLRsy31xW+i7LhA+tvniBlV0tW9bNDCP3pXNRZxNA+Xzt2UcDaZcMQmdD1UdUY
	JM5h7vz7qqQhVa0Psr9UNHvA/9tF4cOlpqOlcmRNYm+y3bokplwjrg2VKB7PF/31N8Vha32E0lw0T
	tMswQU1w==;
Received: from pool-174-115-41-146.cpe.net.cable.rogers.com ([174.115.41.146]:59408 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vltJJ-00000009nzb-2luy;
	Fri, 30 Jan 2026 13:33:38 -0500
Date: Fri, 30 Jan 2026 13:34:38 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: YP docs mailing list <docs@lists.yoctoproject.org>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Should the BB manual have a comprehensive reference for handler
 event masks?
Message-ID: <d6529c1a-8b4a-d5e6-d8df-ef5fe27fe74d@crashcourse.ca>
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
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Jan 2026 18:33:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18942


  While perusing some vendor's code, I ran across an example of
setting a handler eventmask to "bb.event.SanityCheck". Out of
curiosity, I looked up the current BB manual for that event, but it is
not listed here (many others are, of course):

https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#events

  Is there any value in having a comprehensive and complete list of
BB-supplied events? If not, how do we expect a developer to know about
the ones that are not documented?

rday

