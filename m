Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D303C83F1A
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 18:32:00 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.web10.20957.1752258716675405020
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Jul 2025 11:31:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=HvMZcv3x;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9TyYoKArfBmLqVMx4cDPo/jiGONHHdjdSc65+XVo+ZI=; b=HvMZcv3xPPY151JHdfHqWf36JM
	oY0Zys40yquPUh+PX9GhAu70iOcMkG7+e+Vmpc7JxmsM88QMT6LAeQ78WVm1ayyffvgGARffEtowL
	K8NRp8Say+KrE4Jw1C9ChevxkCqR1LP7YZLRsj/kKoMSsEmob9MX9jBwGmSXhDNFkzasJ5hJRKgFL
	xyVLONj6JxT4zSTu5eC06tHdBpm9MiNpPclsBMKBfQpwKbTMvksr35jFibZA9SKdqAvsDt+z9Y0b4
	qqwNjEYEQ2Lp1EXvHFvpZ1A2x3pBShgbvU32YaVLOxmwJ0+AlT4UbtrWdCZJ64M/LtK/+arfc/uTm
	4MRnKiAw==;
Received: from pool-174-115-41-146.cpe.net.cable.rogers.com ([174.115.41.146]:58410 helo=asus)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1uaIXH-00000001emb-2dYG
	for bitbake-devel@lists.openembedded.org;
	Fri, 11 Jul 2025 14:31:54 -0400
Date: Fri, 11 Jul 2025 14:31:50 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: is there a short form of "What provides this functionality?"
Message-ID: <a977af08-881d-badb-527c-c8c17ddc2845@crashcourse.ca>
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
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Jul 2025 18:32:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17769


  Not sure if there's a BB helper script where I can query:

"Which recipes PROVIDE this functionality?"

Like:

  $ bitbake-what-provides udev

that sort of thing. Does such a thing exist?

rday

