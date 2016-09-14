Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DEF1A734B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Sep 2016 21:29:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8ELTjT7004047 for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Sep 2016 22:29:45 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dEzZNk7tGaXI for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Sep 2016 22:29:45 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8ELThmt004043
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Sep 2016 22:29:44 +0100
Message-ID: <1473888583.7207.63.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Sep 2016 22:29:43 +0100
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] build: Allow dirs/cleandirs to work for empty functions
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
X-List-Received-Date: Wed, 14 Sep 2016 21:29:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Users are surprised when dirs/cleandirs aren't acted upon for
empty functions. This reorders the code slightly so that those
flags are acted upon for empty functions as there are cases where
this is expected.

[YOCTO #10256]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 9dfcfec..5759502 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -193,12 +193,6 @@ def exec_func(func, d, dirs = None, pythonexception=False):
     except:
         oldcwd = None
 
-    body = d.getVar(func, False)
-    if not body:
-        if body is None:
-            logger.warning("Function %s doesn't exist", func)
-        return
-
     flags = d.getVarFlags(func)
     cleandirs = flags.get('cleandirs')
     if cleandirs:
@@ -217,6 +211,13 @@ def exec_func(func, d, dirs = None, pythonexception=False):
         adir = dirs[-1]
     else:
         adir = None
+
+    body = d.getVar(func, False)
+    if not body:
+        if body is None:
+            logger.warning("Function %s doesn't exist", func)
+        return
+
     ispython = flags.get('python')
 
     lockflag = flags.get('lockfiles')



