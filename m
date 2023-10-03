Return-Path: <Karim.benhoucine@landisgyr.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03598E75434
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 06:56:36 +0000 (UTC)
Received: from mail.landisgyr.com (mail.landisgyr.com [213.95.165.69])
 by mx.groups.io with SMTP id smtpd.web10.103136.1696316189482950042
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Oct 2023 23:56:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: landisgyr.com, ip: 213.95.165.69, mailfrom: karim.benhoucine@landisgyr.com)
Received: from FRMONPC1175.eu.bm.net (unknown [10.49.130.40])
	by mail.landisgyr.com (Postfix) with ESMTP id BDCC34B1639;
	Tue,  3 Oct 2023 08:56:08 +0200 (CEST)
From: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
To: bitbake-devel@lists.openembedded.org
Cc: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
Subject: [PATCH v2] hashserv: Fix read-only mode
Date: Tue,  3 Oct 2023 08:56:25 +0200
Message-Id: <20231003065625.3111543-1-karim.benhoucine@landisgyr.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJdd5GZaEn9c-ZR2rtK_-Z=fp5oZXZsK2VhxHZVGqQxMJBEcyg@mail.gmail.com>
References: <CAJdd5GZaEn9c-ZR2rtK_-Z=fp5oZXZsK2VhxHZVGqQxMJBEcyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 06:56:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15160

TCP read-only hash equivalence server is not working: the connection is p=
rematurely closed without even notifying the value of the unihash.
Expected behaviour is:
    1. the client sends a =E2=80=98report=E2=80=99 message indicating the=
 'taskhash', 'method', 'outhash' and a proposed value of 'unihash'.
    2.the server sends back the 'taskhash', 'method' and actual value of =
'unihash' to use.
The problem is that in read-only mode, the server rejects 'report' messag=
es (connexion is closed).
hashserv.tests.TestHashEquivalenceUnixServer.test_ro_server test modified=
 accordingly

Signed-off-by: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
---
 lib/hashserv/server.py | 45 +++++++++++++++++++++++++++++++++++++++++-
 lib/hashserv/tests.py  |  5 ++---
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index d40a2ab8..1f198af4 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -180,7 +180,11 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection=
):
             'get-stats': self.handle_get_stats,
         })
=20
-        if not read_only:
+        if read_only:
+            self.handlers.update({
+                'report': self.handle_readonly_report,
+            })
+        else:
             self.handlers.update({
                 'report': self.handle_report,
                 'report-equiv': self.handle_equivreport,
@@ -453,6 +457,45 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection=
):
=20
         self.write_message(d)
=20
+
+    async def handle_readonly_report(self, data):
+        with closing(self.db.cursor()) as cursor:
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
+            if row is not None:
+                # outhash is known =3D> corrects unihash
+                unihash =3D row['unihash']
+            else:
+                # outhash is unknown =3D> nothing to do
+                unihash =3D data['taskhash']
+
+
+            d =3D {
+                'taskhash': data['taskhash'],
+                'method': data['method'],
+                'unihash': unihash,
+            }
+
+        self.write_message(d)
+
+
     async def handle_equivreport(self, data):
         with closing(self.db.cursor()) as cursor:
             insert_data =3D {
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index f6b85aed..5bf88092 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -312,13 +312,12 @@ class HashEquivalenceCommonTests(object):
         # Check the hash via the read-only server
         self.assertClientGetHash(ro_client, taskhash, unihash)
=20
-        # Ensure that reporting via the read-only server fails
+        # Ensure that reporting via the read-only server doesn't modify =
the database
         taskhash2 =3D 'c665584ee6817aa99edfc77a44dd853828279370'
         outhash2 =3D '3c979c3db45c569f51ab7626a4651074be3a9d11a84b1db076=
f5b14f7d39db44'
         unihash2 =3D '90e9bc1d1f094c51824adca7f8ea79a048d68824'
=20
-        with self.assertRaises(ConnectionError):
-            ro_client.report_unihash(taskhash2, self.METHOD, outhash2, u=
nihash2)
+        ro_client.report_unihash(taskhash2, self.METHOD, outhash2, uniha=
sh2)
=20
         # Ensure that the database was not modified
         self.assertClientGetHash(self.client, taskhash2, None)
--=20
2.25.1


