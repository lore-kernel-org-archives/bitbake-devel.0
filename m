Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2DDC8303C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 12:01:49 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.web11.58751.1751889705151026131
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Jul 2025 05:01:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=guTDBwUs;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dWnQpRIje4oGlYaj+gv4OpRxl2o1t4KL7hgtGLk/SRI=; b=guTDBwUsTl3q86S1xqD0epIviO
	z1n5rKmSA7E6WhMTEyMN/6Mlm0mQI41ez8s/ybxxHyJ/xdcHNTKBMX8ODus7TqKmgp0Kpjkk+sAU7
	+fFNAzsos3jhwj+Q7MhEzdpyEMOA4h7i2SLeJ3+KyzRH6cuHMhyDLppaWFSZ/5QxwoVMezB0neYDq
	KxHVwceWKoBxxtmLruORVSj3jUA/TPEASbtKMNEor6U7ezPDRvGiAWNmsdX+461BEVksKvp48RYcI
	JWQwYhN7bnohEjEzayEx+UzYKldGNkQqhUPwnrraseppFDnRU0sHchar4CX2Cr79LVXtHIVUlVLXT
	3HXF31dQ==;
Received: from pool-174-114-102-5.cpe.net.cable.rogers.com ([174.114.102.5]:53596 helo=asus)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1uYkXR-00000003EML-3wA4;
	Mon, 07 Jul 2025 08:01:43 -0400
Date: Mon, 7 Jul 2025 08:01:29 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: YP docs mailing list <docs@lists.yoctoproject.org>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] bitbake: add examples to show general wildcarding
Message-ID: <aba74ec2-cda4-9e59-f0ad-e512ab2d60ed@crashcourse.ca>
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
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Jul 2025 12:01:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17751


Add a couple more examples to the wildcarding section to make sure
readers understand it's not just a single character wildcard.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 539bb62d8..98f152df8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -258,6 +258,8 @@ the append file would match the following recipe names::
   busybox_1.21.1.bb
   busybox_1.21.2.bb
   busybox_1.21.3.bb
+  busybox_1.21.10.bb
+  busybox_1.21.11.bb

 .. note::


