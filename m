Received: from tortoise.home.b5net.uk (tortoise.home.b5net.uk [80.7.160.81])
 by mx.groups.io with SMTP id smtpd.web11.32682.1612179956013124423
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:45:56 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: tortoise.home.b5net.uk, ip: 80.7.160.81, mailfrom: pbarker@tortoise.home.b5net.uk)
Received: by tortoise.home.b5net.uk (Postfix, from userid 1000)
	id 0F15B5BBF; Mon,  1 Feb 2021 11:45:52 +0000 (GMT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 5/8] hashserv: Support upstream command line argument
Date: Mon,  1 Feb 2021 11:45:48 +0000
Message-Id: <20210201114551.11475-6-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201114551.11475-1-pbarker@konsulko.com>
References: <20210201114551.11475-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The hashserv server already implements support for pulling hash data
from another "upstream" server. Add the -u/--upstream argument to the
bitbake-hashserv app to expose this functionality to users.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 bin/bitbake-hashserv | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index 2669bbd13..ab71f4e6c 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -33,6 +33,7 @@ def main():
     parser.add_argument('--bind', default=3DDEFAULT_BIND, help=3D'Bind a=
ddress (default "%(default)s")')
     parser.add_argument('--database', default=3D'./hashserv.db', help=3D=
'Database file (default "%(default)s")')
     parser.add_argument('--log', default=3D'WARNING', help=3D'Set loggin=
g level')
+    parser.add_argument('-u', '--upstream', help=3D'Upstream hashserv to=
 pull hashes from')
     parser.add_argument('-r', '--read-only', action=3D'store_true', help=
=3D'Disallow write operations from clients')
=20
     args =3D parser.parse_args()
@@ -48,7 +49,7 @@ def main():
     console.setLevel(level)
     logger.addHandler(console)
=20
-    server =3D hashserv.create_server(args.bind, args.database, read_onl=
y=3Dargs.read_only)
+    server =3D hashserv.create_server(args.bind, args.database, upstream=
=3Dargs.upstream, read_only=3Dargs.read_only)
     server.serve_forever()
     return 0
=20
--=20
2.26.2

