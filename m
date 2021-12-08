Return-Path: <amikan@ilbers.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD03AC433F5
	for <webhook@archiver.kernel.org>; Wed,  8 Dec 2021 16:57:48 +0000 (UTC)
Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web09.16193.1638982667364308385
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Dec 2021 08:57:48 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: amikan@ilbers.de)
Received: from localhost.localdomain
 (mm-83-49-214-37.mgts.dynamic.pppoe.byfly.by [37.214.49.83] (may be forged))
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8) with ESMTPSA id 1B8Gvguo010802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Dec 2021 17:57:44 +0100
From: Anton Mikanovich <amikan@ilbers.de>
To: bitbake-devel@lists.openembedded.org
Cc: Anton Mikanovich <amikan@ilbers.de>
Subject: [PATCH] process: Do not mix stderr with stdout
Date: Wed,  8 Dec 2021 19:57:36 +0300
Message-Id: <20211208165736.194174-1-amikan@ilbers.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Dec 2021 16:57:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13143

We should not redirect stderr to stdout if we need to get separated
stdout and stderr contents from Popen.communicate() later.

Signed-off-by: Anton Mikanovich <amikan@ilbers.de>
---
 lib/bb/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/process.py b/lib/bb/process.py
index d5a1775f..af5d804a 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -60,7 +60,7 @@ class Popen(subprocess.Popen):
         "close_fds": True,
         "preexec_fn": subprocess_setup,
         "stdout": subprocess.PIPE,
-        "stderr": subprocess.STDOUT,
+        "stderr": subprocess.PIPE,
         "stdin": subprocess.PIPE,
         "shell": False,
     }
-- 
2.25.1


