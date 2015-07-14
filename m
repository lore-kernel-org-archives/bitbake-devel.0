Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id E0F4165C78
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jul 2015 14:26:50 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 14 Jul 2015 07:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,472,1432623600"; d="scan'208";a="728648425"
Received: from cbernard-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.31.54])
	by orsmga001.jf.intel.com with ESMTP; 14 Jul 2015 07:26:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jul 2015 15:26:42 +0100
Message-Id: <9e1bc2c543fe8c64f8ba83dbfebca311a1c3fad3.1436883632.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1436883632.git.paul.eggleton@linux.intel.com>
References: <cover.1436883632.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1436883632.git.paul.eggleton@linux.intel.com>
References: <cover.1436883632.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] lib/bb/process: check output of select() before reading extrafiles
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
X-List-Received-Date: Tue, 14 Jul 2015 14:26:51 -0000

We're calling select() to find the fds that have data available, so we
really ought to check the return to see if the extra file is in there
before trying to read from it. This is part of the fix for the
performance regression that this code introduced (5-10 minutes extra in
a reasonable size OE build); the rest is down to an issue in the way
that pseudo currently handles FIFOs and will need to be addressed there,
see: https://bugzilla.yoctoproject.org/show_bug.cgi?id=7993

Solution suggested by Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/process.py | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/bb/process.py b/lib/bb/process.py
index d95a03d..7c79785 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -83,15 +83,16 @@ def _logged_communicate(pipe, log, input, extrafiles):
         bb.utils.nonblockingfd(fobj.fileno())
         rin.append(fobj)
 
-    def readextras():
+    def readextras(selected):
         for fobj, func in extrafiles:
-            try:
-                data = fobj.read()
-            except IOError as err:
-                if err.errno == errno.EAGAIN or err.errno == errno.EWOULDBLOCK:
-                    data = None
-            if data is not None:
-                func(data)
+            if fobj in selected:
+                try:
+                    data = fobj.read()
+                except IOError as err:
+                    if err.errno == errno.EAGAIN or err.errno == errno.EWOULDBLOCK:
+                        data = None
+                if data is not None:
+                    func(data)
 
     try:
         while pipe.poll() is None:
@@ -114,12 +115,12 @@ def _logged_communicate(pipe, log, input, extrafiles):
                     errdata.append(data)
                     log.write(data)
 
-            readextras()
+            readextras(r)
 
     finally:    
         log.flush()
 
-    readextras()
+    readextras([fobj for fobj, _ in extrafiles])
 
     if pipe.stdout is not None:
         pipe.stdout.close()
-- 
2.1.0


