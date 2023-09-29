Return-Path: <Karim.benhoucine@landisgyr.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC84E71D31
	for <webhook@archiver.kernel.org>; Fri, 29 Sep 2023 13:16:08 +0000 (UTC)
Received: from mail.landisgyr.com (mail.landisgyr.com [213.95.165.69])
 by mx.groups.io with SMTP id smtpd.web10.16881.1695993358735723038
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Sep 2023 06:15:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: landisgyr.com, ip: 213.95.165.69, mailfrom: karim.benhoucine@landisgyr.com)
Received: from FRMONPC1177.eu.bm.net (unknown [10.49.130.40])
	by mail.landisgyr.com (Postfix) with ESMTP id 4F2586D63D;
	Fri, 29 Sep 2023 15:15:57 +0200 (CEST)
From: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
To: bitbake-devel@lists.openembedded.org
Cc: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
Subject: [PATCH] hashserv: Fix read-only mode.
Date: Fri, 29 Sep 2023 15:14:47 +0200
Message-Id: <20230929131447.455388-1-karim.benhoucine@landisgyr.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929123706.454384-1-karim.benhoucine@landisgyr.com>
References: <20230929123706.454384-1-karim.benhoucine@landisgyr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Sep 2023 13:16:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15150

TCP read-only hash equivalence server is not working: the connection is p=
rematurely closed without even notifying the value of the unihash.
Expected behaviour is:
    1. the client sends a =E2=80=98report=E2=80=99 message indicating the=
 'taskhash', 'method', 'outhash' and a proposed value of 'unihash'.
    2.the server sends back the 'taskhash', 'method' and actual value of =
'unihash' to use.
The problem is that in read-only mode, the server rejects 'report' messag=
es (connexion is closed).

The proposed fix consists in enabling =E2=80=98report=E2=80=99 messages i=
n read-only mode using a specific handler that doesn=E2=80=99t modify the=
 hash equivalence database.

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


