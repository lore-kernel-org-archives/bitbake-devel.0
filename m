Return-Path: <Karim.benhoucine@landisgyr.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C51E784AC
	for <webhook@archiver.kernel.org>; Mon,  2 Oct 2023 11:57:41 +0000 (UTC)
Received: from mail.landisgyr.com (mail.landisgyr.com [213.95.165.69])
 by mx.groups.io with SMTP id smtpd.web11.79607.1696247857708575488
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Oct 2023 04:57:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: landisgyr.com, ip: 213.95.165.69, mailfrom: karim.benhoucine@landisgyr.com)
Received: from FRMONPC1175.eu.bm.net (unknown [10.49.130.40])
	by mail.landisgyr.com (Postfix) with ESMTP id DEF5A1CDC3B30;
	Mon,  2 Oct 2023 13:57:35 +0200 (CEST)
From: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
To: bitbake-devel@lists.openembedded.org
Cc: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
Subject: [PATCH] hashserv: Fix read-only mode
Date: Mon,  2 Oct 2023 13:56:41 +0200
Message-Id: <20231002115641.1717054-1-karim.benhoucine@landisgyr.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <178A47C70519CAC1.9230@lists.openembedded.org>
References: <178A47C70519CAC1.9230@lists.openembedded.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Oct 2023 11:57:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15155

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
 bitbake/lib/hashserv/server.py | 14 +++++++-------
 bitbake/lib/hashserv/tests.py  |  4 +---
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server=
.py
index 56d76f1f81..a12937e25f 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -181,7 +181,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection)=
:
         })
=20
         if read_only:
-            self.handlers.update({   =20
+            self.handlers.update({
                 'report': self.handle_readonly_report,
             })
         else:
@@ -469,7 +469,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection)=
:
=20
             for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginf=
o'):
                 if k in data:
-                    outhash_data[k] =3D data[k]=20
+                    outhash_data[k] =3D data[k]
=20
             # Check if outhash is known
             cursor.execute(
@@ -489,13 +489,13 @@ class ServerClient(bb.asyncrpc.AsyncServerConnectio=
n):
                 }
             )
             row =3D cursor.fetchone()
-            if row is not None:=20
+            if row is not None:
                 # outhash is known =3D> corrects unihash
-                unihash =3D row['unihash']=20
+                unihash =3D row['unihash']
             else:
                 # outhash is unknown =3D> nothing to do
-                unihash =3D outhash_data['taskhash']=20
-           =20
+                unihash =3D outhash_data['taskhash']
+
=20
             d =3D {
                 'taskhash': data['taskhash'],
@@ -504,7 +504,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection)=
:
             }
=20
         self.write_message(d)
-       =20
+
=20
     async def handle_equivreport(self, data):
         with closing(self.db.cursor()) as cursor:
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.p=
y
index 8d997c1ae4..5bf8809214 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -312,13 +312,11 @@ class HashEquivalenceCommonTests(object):
         # Check the hash via the read-only server
         self.assertClientGetHash(ro_client, taskhash, unihash)
=20
-        # Karim removed : # Ensure that reporting via the read-only serv=
er fails
-        # Karim added : # Ensure that reporting via the read-only server=
 doesn't modify the database
+        # Ensure that reporting via the read-only server doesn't modify =
the database
         taskhash2 =3D 'c665584ee6817aa99edfc77a44dd853828279370'
         outhash2 =3D '3c979c3db45c569f51ab7626a4651074be3a9d11a84b1db076=
f5b14f7d39db44'
         unihash2 =3D '90e9bc1d1f094c51824adca7f8ea79a048d68824'
=20
-        # Karim removed : with self.assertRaises(ConnectionError):
         ro_client.report_unihash(taskhash2, self.METHOD, outhash2, uniha=
sh2)
=20
         # Ensure that the database was not modified
--=20
2.25.1


