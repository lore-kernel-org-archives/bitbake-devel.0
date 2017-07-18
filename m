Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4CBBE78145
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jul 2017 21:37:08 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6ILb6va012347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 18 Jul 2017 22:37:07 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dXaB0-0006TH-Kr; Tue, 18 Jul 2017 22:37:06 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jul 2017 22:36:58 +0100
Message-Id: <1500413820-24816-4-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500413820-24816-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1500413820-24816-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Tue, 18 Jul 2017 22:37:07 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 4/6] daemonize: Various fixes
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
X-List-Received-Date: Tue, 18 Jul 2017 21:37:09 -0000

Currently if this code is used with something like oeqa's xml logging
it fails as sys.stdout is an io stream. Add in try/except to handle
this case.

Add a waitpid() call to remove a zombie whilst forking.

Also, append to the logfile, don't overwrite it (otherwise
debugging can be a real pain when the server is restarting for
unknown reasons).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/daemonize.py | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index ab4a954..8380828 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -29,6 +29,7 @@ __version__ = "0.2"
 # Standard Python modules.
 import os                    # Miscellaneous OS interfaces.
 import sys                   # System-specific parameters and functions.
+import io
 
 # Default daemon parameters.
 # File mode creation mask of the daemon.
@@ -124,6 +125,7 @@ def createDaemon(function, logfile):
         # streams to be flushed twice and any temporary files may be unexpectedly
         # removed.  It's therefore recommended that child branches of a fork()
         # and the parent branch(es) of a daemon use _exit().
+        os.waitpid(pid, 0)
         return
 
     # Close all open file descriptors.  This prevents the child from keeping
@@ -177,16 +179,18 @@ def createDaemon(function, logfile):
 #    os.dup2(0, 1)                      # standard output (1)
 #    os.dup2(0, 2)                      # standard error (2)
 
-
-    si = open('/dev/null', 'r')
-    so = open(logfile, 'w')
-    se = so
-
-
     # Replace those fds with our own
+    si = open('/dev/null', 'r')
     os.dup2(si.fileno(), sys.stdin.fileno())
-    os.dup2(so.fileno(), sys.stdout.fileno())
-    os.dup2(se.fileno(), sys.stderr.fileno())
+
+    try:
+        so = open(logfile, 'a+')
+        se = so
+        os.dup2(so.fileno(), sys.stdout.fileno())
+        os.dup2(se.fileno(), sys.stderr.fileno())
+    except io.UnsupportedOperation:
+        sys.stdout = open(logfile, 'a+')
+        sys.stderr = sys.stdout
 
     function()
 
-- 
2.7.4


