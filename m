Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ke.yu@intel.com>) id 1QgvVy-0006Bk-7t
	for bitbake-devel@lists.openembedded.org;
	Wed, 13 Jul 2011 11:13:54 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 13 Jul 2011 02:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,524,1304319600"; d="scan'208";a="27117807"
Received: from kyu3-dev32.bj.intel.com (HELO localhost) ([10.238.153.187])
	by orsmga001.jf.intel.com with ESMTP; 13 Jul 2011 02:09:54 -0700
From: Yu Ke <ke.yu@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Wed, 13 Jul 2011 17:08:39 +0800
Message-Id: <20229b88536b6696ff2d58ac702bbbd6b55a6ccf.1310547939.git.ke.yu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1310547939.git.ke.yu@intel.com>
References: <cover.1310547939.git.ke.yu@intel.com>
In-Reply-To: <cover.1310547939.git.ke.yu@intel.com>
References: <cover.1310547939.git.ke.yu@intel.com>
Subject: [PATCH 1/1] fetcher2: retry mirror if upstream checksum mismatch
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 13 Jul 2011 09:13:54 -0000

This patch is for [YOCTO #1085] fix.

If the upstream fails a checksum, retry from the MIRROR before giving up.
This will add more robust fetching if an upstream serves a bad file or webpage.

fetching of distcc prior to the move from samba -> googlecode is a good example
of this.

Signed-off-by: Yu Ke <ke.yu@intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index e9a64c5..d39f094 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -300,6 +300,22 @@ def verify_checksum(u, ud, d):
     if ud.sha256_expected != sha256data:
         raise SHA256SumError(ud.localpath, ud.sha256_expected, sha256data, u)
 
+def update_stamp(u, ud, d):
+    """
+        donestamp is file stamp indicating the whole fetching is done
+        this function update the stamp after verifying the checksum
+    """
+    if os.path.exists(ud.donestamp):
+        # Touch the done stamp file to show active use of the download
+        try:
+            os.utime(ud.donestamp, None)
+        except:
+            # Errors aren't fatal here
+            pass
+    else:
+        verify_checksum(u, ud, d)
+        open(ud.donestamp, 'w').close()
+
 def subprocess_setup():
     import signal
     # Python installs a SIGPIPE handler by default. This is usually not what
@@ -932,6 +948,9 @@ class Fetch(object):
                         if hasattr(m, "build_mirror_data"):
                             m.build_mirror_data(u, ud, self.d)
                         localpath = ud.localpath
+                        # early checksum verify, so that if checksum mismatched,
+                        # fetcher still have chance to fetch from mirror
+                        update_stamp(u, ud, self.d)
 
                     except bb.fetch2.NetworkAccess:
                         raise
@@ -948,17 +967,7 @@ class Fetch(object):
                 if not localpath or ((not os.path.exists(localpath)) and localpath.find("*") == -1):
                     raise FetchError("Unable to fetch URL %s from any source." % u, u)
 
-                if os.path.exists(ud.donestamp):
-                    # Touch the done stamp file to show active use of the download
-                    try:
-                        os.utime(ud.donestamp, None)
-                    except:
-                        # Errors aren't fatal here
-                        pass
-                else:
-                    # Only check the checksums if we've not seen this item before, then create the stamp
-                    verify_checksum(u, ud, self.d)
-                    open(ud.donestamp, 'w').close()
+                update_stamp(u, ud, self.d)
 
             finally:
                 bb.utils.unlockfile(lf)
-- 
1.7.0.4



