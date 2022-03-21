Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9878C4332F
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 05:02:25 +0000 (UTC)
Received: from mail1.wrs.com (mail1.wrs.com [147.11.3.146])
 by mx.groups.io with SMTP id smtpd.web12.26772.1647838944612298066
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 20 Mar 2022 22:02:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid
 domain name (domain: windriver.com, ip: 147.11.3.146,
 mailfrom: david.reyna@windriver.com)
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
	by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 22L52NGM006439
	(version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Sun, 20 Mar 2022 22:02:23 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com
 [147.11.82.252])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 22L52MAl009969
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
 Sun, 20 Mar 2022 22:02:23 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 20 Mar 2022 22:02:22 -0700
Received: from ala-lpggp2.wrs.com (147.11.105.123) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Sun, 20 Mar 2022 22:02:22 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/2] toaster: race condition for end-of-build
Date: Sun, 20 Mar 2022 22:02:21 -0700
Message-ID: 
 <e01517623fbed0d9e9f3b59acf0f0d9aaea38107.1647836508.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1647836508.git.David.Reyna@windriver.com>
References: <cover.1647836508.git.David.Reyna@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Mar 2022 05:02:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13488

From: David Reyna <David.Reyna@windriver.com>

Force a sync point for end-of build event handler force
the build's outcome status commit, to resolve a race
condition with the build completion takedown.

[YOCTO #14765]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/bb/ui/buildinfohelper.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 8fef663469..0761f73b3b 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -227,6 +227,12 @@ class ORMWrapper(object):
         build.completed_on = timezone.now()
         build.outcome = outcome
         build.save()
+
+        # We force a sync point here to force the outcome status commit,
+        # which resolves a race condition with the build completion takedown
+        transaction.set_autocommit(True)
+        transaction.set_autocommit(False)
+
         signal_runbuilds()
 
     def update_target_set_license_manifest(self, target, license_manifest_path):
-- 
2.17.1


