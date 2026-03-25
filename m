Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0575E106B52D
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 12:54:05 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21825.1774443239246412660
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2026 05:53:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=dMpBihVZ;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xT9CiIuTaC9mpet+wvfnaYx8RmlyaP11yQLTMPiehXM=; b=dMpBihVZrv3SIdVuPoh9PodmUu
	YGBOV7lQCd1ulso7Hav/wJWQFyBpsVGqBPt2QPqlRG41oBUBWb5FIS+I+I0bjnPARAJw+C+ezekDS
	LVT46aiYj4jz/pAGRP6eWcpjFrM0f3pfbvrrKPellL/pLHOzwWIfbygfvxys6Wb5hg8PziITC8BsC
	cL4IuVToEmxd6kAKclyYxUDGJaXG9jFSOS+jq36K1ya6WkGuYKuEBPkhHV+l2WUomFP5On1aBs6YS
	Sc0e8D7f/ggfwCwqRfOrw3JR/YMcCrANvQZK84Ebt6WkDt38WYjqLtBaGduJltBlpFde20gAprzlu
	HTT9MtMA==;
Received: from [147.129.179.166] (port=39402 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1w5NkC-00000007sMI-3aUF;
	Wed, 25 Mar 2026 08:53:57 -0400
Date: Wed, 25 Mar 2026 08:54:33 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: richard.purdie@linuxfoundation.org
cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] toaster: Update fixtures for wrynose
 release
In-Reply-To: <20260325125019.297452-1-richard.purdie@linuxfoundation.org>
Message-ID: <cb2250b7-db56-206c-1639-72e3ce9c4849@crashcourse.ca>
References: <20260325125019.297452-1-richard.purdie@linuxfoundation.org>
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
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 12:54:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19232

On Wed, 25 Mar 2026, Richard Purdie via lists.openembedded.org wrote:

> Update the fixtures for toaster to add wynose. Update the tests to
> match.

  "wynose"

