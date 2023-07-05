Return-Path: <denis@denix.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5BBEB64DA
	for <webhook@archiver.kernel.org>; Wed,  5 Jul 2023 21:55:46 +0000 (UTC)
Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.web10.7763.1688594140421236018
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Jul 2023 14:55:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id 25B1940C50;
	Wed,  5 Jul 2023 21:55:39 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lki6gPJxxv6G; Wed,  5 Jul 2023 21:55:39 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-88-116.washdc.fios.verizon.net [100.15.88.116])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id 0A56340C16;
	Wed,  5 Jul 2023 21:55:37 +0000 (UTC)
Received: from thorin.han-sole.ts.net (thorin.denix [192.168.30.9])
	by mail.denix.org (Postfix) with ESMTP id A9810163B32;
	Wed,  5 Jul 2023 17:55:37 -0400 (EDT)
From: Denys Dmytriyenko <denis@denix.org>
To: bitbake-devel@lists.openembedded.org
Cc: Denys Dmytriyenko <denis@denix.org>,
	Denys Dmytriyenko <denys@konsulko.com>
Subject: [PATCH] runqueue: convert deferral messages from bb.note to bb.debug
Date: Wed,  5 Jul 2023 21:55:33 +0000
Message-Id: <20230705215533.327107-1-denis@denix.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Jul 2023 21:55:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14875

Using multiconfig to target baremetal pieces of the system and building
corresponding toolchains for them results in hundreds and hundreds of
"Deferring %s after %s" and "Deferred task %s now buildable".

To clean up the output and to reduce risk of missing important warnings,
convert these notice messages to debug messages.

Signed-off-by: Denys Dmytriyenko <denis@denix.org>
Signed-off-by: Denys Dmytriyenko <denys@konsulko.com>
---
 lib/bb/runqueue.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 241a746e..a5164c9e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1997,12 +1997,12 @@ class RunQueueExecute:
                 # Allow the next deferred task to run. Any other deferre=
d tasks should be deferred after that task.
                 # We shouldn't allow all to run at once as it is prone t=
o races.
                 if not found:
-                    bb.note("Deferred task %s now buildable" % t)
+                    bb.debug(1, "Deferred task %s now buildable" % t)
                     del self.sq_deferred[t]
                     update_scenequeue_data([t], self.sqdata, self.rqdata=
, self.rq, self.cooker, self.stampcache, self, summary=3DFalse)
                     found =3D t
                 else:
-                    bb.note("Deferring %s after %s" % (t, found))
+                    bb.debug(1, "Deferring %s after %s" % (t, found))
                     self.sq_deferred[t] =3D found
=20
     def task_complete(self, task):
@@ -2940,7 +2940,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooke=
r, stampcache, sqrq):
                 sqdata.hashes[h] =3D tid
             else:
                 sqrq.sq_deferred[tid] =3D sqdata.hashes[h]
-                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[h]=
))
+                bb.debug(1, "Deferring %s after %s" % (tid, sqdata.hashe=
s[h]))
=20
     update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cooker=
, stampcache, sqrq, summary=3DTrue)
=20
--=20
2.25.1


