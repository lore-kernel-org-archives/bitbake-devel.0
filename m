Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A32C433FE
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 14:50:43 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mx.groups.io with SMTP id smtpd.web12.13084.1636469435357316700
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 06:50:42 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.31, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="293287556"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800";
   d="scan'208";a="293287556"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 06:50:42 -0800
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800";
   d="scan'208";a="588760047"
Received: from chinboon-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.215.234.207])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 06:50:41 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 5/7] cooker: Handle parse threads disappearing to avoid
 hangs
Date: Tue,  9 Nov 2021 22:50:26 +0800
Message-Id: 
 <446269bcf62addbe55f6abee3b81a882f2fe2b94.1636469164.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1636469164.git.anuj.mittal@intel.com>
References: <cover.1636469164.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 14:50:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12978

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If one of the parse threads disappears during parsing for some reason, bitbake
currently hangs. Avoid this (and zombie threads hanging around) by joining()
threads which have exited.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit dc86a533d951d13643ce446533370da804782afc)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/cooker.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 06b40c138..8ae8e4ecc 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2040,6 +2040,7 @@ class Parser(multiprocessing.Process):
                 result = pending.pop()
             else:
                 try:
+                    time.sleep(0.25)
                     job = self.jobs.pop()
                 except IndexError:
                     self.results.close()
@@ -2218,7 +2219,7 @@ class CookerParser(object):
             yield not cached, mc, infos
 
     def parse_generator(self):
-        while True:
+        while self.processes:
             if self.parsed >= self.toparse:
                 break
 
@@ -2232,6 +2233,14 @@ class CookerParser(object):
                     raise value
                 else:
                     yield result
+            for process in self.processes.copy():
+                if not process.is_alive():
+                    process.join()
+                    self.processes.remove(process)
+
+        if not (self.parsed >= self.toparse):
+            raise bb.parse.ParseError("Not all recipes parsed, parser thread killed/died? Exiting.", None)
+
 
     def parse_next(self):
         result = []
-- 
2.31.1


