Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94410C61CE8
	for <webhook@archiver.kernel.org>; Thu, 12 Jun 2025 09:29:33 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.web10.8628.1749720571758452606
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Jun 2025 02:29:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=ZVtZr1tc;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GPmk3Sncd1QHecV1ELzuJzNsSsJ7Y270XNjwG6yCrC0=; b=ZVtZr1tcHf7IPbL0h9yfqlPHrW
	TLR0piR+2J+MBzbcK00JZmKv3tJ2Yhf8/UgwtW7llE/yPtNZI6H79J4ubKF2sPpjjzKFmw2Z/Yc5m
	WwJq2bFOykaEBdwa/OVyIwROXFZoAvMYBAXTBkGMXjeh1UNKyYKBFkdWlXFDm5XGUAT1MsCwBjhp1
	Rv6A160yuunNv1z8pFk27mr+u2s8ShMqVT2OC5YA5eGgJSItcj9xTxbqb9ZO1NqxHgvxHPtc97C+a
	d4nDeo6todmgkwho5bQuW6TRH8gB8ADQZqdA2E5sw+ot8MDhH2sgsapSm+Cc73FEITbNbRVc/zjoQ
	s+wdMi8w==;
Received: from pool-174-114-102-5.cpe.net.cable.rogers.com ([174.114.102.5]:34722 helo=asus)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1uPeFW-000000000v7-07JJ;
	Thu, 12 Jun 2025 05:29:30 -0400
Date: Thu, 12 Jun 2025 05:29:21 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: hongxu.jia@eng.windriver.com
cc: bitbake-devel@lists.openembedded.org, alex@linutronix.de
Subject: Re: [bitbake-devel] [PATCH V2] bitbake-getvary: skip info output of
 bitbake for quiet
In-Reply-To: <20250612092631.161687-1-hongxu.jia@windriver.com>
Message-ID: <8c2ca340-682c-a50e-7287-59e7d6738874@crashcourse.ca>
References: <20250612092631.161687-1-hongxu.jia@windriver.com>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Jun 2025 09:29:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17697


  subject line contains typo "bitbake-getvary"

rday

