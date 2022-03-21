Return-Path: <ross@burtonini.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D99C4321E
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 17:01:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.942.1647882067465064675
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Mar 2022 10:01:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6507106F
	for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Mar 2022 10:01:06 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67CE63F66F
	for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Mar 2022 10:01:06 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] knotty: display active tasks when printing keepAlive()
 message
Date: Mon, 21 Mar 2022 17:01:04 +0000
Message-Id: <20220321170104.3371476-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Mar 2022 17:01:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13490

In interactive bitbake sessions it is obvious what tasks are running
when one of them hangs or otherwise takes a long time. However, in
non-interactive sessions (such as automated builds) bitbake just prints
a message saying that it is "still alive" with no clues as to what tasks
are active still.

By simply listing the active tasks when printing the keep alive message,
we don't need to parse the bitbake log to identify which of the tasks
is still active and has presumably hung.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/ui/knotty.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 78888f8bdd3..50dd4229da4 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -228,7 +228,9 @@ class TerminalFilter(object):
=20
     def keepAlive(self, t):
         if not self.cuu:
-            print("Bitbake still alive (%ds)" % t)
+            print("Bitbake still alive (no events for %ds). Active tasks=
:" % t)
+            for t in self.helper.running_tasks:
+                print(t)
             sys.stdout.flush()
=20
     def updateFooter(self):
--=20
2.25.1


