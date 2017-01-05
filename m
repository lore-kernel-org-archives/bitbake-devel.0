Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C81616AC00
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Jan 2017 13:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v05DqBHB019464; Thu, 5 Jan 2017 13:52:11 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Sj3BDuEtQntv; Thu,  5 Jan 2017 13:52:11 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v05Dq9Oi019458
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 5 Jan 2017 13:52:10 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cP8Sf-0004qo-4L; Thu, 05 Jan 2017 13:52:09 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  5 Jan 2017 13:52:07 +0000
Message-Id: <1483624327-18607-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH v2] prserv/serv: Tweak stdout manipulation to be stream safe
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 05 Jan 2017 13:52:16 -0000

We've been seeing oe-selftest failures under puzzling circumstances. It
turns out if you run oe-selftest on a machine with xmlrunner installed
and have the recent tinfoil2 changes, the launching of PR server crashes
leading to selftest hanging if using an autoloaded PR server.

The reason is that xmlrunner uses an io.StringIO object as stdout/stderr
instead of the usual io.TextIOWrapper and StringIO lacks a fileno() method.

We have to deal with both cases and in the python way, we try and then seek
forgivness if we see an AttributeError or UnSupportedOperation exception.
Unfortunately we have to deal with both cases as we may be performing a
traditiional double fork() from the commandline, or a larger python program.

[YOCTO #10866]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/prserv/serv.py | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 350b085..d9b602f 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -242,12 +242,25 @@ class PRServer(SimpleXMLRPCServer):
 
         sys.stdout.flush()
         sys.stderr.flush()
+
+        # We could be called from a python thread with io.StringIO as
+        # stdout/stderr or it could be 'real' unix fd forking where we need
+        # to physically close the fds to prevent the program launching us from
+        # potentially hanging on a pipe. Handle both cases.
         si = open('/dev/null', 'r')
+        try:
+            os.dup2(si.fileno(),sys.stdin.fileno())
+        except (AttributeError, io.UnsupportedOperation):
+            sys.stdin = si
         so = open(self.logfile, 'a+')
-        se = so
-        os.dup2(si.fileno(),sys.stdin.fileno())
-        os.dup2(so.fileno(),sys.stdout.fileno())
-        os.dup2(se.fileno(),sys.stderr.fileno())
+        try:
+            os.dup2(so.fileno(),sys.stdout.fileno())
+        except (AttributeError, io.UnsupportedOperation):
+            sys.stdout = so
+        try:
+            os.dup2(so.fileno(),sys.stderr.fileno())
+        except (AttributeError, io.UnsupportedOperation):
+            sys.stderr = so
 
         # Clear out all log handlers prior to the fork() to avoid calling
         # event handlers not part of the PRserver
-- 
2.7.4


