Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E01C433FE
	for <webhook@archiver.kernel.org>; Tue,  8 Mar 2022 14:32:42 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web08.8420.1646749960887976627
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Mar 2022 06:32:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=Q7bK9IxQ;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646749961;
  x=1678285961;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z5RiCvVrMRHSdwo6Qry9yV1UyHuIAbhQzCsupyYd8Uo=;
  b=Q7bK9IxQUiCt8fJg8DEVGVbf219cXXX6FKuqttDenFoZl4fj6V2t77IG
   9oF/7a38kNlY0F5BwLq5tDAbl2CXRg94oR5O16dyxBzP3rukPDry6Lzpl
   DXjfc9/nGZDyn5ghywKHESbLXrNCwGmy/w9TCp83t4rXDq783yBXnjPXP
   whix2oxe1scI1Iss9KbmWRjxqeAk2gb17/LU3FPPTwZOUpsqKS4MPc+jC
   63CZGea9IWZy4QKKRhtCgpfukmxj7gdEvU6yuYOw6AlY1mCOryo3UUPwi
   Fmcl8UFtpBt91d6wBLUXqqG2fPEpeb+mplEAuD0Q39Za5KTP73hNOfQ2h
   w==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv3 1/4] knotty.py: Improve the message while waiting for
 running tasks to finish
Date: Tue, 8 Mar 2022 15:32:30 +0100
Message-ID: <20220308143233.19972-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Mar 2022 14:32:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13446

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

Use pluralise() to correct the grammar, and drop the colon at the end if
runnning in quiet mode.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: No changes.
PATCHv3: No changes.

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

