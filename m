Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A321EC433F5
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 16:27:51 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by mx.groups.io with SMTP id smtpd.web08.319.1637080066468883180
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Nov 2021 08:27:50 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.20, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="220936599"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800";
   d="scan'208";a="220936599"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 08:27:16 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800";
   d="scan'208";a="506500485"
Received: from mmohdso1-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.237.91])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 08:27:10 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 3/4] cooker: Handle parsing results queue race
Date: Wed, 17 Nov 2021 00:26:59 +0800
Message-Id: 
 <8eaddb92a5fd14de6b5995aa92a6eed03b90a252.1637079892.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637079892.git.anuj.mittal@intel.com>
References: <cover.1637079892.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 16:27:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13062

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The previous fix introduced a race where the queue might not be empty
but all the parser processes have exited. Handle this correctly to avoid
occasional errors.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 8e7f2b6500e26610f52d128b48ca0a09bf6fb2cb)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/cooker.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 9be6603f..c032762f 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2218,24 +2218,28 @@ class CookerParser(object):
             yield not cached, mc, infos
 
     def parse_generator(self):
-        while self.processes:
+        empty = False
+        while self.processes or not empty:
+            for process in self.processes.copy():
+                if not process.is_alive():
+                    process.join()
+                    self.processes.remove(process)
+
             if self.parsed >= self.toparse:
                 break
 
             try:
                 result = self.result_queue.get(timeout=0.25)
             except queue.Empty:
+                empty = True
                 pass
             else:
+                empty = False
                 value = result[1]
                 if isinstance(value, BaseException):
                     raise value
                 else:
                     yield result
-            for process in self.processes.copy():
-                if not process.is_alive():
-                    process.join()
-                    self.processes.remove(process)
 
         if not (self.parsed >= self.toparse):
             raise bb.parse.ParseError("Not all recipes parsed, parser thread killed/died? Exiting.", None)
-- 
2.33.1


