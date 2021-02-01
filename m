Received: from tortoise.home.b5net.uk (tortoise.home.b5net.uk [80.7.160.81])
 by mx.groups.io with SMTP id smtpd.web10.32506.1612179955995675923
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:45:56 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: tortoise.home.b5net.uk, ip: 80.7.160.81, mailfrom: pbarker@tortoise.home.b5net.uk)
Received: by tortoise.home.b5net.uk (Postfix, from userid 1000)
	id 1412A5BC1; Mon,  1 Feb 2021 11:45:52 +0000 (GMT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 6/8] hashserv: Add short forms of remaining command line arguments
Date: Mon,  1 Feb 2021 11:45:49 +0000
Message-Id: <20210201114551.11475-7-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201114551.11475-1-pbarker@konsulko.com>
References: <20210201114551.11475-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Short form arguments are added for convenience.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 bin/bitbake-hashserv | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index ab71f4e6c..153f65a37 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -30,9 +30,9 @@ def main():
                                                "--bind [::1]:8686"'''
                                      )
=20
-    parser.add_argument('--bind', default=3DDEFAULT_BIND, help=3D'Bind a=
ddress (default "%(default)s")')
-    parser.add_argument('--database', default=3D'./hashserv.db', help=3D=
'Database file (default "%(default)s")')
-    parser.add_argument('--log', default=3D'WARNING', help=3D'Set loggin=
g level')
+    parser.add_argument('-b', '--bind', default=3DDEFAULT_BIND, help=3D'=
Bind address (default "%(default)s")')
+    parser.add_argument('-d', '--database', default=3D'./hashserv.db', h=
elp=3D'Database file (default "%(default)s")')
+    parser.add_argument('-l', '--log', default=3D'WARNING', help=3D'Set =
logging level')
     parser.add_argument('-u', '--upstream', help=3D'Upstream hashserv to=
 pull hashes from')
     parser.add_argument('-r', '--read-only', action=3D'store_true', help=
=3D'Disallow write operations from clients')
=20
--=20
2.26.2

