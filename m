Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014B6E94133
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 09:16:10 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.61213.1767086157383477332
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Dec 2025 01:15:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=mETRMi1w;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-20251230091554c08f902d2f00020792-lvcnhj@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251230091554c08f902d2f00020792
        for <bitbake-devel@lists.openembedded.org>;
        Tue, 30 Dec 2025 10:15:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zZu5KERQdkV5OYkHjhrtWM64vgD0FMCgN/WqF758chI=;
 b=mETRMi1wWpute/i5HAxbXyafadMO2w6EAkRUwHBOzFnFsDKAGZWvLvLtMpWl+MGdKqURIQ
 /JnGoqsat3Bp6XTv9QatprRPT6NO91SKxHZgXyR0gNSFTFpXN+BTfsEKtLqUdphmJP2MJdD1
 hqIPIXwZRMTAIZXpR0YV1RI4KZF3+1nHNfLbs//pyI5RFLOxXDDzgvtIs3aZTGSC2d9OGCn+
 O0xTikjNOzf+quyFK6dnb+WU9XAuN2nWbOUzrfKkTZwQzN6k4861CbSwAklZDK02Y2g8LYVb
 eTfCXDFki1e5Sg+jm5uObXlpfXdrK6RZQoN0YbP7Ll3lIymy/FThcVCw==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 1/1] tests/runqueue: cover --skip-deps
Date: Tue, 30 Dec 2025 10:15:16 +0100
Message-ID: <20251230091530.2373504-2-adrian.freihofer@siemens.com>
In-Reply-To: <20251230091530.2373504-1-adrian.freihofer@siemens.com>
References: <20251230091530.2373504-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Dec 2025 09:16:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18658

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add a test case to verify that --skip-deps leads to only the specified
task being run.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/runqueue.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 74f5ded2e..231153cab 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -403,6 +403,15 @@ class RunQueueTests(unittest.TestCase):
 
             self.shutdown(tempdir)
 
+    def test_skip_deps(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "a1", "-c", "install", "--skip-deps"]
+            tasks = self.run_bitbakecmd(cmd, tempdir)
+            expected = ['a1:install']
+            self.assertEqual(set(tasks), set(expected))
+
+            self.shutdown(tempdir)
+
     def shutdown(self, tempdir):
         # Wait for the hashserve socket to disappear else we'll see races with the tempdir cleanup
         while (os.path.exists(tempdir + "/hashserve.sock") or os.path.exists(tempdir + "cache/hashserv.db-wal") or os.path.exists(tempdir + "/bitbake.lock")):
-- 
2.52.0


