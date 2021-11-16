Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF9CC433EF
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 16:27:48 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by mx.groups.io with SMTP id smtpd.web08.319.1637080066468883180
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Nov 2021 08:27:47 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.20, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="220936567"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800";
   d="scan'208";a="220936567"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 08:27:11 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800";
   d="scan'208";a="506500474"
Received: from mmohdso1-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.237.91])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 08:27:07 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 1/4] cooker: Handle parse threads disappearing to avoid
 hangs
Date: Wed, 17 Nov 2021 00:26:57 +0800
Message-Id: 
 <920111a330be59e5be2068a8f1a9edcbc6c14402.1637079892.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637079892.git.anuj.mittal@intel.com>
References: <cover.1637079892.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 16:27:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13061

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
index 06b40c13..8ae8e4ec 100644
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
2.33.1


