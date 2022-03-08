Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDCBC433EF
	for <webhook@archiver.kernel.org>; Tue,  8 Mar 2022 11:00:50 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web12.6926.1646737247990140564
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Mar 2022 03:00:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=C2Ba4hMM;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646737248;
  x=1678273248;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R3NawtZGi691Dck7rpZFPafTiJ2NUzr8L+x5z2MAg2M=;
  b=C2Ba4hMMmKEfurN9Ib+oEWf+ghWiwNGkiwTPU3uNVlCTn/WwbzEeU3lK
   j9mtjEWbZs/z1Fz5SZzZMXBiL0cTTPauL/3N18RYneAfS8bAmDwYMqMic
   GRprV7SfWEtmnr/SxzkjWqRbft5tiLyuf/dpFYuUP+mlGGNoC2bnZDHEH
   rqCnuNzJW5DGrgXqbupNOK6xi7WTnyerh561uKWvzSRMKIhOTFKjIhPcS
   ADce+BX2yBmENe7HEXogx7z1boHaW2++JLPhyYZ9WBZQuVmO+IPKJOaTw
   /mfgCXUZlM17l5ePuHTFlq8TApOA+bkh49N5UIOukty6Pq3l1fcZp1EwA
   A==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 1/3] knotty.py: Improve the message while waiting for
 running tasks to finish
Date: Tue, 8 Mar 2022 12:00:42 +0100
Message-ID: <20220308110044.2825-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Mar 2022 11:00:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13443

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

Use pluralise() to correct the grammar, and drop the colon at the end if
runnning in quiet mode.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: No changes.

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

