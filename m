Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ke.yu@intel.com>) id 1Qe5U8-0005O3-LD
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jul 2011 15:16:16 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 05 Jul 2011 06:11:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,479,1304319600"; d="scan'208";a="23987870"
Received: from kyu3-dev32.bj.intel.com (HELO localhost) ([10.238.153.187])
	by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2011 06:11:21 -0700
From: Yu Ke <ke.yu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Jul 2011 21:11:09 +0800
Message-Id: <2deaf320be6e019b2f2dad10463fb1bd77f98bbf.1309870780.git.ke.yu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1309870780.git.ke.yu@intel.com>
References: <cover.1309870780.git.ke.yu@intel.com>
In-Reply-To: <cover.1309870780.git.ke.yu@intel.com>
References: <cover.1309870780.git.ke.yu@intel.com>
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
X-List-Received-Date: Tue, 05 Jul 2011 13:16:16 -0000

This patch is for [YOCTO #1085] fix.

If the upstream fails a checksum, retry from the MIRROR before giving up.
This will add more robust fetching if an upstream serves a bad file or webpage.

fetching of distcc prior to the move from samba -> googlecode is a good example
of this.

Signed-off-by: Yu Ke <ke.yu@intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index e9a64c5..bb9dbbe 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -278,6 +278,15 @@ def verify_checksum(u, ud, d):
     if BB_STRICT_CHECKSUM = "1" then return false as unmatched, otherwise return true as
     matched
     """
+    # Only check the checksums if we've not seen this item before
+    if os.path.exists(ud.donestamp):
+        # Touch the done stamp file to show active use of the download
+        try:
+            os.utime(ud.donestamp, None)
+        except:
+            # Errors aren't fatal here
+            pass
+        return
 
     if not ud.type in ["http", "https", "ftp", "ftps"]:
         return
@@ -300,6 +309,9 @@ def verify_checksum(u, ud, d):
     if ud.sha256_expected != sha256data:
         raise SHA256SumError(ud.localpath, ud.sha256_expected, sha256data, u)
 
+    # Create the stamp to avoid duplicate checking
+    open(ud.donestamp, 'w').close()
+
 def subprocess_setup():
     import signal
     # Python installs a SIGPIPE handler by default. This is usually not what
@@ -932,6 +944,9 @@ class Fetch(object):
                         if hasattr(m, "build_mirror_data"):
                             m.build_mirror_data(u, ud, self.d)
                         localpath = ud.localpath
+                        # early checksum verify, so that if checksum mismatched,
+                        # fetcher still have chance to fetch from mirror
+                        verify_checksum(u, ud, self.d)
 
                     except bb.fetch2.NetworkAccess:
                         raise
@@ -948,17 +963,7 @@ class Fetch(object):
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
+                verify_checksum(u, ud, self.d)
 
             finally:
                 bb.utils.unlockfile(lf)
-- 
1.7.0.4



