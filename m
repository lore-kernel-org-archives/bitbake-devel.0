Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978FFE7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 12:08:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.9307.1733918933854080476
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Dec 2024 04:08:53 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AB721692
	for <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 04:09:21 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08E253F5A1
	for <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 04:08:52 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2 2/3] classes/utility-tasks: port do_listtasks to use bb.build.listtasks
Date: Wed, 11 Dec 2024 12:08:46 +0000
Message-ID: <20241211120847.384816-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211120847.384816-1-ross.burton@arm.com>
References: <20241211120847.384816-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 12:08:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16905

Instead of iterating every datastore value by hand to find tasks, use
the new bb.build.listtasks() function (bitbake 185c4b)

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 meta/classes-global/utility-tasks.bbclass | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/meta/classes-global/utility-tasks.bbclass b/meta/classes-glo=
bal/utility-tasks.bbclass
index ae2da330b86..394cc3158d5 100644
--- a/meta/classes-global/utility-tasks.bbclass
+++ b/meta/classes-global/utility-tasks.bbclass
@@ -9,18 +9,17 @@ do_listtasks[nostamp] =3D "1"
 python do_listtasks() {
     taskdescs =3D {}
     maxlen =3D 0
-    for e in d.keys():
-        if d.getVarFlag(e, 'task'):
-            maxlen =3D max(maxlen, len(e))
-            if e.endswith('_setscene'):
-                desc =3D "%s (setscene version)" % (d.getVarFlag(e[:-9],=
 'doc') or '')
-            else:
-                desc =3D d.getVarFlag(e, 'doc') or ''
-            taskdescs[e] =3D desc
-
-    tasks =3D sorted(taskdescs.keys())
-    for taskname in tasks:
-        bb.plain("%s  %s" % (taskname.ljust(maxlen), taskdescs[taskname]=
))
+    for t in bb.build.listtasks(d):
+        maxlen =3D max(maxlen, len(t))
+
+        if t.endswith('_setscene'):
+            desc =3D "%s (setscene version)" % (d.getVarFlag(t[:-9], 'do=
c') or '')
+        else:
+            desc =3D d.getVarFlag(t, 'doc') or ''
+        taskdescs[t] =3D desc
+
+    for task, doc in sorted(taskdescs.items()):
+        bb.plain("%s  %s" % (task.ljust(maxlen), doc))
 }
=20
 CLEANFUNCS ?=3D ""
--=20
2.43.0


