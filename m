Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA4DD6ACF0
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 15:44:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.74722.1732722271441596305
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Nov 2024 07:44:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F302E1477
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Nov 2024 07:45:00 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 932173F58B
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Nov 2024 07:44:30 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bb/build: add a function to list the tasks in a datastore
Date: Wed, 27 Nov 2024 15:44:28 +0000
Message-Id: <20241127154428.775936-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Nov 2024 15:44:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16842

There's no easy way to list all of the tasks in a recipe, you can either
look at __BBTASKS (internal variable, shouldn't be used) or iterate all
items in the datastore looking for variables with the 'task' flag set
(which is slow).

Solve this problem by adding a bb.build.listtasks() function that
returns an immutable copy of the __BBTASSK variable.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/build.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 9f9285de3d6..6e0459d87ab 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -1028,3 +1028,9 @@ def tasksbetween(task_start, task_end, d):
         chain.pop()
     follow_chain(task_start, task_end)
     return outtasks
+
+def listtasks(d):
+    """
+    Return the list of tasks in the current recipe.
+    """
+    return tuple(d.getVar('__BBTASKS', False) or ())
--=20
2.34.1


