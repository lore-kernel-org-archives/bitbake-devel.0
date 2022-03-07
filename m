Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85596C433EF
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 13:36:33 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web12.26226.1646660188410132596
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 05:36:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=IFPTB3gd;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646660188;
  x=1678196188;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cxKOkc7Rlw8indzK/uW7BzcZZCWEsA4+5AMbh+hZSLc=;
  b=IFPTB3gdol2Y13n2XnlS/b81+OII5UGNZKykyFNKaNkupb/60Vuahion
   rjB2xv4FzOgCXon8kwfgi/VvKrGNMAjqCDPLPyHgHE2w3pYyunsZwWPfh
   33o7CnOmN4CzFWeaai2TImN36trPsf0ThIsM4IKCsfFPUlZcmdeeKJCqZ
   shrKFX1HhPt7HOx2e/rne9vidtq5B5+J3n21/pfz2oNTQbWko2FaSFkFD
   7091kcmeA2utJibL//gBu9h4gdaiYoL3UtdUHL765shagPNa1wZKycYMb
   D6f5o4y/RUbjEqT4OhHSruig/W2jSIq2xQnIvPji6V1sgszIY3zxq0wHb
   A==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/3] knotty.py: Improve the message while waiting for running
 tasks to finish
Date: Mon, 7 Mar 2022 14:36:18 +0100
Message-ID: <20220307133620.12404-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 13:36:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13428

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

Use pluralise() to correct the grammar, and drop the colon at the end if
runnning in quiet mode.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/ui/knotty.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index b02e59c1fe..a520895da2 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -272,7 +272,10 @@ class TerminalFilter(object):
                     tasks.append("%s (pid %s)" % (activetasks[t]["title"], activetasks[t]["pid"]))
 
         if self.main.shutdown:
-            content = "Waiting for %s running tasks to finish:" % len(activetasks)
+            content = pluralise("Waiting for %s running task to finish",
+                                "Waiting for %s running tasks to finish", len(activetasks))
+            if not self.quiet:
+                content += ':'
             print(content)
         else:
             if self.quiet:

