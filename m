Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559E5C5DF7C
	for <webhook@archiver.kernel.org>; Sun, 16 Aug 2026 22:15:21 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18818.1786918513652759509
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 16 Aug 2026 15:15:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=e64wzUK5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1329275-202608162215105e922d17a30002071e-hafgv4@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202608162215105e922d17a30002071e
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 17 Aug 2026 00:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QHLo+BKxXu33FplVcx1AVuUamysT79lwxjYsH68bsdc=;
 b=e64wzUK5F31dvZFnwaBqRizcurUfJJIJhg7zyLkOxzAsyi8yAvknU15n82C/ZQJ9cuV70f
 AiKqDaYrFW28SMGt6iP3K59MC4uNR9wtKO/McRXYV96Zd+sgmxjN3rUN6LRJEl+s018C/3bD
 pgmm3PBHRrg/3uM5qHjAAWdf9mdo7W1UJpuBxMdM7ZdfctasJk4ZjsdoM4Xwmez2j8QTWdE0
 ZPi4cbykZHVh7QqRycHIgs9ddV2uuLnpp2801GMLB1CcS24DMYCeCvZK3UHAMCuOwFwkkwfa
 n6Ue8T+2GzgH89mgjJfZHc4qQF4SVc4cCEpV3AJ2XKsnBrUrSdEobjzA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 1/8] cooker: fix bitbake -b silently ignoring bbappends
Date: Mon, 17 Aug 2026 00:14:40 +0200
Message-ID: <20260816221507.155861-2-adrian.freihofer@siemens.com>
In-Reply-To: <20260816221507.155861-1-adrian.freihofer@siemens.com>
References: <20260816221507.155861-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 16 Aug 2026 22:15:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19958

From: Adrian Freihofer <adrian.freihofer@siemens.com>

"bitbake -b <recipe.bb>" builds the recipe without applying any of its
.bbappend files.

buildFileInternal() resolves appends via
self.collections[mc].get_file_appends(fn), but self.collections[mc] is
only ever filled in by collect_bbfiles(), called from updateCache() -
a path -b deliberately skips. matchFiles(), the one -b-path function
that does call collect_bbfiles(), built a fresh CookerCollectFiles into
a throwaway local instead of self.collections[mc], so the append list
stayed empty (or, on a memory-resident server, stale from the last
full parse - e.g. missing a devtool/externalsrc workspace .bbappend
added since). Nothing warns that the built metadata differs from disk.

Make matchFiles() refresh self.collections[mc] itself so the later
append lookup for the same fn sees the same fresh collection.

AI-Generated: Uses GitHub Copilot

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/cooker.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4b6ba3196..108551a60 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1322,8 +1322,10 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
         if bf.startswith("/") or bf.startswith("../"):
             bf = os.path.abspath(bf)
 
-        collections = {mc: CookerCollectFiles(self.bbfile_config_priorities, mc)}
-        filelist, masked, searchdirs = collections[mc].collect_bbfiles(self.databuilder.mcdata[mc], self.databuilder.mcdata[mc])
+        # The only place the "bitbake -b" path fills in the bbappends which
+        # buildFileInternal() then reads back from self.collections[mc].
+        self.collections[mc] = CookerCollectFiles(self.bbfile_config_priorities, mc)
+        filelist, masked, searchdirs = self.collections[mc].collect_bbfiles(self.databuilder.mcdata[mc], self.databuilder.mcdata[mc])
         try:
             os.stat(bf)
             bf = os.path.abspath(bf)
-- 
2.55.0


