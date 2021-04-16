Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.133.1618594445510433913
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Apr 2021 10:34:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F141211B3
	for <bitbake-devel@lists.openembedded.org>; Fri, 16 Apr 2021 10:34:03 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ACF43F99C
	for <bitbake-devel@lists.openembedded.org>; Fri, 16 Apr 2021 10:34:03 -0700 (PDT)
From: "Ross Burton" <ross@burtonini.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake-server: ensure server timeout is a float
Date: Fri, 16 Apr 2021 18:33:59 +0100
Message-Id: <20210416173359.3251372-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

bitbake-server is spawned and passes the arguments it is given to
ProcessServer.  However, ProcessServer expects the server timeout to be
a float and not a string, so convert before passing.

[ YOCTO #14350 ]

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/bin/bitbake-server | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
--=20
2.25.1

