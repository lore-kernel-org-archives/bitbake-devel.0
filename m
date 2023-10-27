Return-Path: <denis@denix.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C643C25B48
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 20:48:39 +0000 (UTC)
Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.web10.17197.1698439710053592921
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Oct 2023 13:48:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id C343640CEF;
	Fri, 27 Oct 2023 20:48:28 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sRe87Je77Ip3; Fri, 27 Oct 2023 20:48:28 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-87-159.washdc.fios.verizon.net [100.15.87.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id 84BE840CD5;
	Fri, 27 Oct 2023 20:48:26 +0000 (UTC)
Received: from thorin.denix (thorin.denix [192.168.30.9])
	by mail.denix.org (Postfix) with ESMTP id 94BCB163D25;
	Fri, 27 Oct 2023 16:48:25 -0400 (EDT)
From: Denys Dmytriyenko <denis@denix.org>
To: bitbake-devel@lists.openembedded.org
Cc: Denys Dmytriyenko <denis@denix.org>,
	Denys Dmytriyenko <denys@konsulko.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [kirkstone][PATCH] runqueue: convert deferral messages from bb.note to bb.debug
Date: Fri, 27 Oct 2023 20:48:19 +0000
Message-Id: <20231027204819.3070676-1-denis@denix.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Oct 2023 20:48:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15301

Using multiconfig to target baremetal pieces of the system and building
corresponding toolchains for them results in hundreds and hundreds of
"Deferring %s after %s" and "Deferred task %s now buildable".

To clean up the output and to reduce risk of missing important warnings,
convert these notice messages to debug messages.

Signed-off-by: Denys Dmytriyenko <denis@denix.org>
Signed-off-by: Denys Dmytriyenko <denys@konsulko.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 64bc00a46d1aacc23fe7e8d9a46a126f3a4bc318)
Signed-off-by: Denys Dmytriyenko <denis@denix.org>
---
 lib/bb/runqueue.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 46ff30a7..8605c46c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1980,12 +1980,12 @@ class RunQueueExecute:
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
@@ -2892,7 +2892,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooke=
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


