Received: from tortoise.home.b5net.uk (tortoise.home.b5net.uk [80.7.160.81])
 by mx.groups.io with SMTP id smtpd.web10.32503.1612179954061752181
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:45:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: tortoise.home.b5net.uk, ip: 80.7.160.81, mailfrom: pbarker@tortoise.home.b5net.uk)
Received: by tortoise.home.b5net.uk (Postfix, from userid 1000)
	id 0295D5BBB; Mon,  1 Feb 2021 11:45:51 +0000 (GMT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 3/8] hashserv: server: Fix logger.debug calls
Date: Mon,  1 Feb 2021 11:45:46 +0000
Message-Id: <20210201114551.11475-4-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201114551.11475-1-pbarker@konsulko.com>
References: <20210201114551.11475-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The first argument to debug calls in bitbake should be a debug level.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/hashserv/server.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 3ff4c51cc..fa0d3410b 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -168,7 +168,7 @@ class ServerClient(object):
=20
=20
             self.addr =3D self.writer.get_extra_info('peername')
-            logger.debug('Client %r connected' % (self.addr,))
+            logger.debug(1, 'Client %r connected' % (self.addr,))
=20
             # Read protocol and version
             protocol =3D await self.reader.readline()
@@ -212,7 +212,7 @@ class ServerClient(object):
     async def dispatch_message(self, msg):
         for k in self.handlers.keys():
             if k in msg:
-                logger.debug('Handling %s' % k)
+                logger.debug(1, 'Handling %s' % k)
                 if 'stream' in k:
                     await self.handlers[k](msg[k])
                 else:
@@ -273,7 +273,7 @@ class ServerClient(object):
             row =3D self.query_equivalent(method, taskhash, self.FAST_QU=
ERY)
=20
         if row is not None:
-            logger.debug('Found equivalent task %s -> %s', (row['taskhas=
h'], row['unihash']))
+            logger.debug(1, 'Found equivalent task %s -> %s', (row['task=
hash'], row['unihash']))
             d =3D {k: row[k] for k in row.keys()}
         elif self.upstream_client is not None:
             d =3D await copy_from_upstream(self.upstream_client, self.db=
, method, taskhash)
@@ -307,11 +307,11 @@ class ServerClient(object):
                     return
=20
                 (method, taskhash) =3D l.split()
-                #logger.debug('Looking up %s %s' % (method, taskhash))
+                #logger.debug(1, 'Looking up %s %s' % (method, taskhash)=
)
                 row =3D self.query_equivalent(method, taskhash, self.FAS=
T_QUERY)
                 if row is not None:
                     msg =3D ('%s\n' % row['unihash']).encode('utf-8')
-                    #logger.debug('Found equivalent task %s -> %s', (row=
['taskhash'], row['unihash']))
+                    #logger.debug(1, 'Found equivalent task %s -> %s', (=
row['taskhash'], row['unihash']))
                 elif self.upstream_client is not None:
                     upstream =3D await self.upstream_client.get_unihash(=
method, taskhash)
                     if upstream:
--=20
2.26.2

