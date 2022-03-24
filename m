Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C86AC433F5
	for <webhook@archiver.kernel.org>; Thu, 24 Mar 2022 10:59:42 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by mx.groups.io with SMTP id smtpd.web08.9321.1648119580459621582
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Mar 2022 03:59:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=l4SYrBR5;
 spf=pass (domain: intel.com, ip: 134.134.136.65,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648119580; x=1679655580;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tA2PhHtjXJTB47Z2Z8fmYR7MG2NEXQP2dp9SM5T0DAA=;
  b=l4SYrBR5XUcGPnUf7werOgJI0srbNOYTeYLJDAaOIdJP6S3vTwfNmbSA
   e3YOHj13sQwCezKa9+D2g3eVYLIqqc75QIMREtnMbBTg5uADjxgyHepCE
   NDkt5Wk8iZhFp1imeODmoLWFI6Hjwo8UO+XW0bn+pSiL68l4ZrySYo8UU
   1JFCCCuWw8Atq8qcBkJpWt9PBoDc2Two/3ur2naJeiQDH0ggxZZiE9KR7
   GionUKKYKXjso8sbzo/Elp7DNsPQ5JyuaXG/VOKMXDr8kR902degV0l03
   tJkhXX5VjjJAbYZMTHXtz7f354kAoiF0r5O5RXooFgKPuPIoovhD+9n6n
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258299388"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400";
   d="scan'208";a="258299388"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2022 03:59:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400";
   d="scan'208";a="584037582"
Received: from yeeweita-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.213.139.46])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2022 03:59:25 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH] build: Tweak exception handling for setscene tasks
Date: Thu, 24 Mar 2022 18:59:20 +0800
Message-Id: <20220324105920.6586-1-anuj.mittal@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Mar 2022 10:59:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13500

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If an unexpected exception occurs in a setscene task, it is currently hidden
from the user and not recorded in any logs. This isn't helpful to debug
such failures.

Change the code so that even in the "silent" or "quiet" task case (setscene
tasks), a warning is shown with the traceback unless it was an "handled"
exception. This means the failing function can show it's own warning/error
instead if it wants to and then raise a handled event.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 41dcdc61eb40def8c14a42e8d7bb9ce5a34afa57)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/build.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 7e4ab9f6..44d1d9d9 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -715,19 +715,23 @@ def _exec_task(fn, task, d, quieterr):
                 logger.debug2("Zero size logfn %s, removing", logfn)
                 bb.utils.remove(logfn)
                 bb.utils.remove(loglink)
-    except bb.BBHandledException:
-        event.fire(TaskFailed(task, fn, logfn, localdata, True), localdata)
-        return 1
     except (Exception, SystemExit) as exc:
+        handled = False
+        if isinstance(exc, bb.BBHandledException):
+            handled = True
+
         if quieterr:
+            if not handled:
+                logger.warning(repr(exc))
             event.fire(TaskFailedSilent(task, fn, logfn, localdata), localdata)
         else:
             errprinted = errchk.triggered
             # If the output is already on stdout, we've printed the information in the
             # logs once already so don't duplicate
-            if verboseStdoutLogging:
+            if verboseStdoutLogging or handled:
                 errprinted = True
-            logger.error(repr(exc))
+            if not handled:
+                logger.error(repr(exc))
             event.fire(TaskFailed(task, fn, logfn, localdata, errprinted), localdata)
         return 1
 
-- 
2.35.1


