Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.6825.1618826828832282266
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Apr 2021 03:07:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 027601FB
	for <bitbake-devel@lists.openembedded.org>; Mon, 19 Apr 2021 03:07:08 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA663F85F
	for <bitbake-devel@lists.openembedded.org>; Mon, 19 Apr 2021 03:07:07 -0700 (PDT)
From: "Ross Burton" <ross@burtonini.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] bitbake-server: ensure server timeout is a float
Date: Mon, 19 Apr 2021 11:07:02 +0100
Message-Id: <20210419100702.3311865-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

bitbake-server is spawned by process.py and passes the arguments it is
given to ProcessServer.  There's some type confusion here:

bitbake-server is called with a string representation of the timeout,
which may be None.  If the timeout is not set, pass 0 instead of None.

Inside bitbake-server a ProcessServer is created which expects the
timeout to be a float not a string, so always float() the value.

[ YOCTO #14350 ]

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/bin/bitbake-server       | 2 +-
 bitbake/lib/bb/server/process.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake-server b/bitbake/bin/bitbake-server
index ffbc7894ef7..65796be7473 100755
--- a/bitbake/bin/bitbake-server
+++ b/bitbake/bin/bitbake-server
@@ -26,7 +26,7 @@ readypipeinfd =3D int(sys.argv[3])
 logfile =3D sys.argv[4]
 lockname =3D sys.argv[5]
 sockname =3D sys.argv[6]
-timeout =3D sys.argv[7]
+timeout =3D float(sys.argv[7])
 xmlrpcinterface =3D (sys.argv[8], int(sys.argv[9]))
 if xmlrpcinterface[0] =3D=3D "None":
     xmlrpcinterface =3D (None, xmlrpcinterface[1])
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/pro=
cess.py
index b27b4aefe0e..3e99bcef8f2 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -509,7 +509,7 @@ class BitBakeServer(object):
         os.set_inheritable(self.bitbake_lock.fileno(), True)
         os.set_inheritable(self.readypipein, True)
         serverscript =3D os.path.realpath(os.path.dirname(__file__) + "/=
../../../bin/bitbake-server")
-        os.execl(sys.executable, "bitbake-server", serverscript, "decafb=
ad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.logfile=
, self.bitbake_lock.name, self.sockname,  str(self.server_timeout), str(s=
elf.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
+        os.execl(sys.executable, "bitbake-server", serverscript, "decafb=
ad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.logfile=
, self.bitbake_lock.name, self.sockname,  str(self.server_timeout or 0), =
str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
=20
 def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout=
, xmlrpcinterface):
=20
--=20
2.25.1

