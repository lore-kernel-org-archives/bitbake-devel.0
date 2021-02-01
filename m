Received: from tortoise.home.b5net.uk (tortoise.home.b5net.uk [80.7.160.81])
 by mx.groups.io with SMTP id smtpd.web12.32606.1612179954059297964
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:45:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: tortoise.home.b5net.uk, ip: 80.7.160.81, mailfrom: pbarker@tortoise.home.b5net.uk)
Received: by tortoise.home.b5net.uk (Postfix, from userid 1000)
	id F01CD5BB9; Mon,  1 Feb 2021 11:45:51 +0000 (GMT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 2/8] hashserv: client: Fix handling of null responses
Date: Mon,  1 Feb 2021 11:45:45 +0000
Message-Id: <20210201114551.11475-3-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201114551.11475-1-pbarker@konsulko.com>
References: <20210201114551.11475-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the server returns an empty response ("null" in json), this cannot
be iterated to check for the presence of the "chunk-stream" key.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/hashserv/client.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 0ffd0c2ae..0b7f4e42e 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -99,7 +99,7 @@ class AsyncClient(object):
             l =3D await get_line()
=20
             m =3D json.loads(l)
-            if "chunk-stream" in m:
+            if m and "chunk-stream" in m:
                 lines =3D []
                 while True:
                     l =3D (await get_line()).rstrip("\n")
--=20
2.26.2

