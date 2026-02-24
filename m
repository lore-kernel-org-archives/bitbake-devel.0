Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354F5F3C9A8
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 15:57:04 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23468.1771948614131405281
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Feb 2026 07:56:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=YJ3/BCxB;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OdwpCvn0SSUi4c8na56rpJ/BJzBdtWsiFmQ7te0ScVM=; b=YJ3/BCxBCpAHMUVy4gC5kMQ13V
	hb3W9RqIDeFO/69TxZZc1FZEOIhdwnRP18zeOC92AsmpJOY9frVjODFjNfBpkANPHtrWxo6rF+9Yv
	pISS4PilwRi0IbgKfryQm7/7xyB3fgnpfkB32gCIZVnl2BnBu6Exckkupl81aybWI5F6xDT2qfuQF
	XsCBQdDQPM0RKjBhdfsesfL1nR1t4c766GRfFBgrftHmKaOBOJHvc70yL1tfYeEvIMWzg0h9P5JrS
	x0srwUIU5Oc4v1+SEfMxbn4gMXpOpFJSrfHahY7+b8F9UcY3dUTRbALHvc3TnmLnehy6SY84AjW20
	sYnnRqXg==;
Received: from pool-174-115-41-146.cpe.net.cable.rogers.com ([174.115.41.146]:40658 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vuumK-00000000G12-3FP4
	for bitbake-devel@lists.openembedded.org;
	Tue, 24 Feb 2026 10:56:53 -0500
Date: Tue, 24 Feb 2026 10:59:10 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: would anyone mind a patch that "Bitbake" -> "BitBake"?
Message-ID: <445dfdfb-e125-723c-196f-6c2c06207c1a@crashcourse.ca>
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
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Feb 2026 15:57:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19082


  i noticed a number of references to "Bitbake" in the BB user manual
... i can submit a patch to clean that up unless someone wants to
snatch that task away from me.

rday

