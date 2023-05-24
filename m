Return-Path: <a.baumfalk@astro-kom.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B6CC77B7A
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 12:04:54 +0000 (UTC)
Received: from labor3.labor.astro (labor3.labor.astro [213.196.222.82])
 by mx.groups.io with SMTP id smtpd.web11.6886.1684929892460451622
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 May 2023 05:04:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=fail (domain: astro-kom.de, ip: 213.196.222.82, mailfrom: a.baumfalk@astro-kom.de)
Received: by labor3.labor.astro (Postfix, from userid 516)
	id 40B7640A91; Wed, 24 May 2023 14:04:48 +0200 (CEST)
Subject: [PATCH] fetch2/npm: evaluate PATH before patching HOME
To: <bitbake-devel@lists.openembedded.org>
X-Mailer: mail (GNU Mailutils 3.10)
Message-Id: <20230524120448.40B7640A91@labor3.labor.astro>
Date: Wed, 24 May 2023 14:04:48 +0200 (CEST)
From: Arno Baumfalk <a.baumfalk@astro-kom.de>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 May 2023 12:04:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14803

From 814de5df87fbd39c773177580639bb22862c11a6 Mon Sep 17 00:00:00 2001
From: Arno Baumfalk <a.baumfalk@astro-kom.de>
Date: Tue, 16 May 2023 17:18:26 +0200
Subject: [PATCH] fetch2/npm: evaluate PATH before patching HOME

When the user configures the TMPDIR variable in a way that it contains $HOME (in local.conf), the DataSmart (d) object's PATH variable will also contain $HOME.

As the NpmEnvironment patches HOME with a temporary directory, further evaluation of PATH will become invalid an the build breaks with an error (npm not found).

As countermeasure PATH is evaluated *before* patching HOME.

Signed-off-by: Arno Baumfalk <a.baumfalk@astro-kom.de>
---
 bitbake/lib/bb/fetch2/npm.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/fetch2/npm.py b/bitbake/lib/bb/fetch2/npm.py
index 8a179a339a..e6d0598f5d 100644
--- a/bitbake/lib/bb/fetch2/npm.py
+++ b/bitbake/lib/bb/fetch2/npm.py
@@ -103,6 +103,7 @@ class NpmEnvironment(object):
         """Run npm command in a controlled environment"""
         with tempfile.TemporaryDirectory() as tmpdir:
             d = bb.data.createCopy(self.d)
+            d.setVar("PATH", d.getVar("PATH"))  # PATH might contain $HOME - evaluate it before patching
             d.setVar("HOME", tmpdir)
 
             if not workdir:
-- 
2.40.1


