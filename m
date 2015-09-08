Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4776865C8A
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Sep 2015 22:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t88MVRe9012223 for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Sep 2015 23:31:27 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id N6T8Dh4gxvNC for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Sep 2015 23:31:27 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t88MVDOn012219
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Sep 2015 23:31:25 +0100
Message-ID: <1441751473.24871.288.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 08 Sep 2015 23:31:13 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] utils: Add signal_on_parent_exit() function
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
X-List-Received-Date: Tue, 08 Sep 2015 22:31:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Add a new bb.utils.signal_on_parent_exit() function so that a process
can register to recieve a signal when the parent dies. There is no
POSIX standard for this and the implementation is Linux specific.
Alternatives would be having an open pipe or polling os.getppid()
for changes but this seems more effective and less invasive to most
of bitbake's code structure.

We need to be able to determine when parents die to ensure child
processes stop running in a variety of circumstances to avoid
locks being held and ensure clean shutdown.

Roughly based on https://gist.github.com/evansd/2346614

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 6f7abf6..0776ff9 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -35,6 +35,8 @@ import errno
 import signal
 from commands import getstatusoutput
 from contextlib import contextmanager
+from ctypes import cdll
+
 
 logger = logging.getLogger("BitBake.Util")
 
@@ -1290,3 +1292,20 @@ def get_file_layer(filename, d):
         result = path_to_layer(filename)
 
     return result
+
+
+# Constant taken from http://linux.die.net/include/linux/prctl.h
+PR_SET_PDEATHSIG = 1
+
+class PrCtlError(Exception):
+    pass
+
+def signal_on_parent_exit(signame):
+    """
+    Trigger signame to be sent when the parent process dies
+    """
+    signum = getattr(signal, signame)
+    # http://linux.die.net/man/2/prctl
+    result = cdll['libc.so.6'].prctl(PR_SET_PDEATHSIG, signum)
+    if result != 0:
+        raise PrCtlError('prctl failed with error code %s' % result)



