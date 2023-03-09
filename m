Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8305FC64EC4
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 22:52:35 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.5527.1678402346451288174
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Mar 2023 14:52:27 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from lons-builder.int.hatle.net (76.164.132.203.bevcomm.net [76.164.132.203] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 329MqNH7010422
	for <bitbake-devel@lists.openembedded.org>; Thu, 9 Mar 2023 16:52:24 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH 1/2] wget.py: Add catch TimeoutError exception
Date: Thu,  9 Mar 2023 16:52:20 -0600
Message-Id: <20230309225221.273750-2-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309225221.273750-1-mark.hatle@kernel.crashing.org>
References: <20230309225221.273750-1-mark.hatle@kernel.crashing.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Mar 2023 22:52:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14535

We've observed TimeoutError exceptions during the sstate-cache mirror fetch,
it appears that due to the number of (invalid) files requested the remote
side is eventually dropping the connection (not closing it) which can result
in a TimeoutError exception being sent, while rate it is different from the
urllib.error.URLError or ConnectionResetError.

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 bitbake/lib/bb/fetch2/wget.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 859b4f99e2d..927487a0b66 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -385,6 +385,14 @@ class Wget(FetchMethod):
                     # debug for now to avoid spamming the logs in e.g. remote sstate searches
                     logger.debug2("checkstatus() urlopen failed: %s" % e)
                     return False
+            except TimeoutError as e:
+                if try_again:
+                    logger.debug2("checkstatus: trying again")
+                    return self.checkstatus(fetch, ud, d, False)
+                else:
+                    # debug for now to avoid spamming the logs in e.g. remote sstate searches
+                    logger.debug2("checkstatus() urlopen TimeoutError: %s" % e)
+                    return False
 
         return True
 
-- 
2.25.1


