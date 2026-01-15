Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93703D44C66
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 15:52:24 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39154.1768492337721393416
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 07:52:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=vtcO4Hyo;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HiurqpQFXZun6sqz+xivLxQUT5lCyDuI5DBZ0gZCYVA=; b=vtcO4HyosGQkP3YzzkD8cmDpop
	5E1i0MDsezoPK/fOdYUiXLyc6ru6yO8d7oADPSor/Y6obl2OIyaRAh9JckZ1NBBoYeJbXGiE71aX5
	rkCJAc4Ba6NOPgkZ+FD7B05kB9Lyuw4+02LzwxYzCLEDrzy9yOduUgOU9uCvHsx/smV2fQ2CBs4Mu
	9ILoaZi2cXy+Arr19qPpEoYwNvrBe2KzUrse886I0o/ODpsa+FLXhysDgxkBavHmQ7YvcM1VAP/Wp
	wgTy+v9UiBsCEsWKrLVnW/VX/5Uhz404aVBxSDSIqzNAWZBiD3T+v76lncYmhCm+tgEWgQpT3SeMF
	Jy/R2iyA==;
Received: from [147.129.179.166] (port=36294 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vgPdw-00000009oAI-1yzC;
	Thu, 15 Jan 2026 10:52:16 -0500
Date: Thu, 15 Jan 2026 10:55:39 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: YP docs mailing list <docs@lists.yoctoproject.org>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: sphinx ref error in bitbake manual
Message-ID: <ea1596c4-7935-f7b3-bac9-5ea56bcd28c9@crashcourse.ca>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 15:52:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18784


/home/rpjday/oe/layers/bitbake/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst:947:
WARNING: undefined label: '_ref-bbsetup-source-overrides' [ref.ref]

rday

