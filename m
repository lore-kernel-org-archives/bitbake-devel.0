Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD416CE7A81
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 11:55:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.58856.1695642937617322828
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Sep 2023 04:55:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FCB0DA7;
	Mon, 25 Sep 2023 04:56:15 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9C0A23F59C;
	Mon, 25 Sep 2023 04:55:36 -0700 (PDT)
From: ross.burton@arm.com
To: bitbake-devel@lists.openembedded.org
Cc: nd@arm.com
Subject: [PATCH] bitbake/lib: spawn server/worker using the current Python interpreter
Date: Mon, 25 Sep 2023 12:55:32 +0100
Message-Id: <20230925115532.1091914-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 11:55:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15117

From: Ross Burton <ross.burton@arm.com>

The user may have invoked ./bin/bitbake using a different Python
interpreter than whatever python3 is on $PATH (for example, explicitly
using a different version).  However, as the server and workers are
spawned directly they'll use the hashbang and thus a different Python.

We also ensure that argv[0] is set to sys.executable instead of
'bitbake-server' or 'bitbake-worker', so that sys.executable is set to
the right value inside the child.  Without this the server won't be
able to start any workers.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/runqueue.py       | 6 ++++--
 bitbake/lib/bb/server/process.py | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index c40a3be2125..56147c50a8a 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1324,6 +1324,8 @@ class RunQueue:
         if self.cooker.configuration.profile:
             magic =3D "decafbadbad"
         fakerootlogs =3D None
+
+        workerscript =3D os.path.realpath(os.path.dirname(__file__) + "/=
../../bin/bitbake-worker")
         if fakeroot:
             magic =3D magic + "beef"
             mcdata =3D self.cooker.databuilder.mcdata[mc]
@@ -1332,10 +1334,10 @@ class RunQueue:
             env =3D os.environ.copy()
             for key, value in (var.split('=3D') for var in fakerootenv):
                 env[key] =3D value
-            worker =3D subprocess.Popen(fakerootcmd + ["bitbake-worker",=
 magic], stdout=3Dsubprocess.PIPE, stdin=3Dsubprocess.PIPE, env=3Denv)
+            worker =3D subprocess.Popen(fakerootcmd + [sys.executable, w=
orkerscript, magic], stdout=3Dsubprocess.PIPE, stdin=3Dsubprocess.PIPE, e=
nv=3Denv)
             fakerootlogs =3D self.rqdata.dataCaches[mc].fakerootlogs
         else:
-            worker =3D subprocess.Popen(["bitbake-worker", magic], stdou=
t=3Dsubprocess.PIPE, stdin=3Dsubprocess.PIPE)
+            worker =3D subprocess.Popen([sys.executable, workerscript, m=
agic], stdout=3Dsubprocess.PIPE, stdin=3Dsubprocess.PIPE)
         bb.utils.nonblockingfd(worker.stdout)
         workerpipe =3D runQueuePipe(worker.stdout, None, self.cfgData, s=
elf, rqexec, fakerootlogs=3Dfakerootlogs)
=20
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/pro=
cess.py
index 5654f60f9e5..d495ac62459 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -620,7 +620,7 @@ class BitBakeServer(object):
         os.set_inheritable(self.bitbake_lock.fileno(), True)
         os.set_inheritable(self.readypipein, True)
         serverscript =3D os.path.realpath(os.path.dirname(__file__) + "/=
../../../bin/bitbake-server")
-        os.execl(sys.executable, "bitbake-server", serverscript, "decafb=
ad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.logfile=
, self.bitbake_lock.name, self.sockname,  str(self.server_timeout or 0), =
str(int(self.profile)), str(self.xmlrpcinterface[0]), str(self.xmlrpcinte=
rface[1]))
+        os.execl(sys.executable, sys.executable, serverscript, "decafbad=
", str(self.bitbake_lock.fileno()), str(self.readypipein), self.logfile, =
self.bitbake_lock.name, self.sockname,  str(self.server_timeout or 0), st=
r(int(self.profile)), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterf=
ace[1]))
=20
 def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout=
, xmlrpcinterface, profile):
=20
--=20
2.34.1


