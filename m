Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id F031373243
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 23:15:29 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id t8ANFSpC027318
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 16:15:29 -0700 (PDT)
Received: from msp-dhcp23.wrs.com (172.25.34.23) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.235.1;
	Thu, 10 Sep 2015 16:15:28 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 10 Sep 2015 18:15:27 -0500
Message-ID: <1441926927-134901-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.9.3
MIME-Version: 1.0
Subject: [PATCH] tests/fetch.py: Fix recursion failure in url mapping
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
X-List-Received-Date: Thu, 10 Sep 2015 23:15:30 -0000
Content-Type: text/plain

Instead of reproducessing the same line over and over and over, we remove the
current line from the mirror list.  This permits us to re-evaluate the list
while excluding all matches that have previousily occured.

Without this fix, adding this test results in a failure:

RuntimeError: maximum recursion depth exceeded in cmp

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/__init__.py | 14 ++++++++++----
 lib/bb/tests/fetch.py     |  7 +++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 569007f..288a1c8 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -862,7 +862,7 @@ def build_mirroruris(origud, mirrors, ld):
     replacements["BASENAME"] = origud.path.split("/")[-1]
     replacements["MIRRORNAME"] = origud.host.replace(':','.') + origud.path.replace('/', '.').replace('*', '.')
 
-    def adduri(ud, uris, uds):
+    def adduri(ud, uris, uds, mirrors):
         for line in mirrors:
             try:
                 (find, replace) = line
@@ -876,6 +876,12 @@ def build_mirroruris(origud, mirrors, ld):
                 logger.debug(1, "Mirror %s not in the list of trusted networks, skipping" %  (newuri))
                 continue
 
+            # Create a local copy of the mirrors minus the current line
+            # this will prevent us from recursively processing the same line
+            # as well as indirect recursion A -> B -> C -> A
+            localmirrors = list(mirrors)
+            localmirrors.remove(line)
+
             try:
                 newud = FetchData(newuri, ld)
                 newud.setup_localpath(ld)
@@ -885,16 +891,16 @@ def build_mirroruris(origud, mirrors, ld):
                 try:
                     # setup_localpath of file:// urls may fail, we should still see 
                     # if mirrors of the url exist
-                    adduri(newud, uris, uds)
+                    adduri(newud, uris, uds, localmirrors)
                 except UnboundLocalError:
                     pass
                 continue   
             uris.append(newuri)
             uds.append(newud)
 
-            adduri(newud, uris, uds)
+            adduri(newud, uris, uds, localmirrors)
 
-    adduri(origud, uris, uds)
+    adduri(origud, uris, uds, mirrors)
 
     return uris, uds
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 8486224..94173c1 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -405,13 +405,16 @@ class MirrorUriTest(FetcherTest):
                                 'http://otherdownloads.yoctoproject.org/downloads/bitbake-1.0.tar.gz',
                                 'http://downloads2.yoctoproject.org/downloads/bitbake-1.0.tar.gz'])
 
-    recmirrorvar = "https://.*/[^/]*    http://AAAA/A/A/A/ \n"
+    recmirrorvar = "https://.*/[^/]*    http://AAAA/A/A/A/ \n" \
+                   "https://.*/[^/]*    https://BBBB/B/B/B/ \n"
 
     def test_recursive(self):
         fetcher = bb.fetch.FetchData("https://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
         mirrors = bb.fetch2.mirror_from_string(self.recmirrorvar)
         uris, uds = bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
-        self.assertEqual(uris, ['http://AAAA/A/A/A/bitbake/bitbake-1.0.tar.gz'])
+        self.assertEqual(uris, ['http://AAAA/A/A/A/bitbake/bitbake-1.0.tar.gz',
+                                'https://BBBB/B/B/B/bitbake/bitbake-1.0.tar.gz',
+                                'http://AAAA/A/A/A/B/B/bitbake/bitbake-1.0.tar.gz'])
 
 class FetcherLocalTest(FetcherTest):
     def setUp(self):
-- 
1.9.3


