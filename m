Return-Path: <anibal.limon@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id A920175EE7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Jul 2015 00:31:02 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 14 Jul 2015 17:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,476,1432623600"; d="scan'208";a="729009077"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.5.54])
	by orsmga001.jf.intel.com with ESMTP; 14 Jul 2015 17:31:03 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jul 2015 19:30:58 -0500
Message-Id: <1436920259-31969-4-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1436920259-31969-1-git-send-email-anibal.limon@linux.intel.com>
References: <1436920259-31969-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Cc: alexander.kanavin@linux.intel.com
Subject: [PATCH 3/4] fetch2/wget.py: latest_versionstring now returns (version, revision)
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
X-List-Received-Date: Wed, 15 Jul 2015 00:31:04 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now latest_versionstring method returns (version, revision) for comply
the new return convention needed by SCM's like git get the current
revision.

bb/tests/fetch.py: Updated wget latest_versionstring test for comply new
convention.

[YOCTO #7605]

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 12 ++++++------
 lib/bb/tests/fetch.py |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 545f02d..425b6b9 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -507,12 +507,12 @@ class Wget(FetchMethod):
         if not re.search("\d+", package):
             current_version[1] = re.sub('_', '.', current_version[1])
             current_version[1] = re.sub('-', '.', current_version[1])
-            return current_version[1]
+            return (current_version[1], '')
 
         package_regex = self._init_regexes(package, ud, d)
         if package_regex is None:
             bb.warn("latest_versionstring: package %s don't match pattern" % (package))
-            return ""
+            return ('', '')
         bb.debug(3, "latest_versionstring, regex: %s" % (package_regex.pattern))
 
         uri = ""
@@ -530,12 +530,12 @@ class Wget(FetchMethod):
 
                 dirver_pn_regex = re.compile("%s\d?" % (re.escape(pn)))
                 if not dirver_pn_regex.search(dirver):
-                    return self._check_latest_version_by_dir(dirver,
-                        package, package_regex, current_version, ud, d)
+                    return (self._check_latest_version_by_dir(dirver,
+                        package, package_regex, current_version, ud, d), '')
 
             uri = bb.fetch.encodeurl([ud.type, ud.host, path, ud.user, ud.pswd, {}])
         else:
             uri = regex_uri
 
-        return self._check_latest_version(uri, package, package_regex,
-                current_version, ud, d)
+        return (self._check_latest_version(uri, package, package_regex,
+                current_version, ud, d), '')
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 8dd8ddb..bfa31d0 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -708,7 +708,8 @@ class FetchMethodTest(FetcherTest):
                 self.d.setVar("REGEX_URI", k[2])
                 self.d.setVar("REGEX", k[3])
                 ud = bb.fetch2.FetchData(k[1], self.d)
-                verstring = ud.method.latest_versionstring(ud, self.d)
+                pupver = ud.method.latest_versionstring(ud, self.d)
+                verstring = pupver[0]
                 r = bb.utils.vercmp_string(v, verstring)
                 self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
 
-- 
1.9.1


