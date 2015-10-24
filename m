Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id BC9007680C
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Oct 2015 10:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9OAJI9n027148; Sat, 24 Oct 2015 11:19:18 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AHpYkqtdIa6I; Sat, 24 Oct 2015 11:19:18 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9OAJ6AS027145
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 24 Oct 2015 11:19:17 +0100
Message-ID: <1445681946.21913.52.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 24 Oct 2015 11:19:06 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: "Avery, Brian" <brian.avery@intel.com>,
	Tracy Graydon <tracy.graydon@intel.com>, "Witt,
	Randy E" <randy.e.witt@intel.com>, Scott Rifenbark <srifenbark@gmail.com>
Subject: [PATCH] build/utils: Add BB_TASK_IONICE_LEVEL support
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
X-List-Received-Date: Sat, 24 Oct 2015 10:19:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Similarly to BB_TASK_NICE_LEVEL, add BB_TASK_IONICE_LEVEL which allows the ioprio
of tasks to be adjusted. This is in response to various qemu runtime timeouts
which have been witnessed on the autobuilder, seemingly due to IO starvation (we
already use NICE_LEVEL to adjust tasks). This has a fairly urgent need to deal
with certain 'random' failures we're seeing on the autobuilders in testing.

The format of the data in the variable is BB_TASK_IONICE_LEVEL = "<class>.<prio>".

For <class>, 2 is best effort (the default), 1 is real time and 3 is idle. You'd
need superuser privileges to use realtime. The <prio> value is a default of 4, 
and can be set between 0 and 7 with 7 being lowest priority and 0 the highest. 
The user can set this freely with normal privileges 

Note that in order for this to take effect, you need the cfq scheduler selected
for the backing block device.

We could use nice wrapper functions for ioprio from modules like psutil however
that would complicate bitbake dependencies. This version has some magic numbers
but works on the main 32 and 64 bit x86 build architectures and can easily be
extended if ever needed. When we move to python 3.x, we can likely replace this
with standard calls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 948c395..22428a6 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -413,6 +413,13 @@ def _exec_task(fn, task, d, quieterr):
         nice = int(nice) - curnice
         newnice = os.nice(nice)
         logger.debug(1, "Renice to %s " % newnice)
+    ionice = localdata.getVar("BB_TASK_IONICE_LEVEL", True)
+    if ionice:
+        try:
+            cls, prio = ionice.split(".", 1)
+            bb.utils.ioprio_set(os.getpid(), int(cls), int(prio))
+        except:
+            bb.warn("Invalid ionice level %s" % ionice)
 
     bb.utils.mkdirhier(tempdir)
 
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index eb219c1..86a5328 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1310,3 +1310,27 @@ def signal_on_parent_exit(signame):
     result = cdll['libc.so.6'].prctl(PR_SET_PDEATHSIG, signum)
     if result != 0:
         raise PrCtlError('prctl failed with error code %s' % result)
+
+#
+# Manually call the ioprio syscall. We could depend on other libs like psutil
+# however this gets us enough of what we need to bitbake for now without the
+# dependency
+#
+_unamearch = os.uname()[4]
+IOPRIO_WHO_PROCESS = 1
+IOPRIO_CLASS_SHIFT = 13
+
+def ioprio_set(who, cls, value):
+    NR_ioprio_set = None
+    if _unamearch == "x86_64":
+      NR_ioprio_set = 251
+    elif _unamearch[0] == "i" and _unamearch[2:3] == "86":
+      NR_ioprio_set = 289
+
+    if NR_ioprio_set:
+        ioprio = value | (cls << IOPRIO_CLASS_SHIFT)
+        rc = cdll['libc.so.6'].syscall(NR_ioprio_set, IOPRIO_WHO_PROCESS, who, ioprio)
+        if rc != 0:
+            raise ValueError("Unable to set ioprio, syscall returned %s" % rc)
+    else:
+        bb.warn("Unable to set IO Prio for arch %s" % _unamearch)



