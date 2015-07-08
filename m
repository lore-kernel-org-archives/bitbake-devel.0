Return-Path: <anibal.limon@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 74A5D65CBD
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 23:32:15 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP; 08 Jul 2015 16:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,435,1432623600"; d="scan'208";a="521077043"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.155])
	by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2015 16:32:15 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 18:34:18 -0500
Message-Id: <1436398461-26014-5-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1436398461-26014-1-git-send-email-anibal.limon@linux.intel.com>
References: <1436398461-26014-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCHv4 4/7] tests/fetch.py: Add FetchCheckStatusTest tests.
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
X-List-Received-Date: Wed, 08 Jul 2015 23:32:16 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add tests for checkstatus method using http with/without
connection cache.

[YOCTO #7796]

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/tests/fetch.py | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 561650e..1132af5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -710,3 +710,42 @@ class FetchMethodTest(FetcherTest):
                 verstring = ud.method.latest_versionstring(ud, self.d)
                 r = bb.utils.vercmp_string(v, verstring)
                 self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
+
+
+class FetchCheckStatusTest(FetcherTest):
+    test_wget_uris = ["http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2",
+                      "http://www.cups.org/software/ipptool/ipptool-20130731-linux-ubuntu-i686.tar.gz",
+                      "http://www.cups.org/",
+                      "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
+                      "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
+                      "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.3.tar.gz",
+                      "http://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
+                      "http://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz"]
+
+    if os.environ.get("BB_SKIP_NETTESTS") == "yes":
+        print("Unset BB_SKIP_NETTESTS to run network tests")
+    else:
+
+        def test_wget_checkstatus(self):
+            fetch = bb.fetch2.Fetch(self.test_wget_uris, self.d)
+            for u in self.test_wget_uris:
+                ud = fetch.ud[u]
+                m = ud.method
+                ret = m.checkstatus(fetch, ud, self.d)
+                self.assertTrue(ret, msg="URI %s, can't check status" % (u))
+
+
+        def test_wget_checkstatus_connection_cache(self):
+            from bb.fetch2 import FetchConnectionCache
+
+            connection_cache = FetchConnectionCache()
+            fetch = bb.fetch2.Fetch(self.test_wget_uris, self.d,
+                        connection_cache = connection_cache)
+
+            for u in self.test_wget_uris:
+                ud = fetch.ud[u]
+                m = ud.method
+                ret = m.checkstatus(fetch, ud, self.d)
+                self.assertTrue(ret, msg="URI %s, can't check status" % (u))
+
+            connection_cache.close_connections()
-- 
1.9.1


