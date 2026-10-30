Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13863.1793373266593001119
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Oct 2026 08:14:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@emlix.com header.s=20250930 header.b=l9ymkYdg;
 spf=pass (domain: emlix.com, ip: 178.63.209.131, mailfrom: andreas.muetzel@emlix.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
	s=20250930; t=1793373259;
	bh=sC+kMrTPoFd1vdN4xJEuQKlNaFznokfPYx2ajtR/AT4=;
	h=From:To:Cc:Subject:Date:From;
	b=l9ymkYdgZb/8Rw+3YT2MNmTjyobYntu9bVIbAgVE5ZM2T9CchH00r/66oc4VEfpoH
	 3CKZUgq+TfcnH89G8HeYwupwpP349xEbLa1BtQpuQodgrhvuVs8tCVi652GPedu4DH
	 ARwNr5jkXrKT8LjbX37J5S4bRiDrdhOcuqBQX385P5YGv7hStr48PX8tGLaYd7oR9a
	 N7xYtIXrTp2qiQKE2LJoF9VUSLC1JjVJQYpDTZFB6OuMlDewE4NHePh1LOoY/MeFm1
	 ngfndNPl7i29IC/OVwGrymL7G0bY7yGPj1WRMEHZN1Qk0qKqr6BEmXpEWVXYd9cO8o
	 ffIkh0FmXVOnA==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 8AB145F861;
	Fri, 30 Oct 2026 16:14:19 +0100 (CET)
From: =?UTF-8?q?Andreas=20M=C3=BCtzel?= <andreas.muetzel@emlix.com>
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Andreas=20M=C3=BCtzel?= <andreas.muetzel@emlix.com>
Subject: [PATCH] bitbake: fix documentation of -S lockedsigs
Date: Fri, 30 Oct 2026 16:14:41 +0100
Message-ID: <20261030151441.2061-1-andreas.muetzel@emlix.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: clamav-milter 1.4.3 at mx1.emlix.com
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 30 Oct 2026 15:14:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20385

oe-core changed the arguments used to dump sstate signatures to the file
locked-sigs.inc from -S none to -s lockedsigs. Adapt the documentation
and help text accordingly.

Signed-off-by: Andreas M=C3=BCtzel <andreas.muetzel@emlix.com>
---
 .../bitbake-user-manual-intro.rst                 | 15 ++++++++-------
 lib/bb/main.py                                    |  4 ++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/=
bitbake-user-manual/bitbake-user-manual-intro.rst
index 6801323e2..d77509796 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -475,13 +475,14 @@ Following is the usage and syntax for BitBake::
      -S SIGNATURE_HANDLER, --dump-signatures SIGNATURE_HANDLER
                            Dump out the signature construction informati=
on, with
                            no task execution. The SIGNATURE_HANDLER para=
meter is
-                           passed to the handler. Two common values are =
none and
-                           printdiff but the handler may define more/les=
s. none
-                           means only dump the signature, printdiff mean=
s
-                           recursively compare the dumped signature with=
 the most
-                           recent one in a local build or sstate cache (=
can be
-                           used to find out why tasks re-run when that i=
s not
-                           expected)
+                           passed to the handler. Two common values are
+                           lockedsigs and printdiff but the handler may =
define
+                           more/less.
+                           lockedsigs means only dump the signature, pri=
ntdiff
+                           means recursively compare the dumped signatur=
e with
+                           the most recent one in a local build or sstat=
e cache
+                           (can be used to find out why tasks re-run whe=
n that
+                           is not expected)
      --revisions-changed   Set the exit code depending on whether upstre=
am
                            floating revisions have changed or not.
      -b BUILDFILE, --buildfile BUILDFILE
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 73a66468f..5cce8eb27 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -217,8 +217,8 @@ def create_bitbake_parser():
                         default=3D[], metavar=3D"SIGNATURE_HANDLER",
                         help=3D"Dump out the signature construction info=
rmation, with no task "
                              "execution. The SIGNATURE_HANDLER parameter=
 is passed to the "
-                             "handler. Two common values are none and pr=
intdiff but the handler "
-                             "may define more/less. none means only dump=
 the signature, printdiff"
+                             "handler. Two common values are lockedsigs =
and printdiff but the handler "
+                             "may define more/less. lockedsigs means onl=
y dump the signature, printdiff"
                              " means recursively compare the dumped sign=
ature with the most recent"
                              " one in a local build or sstate cache (can=
 be used to find out why tasks re-run"
                              " when that is not expected)")
--=20
2.56.0

