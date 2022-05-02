Return-Path: <rhi@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152E4C433F5
	for <webhook@archiver.kernel.org>; Mon,  2 May 2022 12:40:29 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by mx.groups.io with SMTP id smtpd.web10.10009.1651495219102498898
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 May 2022 05:40:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: pengutronix.de, ip: 85.220.165.71, mailfrom: rhi@pengutronix.de)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1nlVLd-0005Ul-BM; Mon, 02 May 2022 14:40:17 +0200
Received: from rhi by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1nlVLd-0004pl-2W; Mon, 02 May 2022 14:40:17 +0200
Date: Mon, 2 May 2022 14:40:17 +0200
From: Roland Hieber <rhi@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Roland Hieber <rhi@pengutronix.de>
Subject: [RESEND][PATCH] cache: correctly handle file names containing colons
Message-ID: <20220502124017.53o2luwkeyjcbh4m@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailer: git-send-email 2.30.2
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 May 2022 12:40:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13668

File names containing colons cause split() to return a list with more
than two elements, which will lead to a stack trace ending in:

    ValueError: too many values to unpack (expected 2)

Split only once at the last colon, thereby making sure that only two
elements are returned.
---
 lib/bb/cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index fcb15796ccbe..92e9a3ced7df 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -619,7 +619,7 @@ class Cache(NoCache):
                 for f in flist:
                     if not f:
                         continue
-                    f, exist = f.split(":")
+                    f, exist = f.rsplit(":", 1)
                     if (exist == "True" and not os.path.exists(f)) or (exist == "False" and os.path.exists(f)):
                         self.logger.debug2("%s's file checksum list file %s changed",
                                              fn, f)
-- 
2.30.2



