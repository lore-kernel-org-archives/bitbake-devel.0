Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 0F12F782FE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Sep 2017 04:10:47 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	13 Sep 2017 21:10:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,390,1500966000"; d="scan'208";a="128563971"
Received: from babarret-mobl1.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.71.243])
	by orsmga004.jf.intel.com with ESMTP; 13 Sep 2017 21:10:46 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Sep 2017 16:09:42 +1200
Message-Id: <9123c287db12b826cea69f8270f3635efd205a0c.1505361992.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1505361992.git.paul.eggleton@linux.intel.com>
References: <cover.1505361992.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] cooker: ensure monkey-patching in collect_bbfiles() gets undone on error
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
X-List-Received-Date: Thu, 14 Sep 2017 04:10:47 -0000

In collect_bbfiles() we're monkey-patching os.listdir in order to find
which directories to watch, and then undoing that when we're finished -
however if an exception occurred for any reason there was nothing to
ensure the latter occurred. This may not have caused any issues, but as
this kind of thing really ought to be secured using try...finally just
in case, so do that.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 6de04fc..73a2fef 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1695,25 +1695,25 @@ class CookerCollectFiles(object):
             return origlistdir(d)
 
         os.listdir = ourlistdir
-
-        # Can't use set here as order is important
-        newfiles = []
-        for f in files:
-            if os.path.isdir(f):
-                dirfiles = self.find_bbfiles(f)
-                for g in dirfiles:
-                    if g not in newfiles:
-                        newfiles.append(g)
-            else:
-                globbed = glob.glob(f)
-                if not globbed and os.path.exists(f):
-                    globbed = [f]
-                # glob gives files in order on disk. Sort to be deterministic.
-                for g in sorted(globbed):
-                    if g not in newfiles:
-                        newfiles.append(g)
-
-        os.listdir = origlistdir
+        try:
+            # Can't use set here as order is important
+            newfiles = []
+            for f in files:
+                if os.path.isdir(f):
+                    dirfiles = self.find_bbfiles(f)
+                    for g in dirfiles:
+                        if g not in newfiles:
+                            newfiles.append(g)
+                else:
+                    globbed = glob.glob(f)
+                    if not globbed and os.path.exists(f):
+                        globbed = [f]
+                    # glob gives files in order on disk. Sort to be deterministic.
+                    for g in sorted(globbed):
+                        if g not in newfiles:
+                            newfiles.append(g)
+        finally:
+            os.listdir = origlistdir
 
         bbmask = config.getVar('BBMASK')
 
-- 
2.9.5


