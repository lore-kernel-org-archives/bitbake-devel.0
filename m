Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30C6C433F5
	for <webhook@archiver.kernel.org>; Sat, 13 Nov 2021 17:58:03 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web12.36.1636826282574895796
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Nov 2021 09:58:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57,
 mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net ([70.99.78.136])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1ADHw1d5029538
	for <bitbake-devel@lists.openembedded.org>; Sat, 13 Nov 2021 11:58:01 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] utils.py: lockfile(): Catch ENAMETOOLONG
Date: Sat, 13 Nov 2021 11:58:00 -0600
Message-Id: <1636826280-19035-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 13 Nov 2021 17:58:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13041

From: Mark Hatle <mark.hatle@xilinx.com>

When the filename was too long, the system would loop forever causing a
hang.  Instead we need to just drop out, as we can't correct a filename
that is too long.

Signed-off-by: Mark Hatle <mark.hatle@xilinx.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 7063491..0343b08 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -487,7 +487,7 @@ def lockfile(name, shared=False, retry=True, block=False):
                     return lf
             lf.close()
         except OSError as e:
-            if e.errno == errno.EACCES:
+            if e.errno == errno.EACCES or e.errno == errno.ENAMETOOLONG:
                 logger.error("Unable to acquire lock '%s', %s",
                              e.strerror, name)
                 sys.exit(1)
-- 
1.8.3.1


