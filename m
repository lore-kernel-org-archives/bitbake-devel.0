Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 876526E63E
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 18:12:44 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 03 Nov 2014 10:10:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,691,1406617200"; d="scan'208";a="484151872"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.154])
	by orsmga003.jf.intel.com with ESMTP; 03 Nov 2014 10:11:08 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Nov 2014 12:12:52 -0600
Message-Id: <1415038373-12763-2-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1415038373-12763-1-git-send-email-anibal.limon@linux.intel.com>
References: <1415038373-12763-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] tests/fetch: improve unittest for git method latest_versionstring
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
X-List-Received-Date: Mon, 03 Nov 2014 18:12:46 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changed version searching comparision from == to >= this makes
the test less fragile.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>

fetch/git: Rename _latest_versionstring to latest_versionstring.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>

tests/fetch: unittest for git method latest_versionstring

Signed-off-by: Irina Patru <irina.patru@intel.com>
Signed-off-by: Saul Wold <sgw@linux.intel.com>

fetch/git: Add latest_versionstring method

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Saul Wold <sgw@linux.intel.com>
---
 lib/bb/fetch2/git.py  | 38 ++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/fetch.py | 44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 799fb6c..ce647c2 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -67,6 +67,7 @@ Supported SRC_URI options are:
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
+import re
 import bb
 from   bb    import data
 from   bb.fetch2 import FetchMethod
@@ -343,6 +344,43 @@ class Git(FetchMethod):
         output = self._lsremote(ud, d, search)
         return output.split()[0]
 
+    def latest_versionstring(self, ud, d):
+        """
+        Compute the latest release name like "x.y.x" in "x.y.x+gitHASH"
+        by searching through the tags output of ls-remote, comparing
+        versions and returning the highest match.
+        """
+        verstring = ""
+        tagregex = re.compile(d.getVar('GITTAGREGEX', True) or "(?P<pver>([0-9][\.|_]?)+)")
+        try:
+            output = self._lsremote(ud, d, "refs/tags/*^{}")
+        except bb.fetch2.FetchError or bb.fetch2.NetworkAccess:
+            return ""
+
+        for line in output.split("\n"):
+            if not line:
+                break
+
+            line = line.split("/")[-1]
+            # Ignore non-released branches
+            m = re.search("(alpha|beta|rc|final)+", line)
+            if m:
+                continue
+
+            # search for version in the line
+            tag = tagregex.search(line)
+            if tag == None:
+                continue
+
+            tag = tag.group('pver')
+            tag = tag.replace("_", ".")
+
+            if verstring and bb.utils.vercmp(("0", tag, ""), ("0", verstring, "")) < 0:
+                continue
+            verstring = tag
+
+        return verstring
+
     def _build_revision(self, ud, d, name):
         return ud.revisions[name]
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 7df7a0e..e0eefd3 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -24,6 +24,7 @@ import tempfile
 import subprocess
 import os
 from bb.fetch2 import URI
+from bb.fetch2 import FetchMethod
 import bb
 
 class URITest(unittest.TestCase):
@@ -558,5 +559,46 @@ class URLHandle(unittest.TestCase):
             result = bb.fetch.encodeurl(v)
             self.assertEqual(result, k)
 
+class FetchMethodTest(FetcherTest):
+
+    test_git_uris = {
+        # version pattern "X.Y.Z"
+        ("mx-1.0", "git://github.com/clutter-project/mx.git;branch=mx-1.4", "9b1db6b8060bd00b121a692f942404a24ae2960f", "")
+            : "1.99.4",
+        # version pattern "vX.Y"
+        ("mtd-utils", "git://git.infradead.org/mtd-utils.git", "ca39eb1d98e736109c64ff9c1aa2a6ecca222d8f", "")
+            : "1.5.0",
+        # version pattern "pkg_name-X.Y"
+        ("presentproto", "git://anongit.freedesktop.org/git/xorg/proto/presentproto", "24f3a56e541b0a9e6c6ee76081f441221a120ef9", "")
+            : "1.0",
+        # version pattern "pkg_name-vX.Y.Z"
+        ("dtc", "git://git.qemu.org/dtc.git", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "")
+            : "1.4.0",
+        # combination version pattern
+        ("sysprof", "git://git.gnome.org/sysprof", "cd44ee6644c3641507fb53b8a2a69137f2971219", "")
+            : "1.2.0",
+        ("u-boot-mkimage", "git://git.denx.de/u-boot.git;branch=master;protocol=git", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "")
+            : "2014.01",
+        # version pattern "yyyymmdd"
+        ("mobile-broadband-provider-info", "git://git.gnome.org/mobile-broadband-provider-info", "4ed19e11c2975105b71b956440acdb25d46a347d", "")
+            : "20120614",
+        # packages with a valid GITTAGREGEX
+        ("xf86-video-omap", "git://anongit.freedesktop.org/xorg/driver/xf86-video-omap", "ae0394e687f1a77e966cf72f895da91840dffb8f", "(?P<pver>(\d+\.(\d\.?)*))")
+            : "0.4.3",
+        ("build-appliance-image", "git://git.yoctoproject.org/poky", "b37dd451a52622d5b570183a81583cc34c2ff555", "(?P<pver>(([0-9][\.|_]?)+[0-9]))")
+            : "11.0.0",
+        ("chkconfig-alternatives-native", "git://github.com/kergoth/chkconfig;branch=sysroot", "cd437ecbd8986c894442f8fce1e0061e20f04dee", "chkconfig\-(?P<pver>((\d+[\.\-_]*)+))")
+            : "1.3.59",
+        ("remake", "git://github.com/rocky/remake.git", "f05508e521987c8494c92d9c2871aec46307d51d", "(?P<pver>(\d+\.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))")
+            : "3.82+dbg0.9",
+    }
 
-
+    def test_git_latest_versionstring(self):
+        for k, v in self.test_git_uris.items():
+            self.d.setVar("SRCREV", k[2])
+            self.d.setVar("GITTAGREGEX", k[3])
+            ud = bb.fetch2.FetchData(k[1], self.d)
+            verstring = ud.method.latest_versionstring(ud, self.d)
+            print("Package %s, version: %s <= %s" % (k[0], v, verstring))
+            r = bb.utils.vercmp_string(v, verstring)
+            self.assertTrue(r == -1 or r == 0)
-- 
1.9.1


