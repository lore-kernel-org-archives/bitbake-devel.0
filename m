Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C9475719B6
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Jan 2017 23:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v04NmkcE032466; Wed, 4 Jan 2017 23:48:46 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wgLioF7MCjiQ; Wed,  4 Jan 2017 23:48:46 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v04Nmi2B032463
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 4 Jan 2017 23:48:45 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cOvIS-0002bO-Gw; Wed, 04 Jan 2017 23:48:44 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Jan 2017 23:48:40 +0000
Message-Id: <1483573720-9963-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] prserv/serv: Tweak stdout manipulation to be stream safe
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
X-List-Received-Date: Wed, 04 Jan 2017 23:48:53 -0000

We've been seeing oe-selftest failures under puzzling circumstances. It
turns out if you run oe-selftest on a machine with xmlrunner installed
and have the recent tinfoil2 changes, the launching of PR server crashes
leading to selftest hanging if using an autoloaded PR server.

The reason is that xmlrunner uses an io.StringIO object as stdout/stderr
instead of the usual io.TextIOWrapper and StringIO lacks a fileno() method.

This code was copied from build.py from what I remember and in that case we
need to retain copies of the old file descriptors, hence the use of os.dup2.
As far as I can tell, here, we can just overwrite the handles directly and
hence avoid this rather puzzling crash.

[YOCTO #10866]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/prserv/serv.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 350b085..965793d 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -242,12 +242,9 @@ class PRServer(SimpleXMLRPCServer):
 
         sys.stdout.flush()
         sys.stderr.flush()
-        si = open('/dev/null', 'r')
-        so = open(self.logfile, 'a+')
-        se = so
-        os.dup2(si.fileno(),sys.stdin.fileno())
-        os.dup2(so.fileno(),sys.stdout.fileno())
-        os.dup2(se.fileno(),sys.stderr.fileno())
+        sys.stdin = open('/dev/null', 'r')
+        sys.stdout = open(self.logfile, 'a+')
+        sys.stderr = sys.stdout
 
         # Clear out all log handlers prior to the fork() to avoid calling
         # event handlers not part of the PRserver
-- 
2.7.4


