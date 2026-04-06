Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009BAFB516E
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 20:24:58 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.64392.1775507090673394121
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Apr 2026 13:24:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=QQw6C7GB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1329275-20260406202447545c94bad40002070a-xeavrq@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260406202447545c94bad40002070a
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 06 Apr 2026 22:24:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7PSgRWOmR8JcsODRbLUsEIQe9zRpa7KzJLaBPRpZOsA=;
 b=QQw6C7GBlIuKfMREGVgs0sWpiy2Jg1fT/c6NkePSI8fsHT0rn6KvdoTVkkn9H7d4LbJRuI
 sgIlyECAYh0s4XllxfsORrxQySruqHZUQQbN6FAS6vGlf7I/EWFJqHpGraVUzBeUgmHLHsX5
 EbHwj9ZFachX2HN7wOZpv3Zmd6t/995iyJ7OdpvvWCpMxtGD8MItHH4L+iaE1kNomGFxbVOJ
 zlJOwGMHEXULNwVleRNmBqwYNp2i0tJvALsSuaBNJ7YxXIAoatWh2ojS6IRMDQ+AUgecgc4T
 GsgbESqPXkL1cwA7EPxSBpdxr9Z7U+5hAPiqqusdorSOwRHJjCK4wH2g==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 1/4] bitbake-setup: update vscode workspace always
Date: Mon,  6 Apr 2026 22:24:02 +0200
Message-ID: <20260406202430.1856836-2-adrian.freihofer@siemens.com>
In-Reply-To: <20260406202430.1856836-1-adrian.freihofer@siemens.com>
References: <20260406202430.1856836-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Apr 2026 20:24:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19332

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Update the vscode workspace file with the current build directory, even
if the configuration in the registry has not changed. This allows to
keep the workspace file up to date when the build directory is changed
manually.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index c006a059c..5a3394092 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -956,6 +956,11 @@ def build_status(top_dir, settings, args, d, update=False):
         return
 
     logger.plain("\nConfiguration in {} has not changed.".format(setupdir))
+    if update:
+        workspace_file = os.path.join(setupdir, "bitbake.code-workspace")
+        if os.path.exists(workspace_file):
+            bitbake_builddir = os.path.join(setupdir, "build")
+            configure_vscode(setupdir, layerdir, bitbake_builddir, os.path.join(bitbake_builddir, "init-build-env"))
 
 def build_update(top_dir, settings, args, d):
     build_status(top_dir, settings, args, d, update=True)
-- 
2.53.0


