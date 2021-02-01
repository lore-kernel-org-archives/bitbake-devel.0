Received: from tortoise.home.b5net.uk (tortoise.home.b5net.uk [80.7.160.81])
 by mx.groups.io with SMTP id smtpd.web11.32684.1612179956068962849
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:45:56 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: tortoise.home.b5net.uk, ip: 80.7.160.81, mailfrom: pbarker@tortoise.home.b5net.uk)
Received: by tortoise.home.b5net.uk (Postfix, from userid 1000)
	id 17DD85BC3; Mon,  1 Feb 2021 11:45:52 +0000 (GMT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 7/8] hashserv: Add get-outhash message
Date: Mon,  1 Feb 2021 11:45:50 +0000
Message-Id: <20210201114551.11475-8-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201114551.11475-1-pbarker@konsulko.com>
References: <20210201114551.11475-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The get-outhash message can be sent via the get_outhash client method.
This works in a similar way to the get message but looks up a db entry
by outhash rather than by taskhash. It is intended to be used as a
read-only form of the report message.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/hashserv/client.py |  6 ++++++
 lib/hashserv/server.py | 28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 0b7f4e42e..e05c1eb56 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -170,6 +170,12 @@ class AsyncClient(object):
             {"get": {"taskhash": taskhash, "method": method, "all": all_=
properties}}
         )
=20
+    async def get_outhash(self, method, outhash, taskhash):
+        await self._set_mode(self.MODE_NORMAL)
+        return await self.send_message(
+            {"get-outhash": {"outhash": outhash, "taskhash": taskhash, "=
method": method}}
+        )
+
     async def get_stats(self):
         await self._set_mode(self.MODE_NORMAL)
         return await self.send_message({"get-stats": None})
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index b1e8b2f89..054791b8b 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -152,6 +152,7 @@ class ServerClient(object):
=20
         self.handlers =3D {
             'get': self.handle_get,
+            'get-outhash': self.handle_get_outhash,
             'get-stream': self.handle_get_stream,
             'get-stats': self.handle_get_stats,
             'chunk-stream': self.handle_chunk,
@@ -289,6 +290,33 @@ class ServerClient(object):
=20
         self.write_message(d)
=20
+    async def handle_get_outhash(self, request):
+        with closing(self.db.cursor()) as cursor:
+            cursor.execute('''
+                -- Find tasks with a matching outhash (that is, tasks th=
at
+                -- are equivalent)
+                SELECT * FROM tasks_v2 WHERE method=3D:method AND outhas=
h=3D:outhash
+
+                -- If there is an exact match on the taskhash, return it=
.
+                -- Otherwise return the oldest matching outhash of any
+                -- taskhash
+                ORDER BY CASE WHEN taskhash=3D:taskhash THEN 1 ELSE 2 EN=
D,
+                    created ASC
+
+                -- Only return one row
+                LIMIT 1
+                ''', {k: request[k] for k in ('method', 'outhash', 'task=
hash')})
+
+            row =3D cursor.fetchone()
+
+        if row is not None:
+            logger.debug(1, 'Found equivalent outhash %s -> %s', (row['o=
uthash'], row['unihash']))
+            d =3D {k: row[k] for k in row.keys()}
+        else:
+            d =3D None
+
+        self.write_message(d)
+
     async def handle_get_stream(self, request):
         self.write_message('ok')
=20
--=20
2.26.2

