Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9FEC433EF
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 02:25:03 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web10.1441.1637547896753547701
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Nov 2021 18:25:03 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.43, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="320933703"
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="320933703"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:25:02 -0800
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="588848675"
Received: from kkleong1-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.239.135])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:25:01 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 5/8] cooker: Handle parse threads disappearing to avoid
 hangs
Date: Mon, 22 Nov 2021 10:24:46 +0800
Message-Id: 
 <fc4a8dbed4174e07534666860466173a171aae73.1637547674.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637547674.git.anuj.mittal@intel.com>
References: <cover.1637547674.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Nov 2021 02:25:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13089

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
index b041d2a0..f12f4caa 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2036,6 +2036,7 @@ class Parser(multiprocessing.Process):
                 result = pending.pop()
             else:
                 try:
+                    time.sleep(0.25)
                     job = self.jobs.pop()
                 except IndexError:
                     self.results.close()
@@ -2214,7 +2215,7 @@ class CookerParser(object):
             yield not cached, mc, infos
 
     def parse_generator(self):
-        while True:
+        while self.processes:
             if self.parsed >= self.toparse:
                 break
 
@@ -2228,6 +2229,14 @@ class CookerParser(object):
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


