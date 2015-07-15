Return-Path: <anibal.limon@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id B9EC175979
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Jul 2015 00:31:01 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 14 Jul 2015 17:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,476,1432623600"; d="scan'208";a="729009053"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.5.54])
	by orsmga001.jf.intel.com with ESMTP; 14 Jul 2015 17:31:02 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jul 2015 19:30:57 -0500
Message-Id: <1436920259-31969-3-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1436920259-31969-1-git-send-email-anibal.limon@linux.intel.com>
References: <1436920259-31969-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Cc: alexander.kanavin@linux.intel.com
Subject: [PATCH 2/4] fetch2/git.py: latest_versionstring now returns (version, revision)
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
X-List-Received-Date: Wed, 15 Jul 2015 00:31:01 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We need to know the revision associated with the upstream version in
SCM like git, this change broke return convention, oe-core recipeutils
get_recipe_upstream_version need to be updated.

tests/fetch.py: Updated git latest_versionstring test for comply new
convention.

[YOCTO #7605]

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/git.py  | 18 ++++++++++++------
 lib/bb/tests/fetch.py |  3 ++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 706fff5..374d846 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -371,25 +371,28 @@ class Git(FetchMethod):
         by searching through the tags output of ls-remote, comparing
         versions and returning the highest match.
         """
-        verstring = ""
+        pupver = ('', '')
+
         tagregex = re.compile(d.getVar('GITTAGREGEX', True) or "(?P<pver>([0-9][\.|_]?)+)")
         try:
             output = self._lsremote(ud, d, "refs/tags/*")
         except bb.fetch2.FetchError or bb.fetch2.NetworkAccess:
-            return ""
+            return pupver
 
+        verstring = ""
+        revision = ""
         for line in output.split("\n"):
             if not line:
                 break
 
-            line = line.split("/")[-1]
+            tag_head = line.split("/")[-1]
             # Ignore non-released branches
-            m = re.search("(alpha|beta|rc|final)+", line)
+            m = re.search("(alpha|beta|rc|final)+", tag_head)
             if m:
                 continue
 
             # search for version in the line
-            tag = tagregex.search(line)
+            tag = tagregex.search(tag_head)
             if tag == None:
                 continue
 
@@ -398,9 +401,12 @@ class Git(FetchMethod):
 
             if verstring and bb.utils.vercmp(("0", tag, ""), ("0", verstring, "")) < 0:
                 continue
+
             verstring = tag
+            revision = line.split()[0]
+            pupver = (verstring, revision)
 
-        return verstring
+        return pupver
 
     def _build_revision(self, ud, d, name):
         return ud.revisions[name]
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 13555bd..8dd8ddb 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -697,7 +697,8 @@ class FetchMethodTest(FetcherTest):
                 self.d.setVar("SRCREV", k[2])
                 self.d.setVar("GITTAGREGEX", k[3])
                 ud = bb.fetch2.FetchData(k[1], self.d)
-                verstring = ud.method.latest_versionstring(ud, self.d)
+                pupver= ud.method.latest_versionstring(ud, self.d)
+                verstring = pupver[0]
                 r = bb.utils.vercmp_string(v, verstring)
                 self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
 
-- 
1.9.1


