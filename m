Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB69C433FE
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 02:25:06 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web10.1441.1637547896753547701
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Nov 2021 18:25:06 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.43, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="320933709"
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="320933709"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:25:05 -0800
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="588848709"
Received: from kkleong1-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.239.135])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:25:04 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 7/8] cooker: Handle parsing results queue race
Date: Mon, 22 Nov 2021 10:24:48 +0800
Message-Id: 
 <d0fe9d4efa81bc67e6b0d64c9fe58a4115b0c4d8.1637547674.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637547674.git.anuj.mittal@intel.com>
References: <cover.1637547674.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Nov 2021 02:25:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13091

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
index c952c574..e2a5dc43 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2214,24 +2214,28 @@ class CookerParser(object):
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


