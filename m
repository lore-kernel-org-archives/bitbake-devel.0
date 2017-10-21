Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6D478782FC
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 21 Oct 2017 12:06:44 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v9LC6hVV002801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sat, 21 Oct 2017 13:06:44 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1e5sY6-0001Ft-UW; Sat, 21 Oct 2017 13:06:42 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 21 Oct 2017 13:06:39 +0100
Message-Id: <1508587599-4787-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] main: Give a user readable error if we can't locate topdir
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
X-List-Received-Date: Sat, 21 Oct 2017 12:06:44 -0000

Currently if you run bitbake in an invalid directory, the user experience
is poor:

birbake/lib/bb/main.py", line 427, in setup_bitbake
    topdir, lock = lockBitbake()
  File "./bitbake/lib/bb/main.py", line 494, in lockBitbake
    lockfile = topdir + "/bitbake.lock"
TypeError: unsupported operand type(s) for +: 'NoneType' and 'str'

This ensures we exit straight away with a better error message.

[YOCTO #12163]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index a488c3d..7711b29 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -47,6 +47,9 @@ logger = logging.getLogger("BitBake")
 class BBMainException(Exception):
     pass
 
+class BBMainFatal(bb.BBHandledException):
+    pass
+
 def present_options(optionlist):
     if len(optionlist) > 1:
         return ' or '.join([', '.join(optionlist[:-1]), optionlist[-1]])
@@ -461,6 +464,8 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
 
                 if server_connection or configParams.server_only:
                     break
+            except BBMainFatal:
+                raise
             except (Exception, bb.server.process.ProcessTimeout) as e:
                 if not retries:
                     raise
@@ -491,6 +496,9 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
 
 def lockBitbake():
     topdir = bb.cookerdata.findTopdir()
+    if not topdir:
+        bb.error("Unable to find conf/bblayers.conf or conf/bitbake.conf. BBAPTH is unset and/or not in a build directory?")
+        raise BBMainFatal
     lockfile = topdir + "/bitbake.lock"
     return topdir, bb.utils.lockfile(lockfile, False, False)
 
-- 
2.7.4


