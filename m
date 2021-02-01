Received: from tortoise.home.b5net.uk (tortoise.home.b5net.uk [80.7.160.81])
 by mx.groups.io with SMTP id smtpd.web08.32596.1612179954055722256
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:45:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: tortoise.home.b5net.uk, ip: 80.7.160.81, mailfrom: pbarker@tortoise.home.b5net.uk)
Received: by tortoise.home.b5net.uk (Postfix, from userid 1000)
	id EBA545BB6; Mon,  1 Feb 2021 11:45:51 +0000 (GMT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 1/8] bitbake-hashclient: Remove obsolete call to client.connect
Date: Mon,  1 Feb 2021 11:45:44 +0000
Message-Id: <20210201114551.11475-2-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201114551.11475-1-pbarker@konsulko.com>
References: <20210201114551.11475-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The connect function was previously removed from the hashserv Client
class but the bitbake-hashclient app was not updated. The client is
connected during hashserv.create_client() anyway so not separate connect
call is needed.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 bin/bitbake-hashclient | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclient
index 29ab65f17..a89290217 100755
--- a/bin/bitbake-hashclient
+++ b/bin/bitbake-hashclient
@@ -151,9 +151,6 @@ def main():
     func =3D getattr(args, 'func', None)
     if func:
         client =3D hashserv.create_client(args.address)
-        # Try to establish a connection to the server now to detect fail=
ures
-        # early
-        client.connect()
=20
         return func(args, client)
=20
--=20
2.26.2

