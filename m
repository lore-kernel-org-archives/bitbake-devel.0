Return-Path: <Karim.benhoucine@landisgyr.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AA7E71D2A
	for <webhook@archiver.kernel.org>; Fri, 29 Sep 2023 12:37:18 +0000 (UTC)
Received: from mail.landisgyr.com (mail.landisgyr.com [213.95.165.69])
 by mx.groups.io with SMTP id smtpd.web11.16061.1695991029824906915
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Sep 2023 05:37:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: landisgyr.com, ip: 213.95.165.69, mailfrom: karim.benhoucine@landisgyr.com)
Received: from FRMONPC1177.eu.bm.net (unknown [10.49.130.40])
	by mail.landisgyr.com (Postfix) with ESMTP id 380EF1CD882BA;
	Fri, 29 Sep 2023 14:37:08 +0200 (CEST)
From: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
To: bitbake-devel@lists.openembedded.org
Cc: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
Subject: [PATCH] hashserv: Fix read-only mode.
Date: Fri, 29 Sep 2023 14:37:06 +0200
Message-Id: <20230929123706.454384-1-karim.benhoucine@landisgyr.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Sep 2023 12:37:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15149

Signed-off-by: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
---
 lib/hashserv/server.py | 55 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index d40a2ab8..56d76f1f 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -180,7 +180,11 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection=
):
             'get-stats': self.handle_get_stats,
         })
=20
-        if not read_only:
+        if read_only:
+            self.handlers.update({   =20
+                'report': self.handle_readonly_report,
+            })
+        else:
             self.handlers.update({
                 'report': self.handle_report,
                 'report-equiv': self.handle_equivreport,
@@ -453,6 +457,55 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection=
):
=20
         self.write_message(d)
=20
+
+    async def handle_readonly_report(self, data):
+        with closing(self.db.cursor()) as cursor:
+            outhash_data =3D {
+                'method': data['method'],
+                'outhash': data['outhash'],
+                'taskhash': data['taskhash'],
+                'created': datetime.now()
+            }
+
+            for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginf=
o'):
+                if k in data:
+                    outhash_data[k] =3D data[k]=20
+
+            # Check if outhash is known
+            cursor.execute(
+                '''
+                SELECT outhashes_v2.taskhash AS taskhash, unihashes_v2.u=
nihash AS unihash FROM outhashes_v2
+                INNER JOIN unihashes_v2 ON unihashes_v2.method=3Douthash=
es_v2.method AND unihashes_v2.taskhash=3Douthashes_v2.taskhash
+                -- Select any matching output hash
+                WHERE outhashes_v2.method=3D:method AND outhashes_v2.out=
hash=3D:outhash
+                -- Pick the oldest hash
+                ORDER BY outhashes_v2.created ASC
+                LIMIT 1
+                ''',
+                {
+                    'method': data['method'],
+                    'outhash': data['outhash'],
+                    'taskhash': data['taskhash'],
+                }
+            )
+            row =3D cursor.fetchone()
+            if row is not None:=20
+                # outhash is known =3D> corrects unihash
+                unihash =3D row['unihash']=20
+            else:
+                # outhash is unknown =3D> nothing to do
+                unihash =3D outhash_data['taskhash']=20
+           =20
+
+            d =3D {
+                'taskhash': data['taskhash'],
+                'method': data['method'],
+                'unihash': unihash,
+            }
+
+        self.write_message(d)
+       =20
+
     async def handle_equivreport(self, data):
         with closing(self.db.cursor()) as cursor:
             insert_data =3D {
--=20
2.25.1


