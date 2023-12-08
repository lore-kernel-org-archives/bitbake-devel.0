Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E82C4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 01:56:49 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.10405.1702000608103209110
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Dec 2023 17:56:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=nOMmO8Ux;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6F8A79C33BA
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 Dec 2023 20:56:47 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id lP7AvXyThrXc; Thu,  7 Dec 2023 20:56:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1A0BB9C33E2;
	Thu,  7 Dec 2023 20:56:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 1A0BB9C33E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702000607; bh=gn8j86AZLwDt86nV+sphGAC1IC5bGwhAumwhVMRr7LM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=nOMmO8UxYQ0MMnDWT5WrON7bYGNAHXqhohDD2TaHk1zgLTVQIQkQLmHm2oKHnZlI9
	 EkvuosQObl4ArQV+rDloD2t27xUqtq+zKYXllU1ajGYn5XI6aYEAjjMiecXdC22AZ+
	 i51IVNdOWaOPJhn30IOMzF3vM2UGw6Ih2f2VEtQQi771prybXHuISl9VVy1PsqqVZR
	 UDpsjeDgc5cGajonk3R+kIUrvtRys5+UmovEJiDlp0+l4X5TA4Q7VrCuwM6a9Bk+wU
	 8HNVEvTtO9RjpgRyjS88mXXPhYUQsPAi6yZ6om+f5lT0X08Dl7k++todLJHXZGupax
	 9YsYoxNngWFkg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id nP-DzLV_lsid; Thu,  7 Dec 2023 20:56:47 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 512FA9C33BA;
	Thu,  7 Dec 2023 20:56:46 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] toaster/test: Fixes warnings in autobuilder
Date: Fri,  8 Dec 2023 02:56:33 +0100
Message-Id: <20231208015633.686774-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Dec 2023 01:56:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15639

../bitbake/lib/toaster/tests/functional/functional_helpers.py:66
  /home/pokybuild/yocto-worker/toaster/build/bitbake/lib/toaster/tests/fu=
nctional/functional_helpers.py:66: DeprecationWarning: invalid escape seq=
uence '\s'
    project_url=3Dre.search("(projectPageUrl\s:\s\")(.*)(\",)",rc)

Traceback (most recent call last):
  File "/usr/lib/python3.10/threading.py", line 1016, in _bootstrap_inner
    self.run()
  File "/home/pokybuild/yocto-worker/toaster/build/bitbake/lib/toaster/te=
sts/commands/test_runbuilds.py", line 39, in run
    os.kill(int(pid), signal.SIGTERM)
ProcessLookupError: [Errno 3] No such process

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/commands/test_runbuilds.py       | 13 ++++++++++---
 lib/toaster/tests/functional/functional_helpers.py |  2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/tests/commands/test_runbuilds.py b/lib/toaster/t=
ests/commands/test_runbuilds.py
index c77d6cf4..738d36e9 100644
--- a/lib/toaster/tests/commands/test_runbuilds.py
+++ b/lib/toaster/tests/commands/test_runbuilds.py
@@ -19,6 +19,10 @@ import time
 import subprocess
 import signal
=20
+import logging
+
+
+logger =3D logging.getLogger("toaster")
=20
 class KillRunbuilds(threading.Thread):
     """ Kill the runbuilds process after an amount of time """
@@ -34,9 +38,12 @@ class KillRunbuilds(threading.Thread):
         pidfile_path =3D os.path.join(os.environ.get("BUILDDIR", "."),
                                     ".runbuilds.pid")
=20
-        with open(pidfile_path) as pidfile:
-            pid =3D pidfile.read()
-            os.kill(int(pid), signal.SIGTERM)
+        try:
+            with open(pidfile_path) as pidfile:
+                pid =3D pidfile.read()
+                os.kill(int(pid), signal.SIGTERM)
+        except ProcessLookupError:
+            logger.warning("Runbuilds not running or already killed")
=20
=20
 class TestCommands(TestCase):
diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toa=
ster/tests/functional/functional_helpers.py
index b80d403b..1c535db6 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -62,7 +62,7 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
=20
     def get_URL(self):
          rc=3Dself.get_page_source()
-         project_url=3Dre.search("(projectPageUrl\s:\s\")(.*)(\",)",rc)
+         project_url=3Dre.search(r"(projectPageUrl\s:\s\")(.*)(\",)",rc)
          return project_url.group(2)
=20
=20
--=20
2.34.1


