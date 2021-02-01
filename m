Received: from tortoise.home.b5net.uk (tortoise.home.b5net.uk [80.7.160.81])
 by mx.groups.io with SMTP id smtpd.web11.32683.1612179956037466394
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:45:56 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: tortoise.home.b5net.uk, ip: 80.7.160.81, mailfrom: pbarker@tortoise.home.b5net.uk)
Received: by tortoise.home.b5net.uk (Postfix, from userid 1000)
	id 1CAD95BC5; Mon,  1 Feb 2021 11:45:52 +0000 (GMT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 8/8] hashserv: server: Support searching upstream for outhash
Date: Mon,  1 Feb 2021 11:45:51 +0000
Message-Id: <20210201114551.11475-9-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201114551.11475-1-pbarker@konsulko.com>
References: <20210201114551.11475-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new get-outhash message to perform a read-only query against an
upstream server (if present) when a reported taskhash/outhash
combination is not found in the current database. If a matching entry is
found upstream it is copied into the current database so it can be found
by future queries.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/hashserv/server.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 054791b8b..5fb562b52 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -131,6 +131,20 @@ async def copy_from_upstream(client, db, method, tas=
khash):
         keys =3D sorted(d.keys())
=20
=20
+        with closing(db.cursor()) as cursor:
+            insert_task(cursor, d)
+            db.commit()
+
+    return d
+
+async def copy_outhash_from_upstream(client, db, method, outhash, taskha=
sh):
+    d =3D await client.get_outhash(method, outhash, taskhash)
+    if d is not None:
+        # Filter out unknown columns
+        d =3D {k: v for k, v in d.items() if k in TABLE_COLUMNS}
+        keys =3D sorted(d.keys())
+
+
         with closing(db.cursor()) as cursor:
             insert_task(cursor, d)
             db.commit()
@@ -387,6 +401,14 @@ class ServerClient(object):
=20
             row =3D cursor.fetchone()
=20
+            if row is None:
+                # Try upstream
+                row =3D await copy_outhash_from_upstream(self.upstream_c=
lient,
+                                                       self.db,
+                                                       data['method'],
+                                                       data['outhash'],
+                                                       data['taskhash'])
+
             # If no matching outhash was found, or one *was* found but i=
t
             # wasn't an exact match on the taskhash, a new entry for thi=
s
             # taskhash should be added
--=20
2.26.2

