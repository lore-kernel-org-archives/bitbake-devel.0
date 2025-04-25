Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF07C369D7
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 14:48:20 +0000 (UTC)
Received: from esa12.hc324-48.eu.iphmx.com (esa12.hc324-48.eu.iphmx.com [207.54.72.34])
 by mx.groups.io with SMTP id smtpd.web10.8243.1745592492730691985
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 07:48:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=DGDuUfqX;
 spf=pass (domain: bmw.de, ip: 207.54.72.34, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745592495; x=1777128495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFUs339dldr+AL+nMX5mR8UYsSCYNtjbSwumyxZ306Q=;
  b=DGDuUfqXf7dMU/nRsYzKLGcCkSoE3Ec1tQlcp3unPX3ODeAQ/8xB8AR4
   47Cf+HM68qiKbLjBGdAv1B5G0vMvFAc0tBSGpUjH8V9oqJfwDCeSahEFW
   oyKGvySE57/NVAwpbRJmZbkrp3NOJM2+8S8zVFzvvxxt1p7SJVnlXA1P9
   U=;
X-CSE-ConnectionGUID: u3yw+TkfT72bMce837mELA==
X-CSE-MsgGUID: Puwn2mYvTjKgIoGWEtVRpg==
Received: from 160.46.252.49.spf.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa12.hc324-48.eu.iphmx.com with ESMTP/TLS; 25 Apr 2025 16:48:11 +0200
Received: from esabb1.muc ([160.50.100.31])  by esagw6.muc with ESMTP/TLS;
 25 Apr 2025 16:48:08 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb1.muc with ESMTP/TLS; 25 Apr 2025 16:48:07 +0200
Received: from localhost.localdomain (10.30.85.205) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 16:48:07 +0200
X-CSE-ConnectionGUID: k1wOaKcDRsuryqRFx68MfQ==
X-CSE-MsgGUID: XDFJxF15QxivkR+y4mPbmw==
X-CSE-ConnectionGUID: Yx6AvvD1RlOyB0gYntfgww==
X-CSE-MsgGUID: /t4HeNcOSrK5UadmDyENSg==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v3 2/8] tests/fetch: Move commonly used imports to top
Date: Fri, 25 Apr 2025 16:41:32 +0200
Message-ID: <20250425144138.4089681-3-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425144138.4089681-1-philip.lorenz@bmw.de>
References: <20250425144138.4089681-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp17a.europe.bmw.corp (2a03:1e80:a15:58f::1:3a) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 14:48:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17571

Avoid multiple import statements for anything that is used more than
once. Additionally, drop no longer used imports.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/tests/fetch.py | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 196d93c41..f0c628524 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -7,7 +7,9 @@
 #
 
 import contextlib
+import shutil
 import unittest
+import urllib.parse
 import hashlib
 import tempfile
 import collections
@@ -1275,7 +1277,6 @@ class FetcherNetworkTest(FetcherTest):
 
 class SVNTest(FetcherTest):
     def skipIfNoSvn():
-        import shutil
         if not shutil.which("svn"):
             return unittest.skip("svn not installed,  tests being skipped")
 
@@ -1398,8 +1399,6 @@ class TrustedNetworksTest(FetcherTest):
         self.assertFalse(bb.fetch.trusted_network(self.d, url))
 
 class URLHandle(unittest.TestCase):
-    import urllib.parse
-
     # Quote password as per RFC3986
     password = urllib.parse.quote(r"!#$%^&*()-_={}[]\|:?,.<>~`", r"!$&'/()*+,;=")
     datatable = {
@@ -1426,7 +1425,6 @@ class URLHandle(unittest.TestCase):
             self.assertEqual(result, v)
 
     def test_encodeurl(self):
-        import urllib.parse
         for k, v in self.datatable.items():
             result = bb.fetch.encodeurl(v)
             if result.startswith("file:"):
@@ -2271,7 +2269,6 @@ class GitShallowTest(FetcherTest):
 
 class GitLfsTest(FetcherTest):
     def skipIfNoGitLFS():
-        import shutil
         if not shutil.which('git-lfs'):
             return unittest.skip('git-lfs not installed')
         return lambda f: f
@@ -2391,8 +2388,6 @@ class GitLfsTest(FetcherTest):
 
     @skipIfNoGitLFS()
     def test_lfs_enabled(self):
-        import shutil
-
         uri = 'git://%s;protocol=file;lfs=1;branch=master' % self.srcdir
         self.d.setVar('SRC_URI', uri)
 
@@ -2403,8 +2398,6 @@ class GitLfsTest(FetcherTest):
 
     @skipIfNoGitLFS()
     def test_lfs_disabled(self):
-        import shutil
-
         uri = 'git://%s;protocol=file;lfs=0;branch=master' % self.srcdir
         self.d.setVar('SRC_URI', uri)
 
@@ -2414,8 +2407,6 @@ class GitLfsTest(FetcherTest):
         fetcher.unpack(self.d.getVar('WORKDIR'))
 
     def test_lfs_enabled_not_installed(self):
-        import shutil
-
         uri = 'git://%s;protocol=file;lfs=1;branch=master' % self.srcdir
         self.d.setVar('SRC_URI', uri)
 
@@ -2436,8 +2427,6 @@ class GitLfsTest(FetcherTest):
             ud.method._find_git_lfs = old_find_git_lfs
 
     def test_lfs_disabled_not_installed(self):
-        import shutil
-
         uri = 'git://%s;protocol=file;lfs=0;branch=master' % self.srcdir
         self.d.setVar('SRC_URI', uri)
 
@@ -2611,7 +2600,6 @@ class CrateTest(FetcherTest):
 
 class NPMTest(FetcherTest):
     def skipIfNoNpm():
-        import shutil
         if not shutil.which('npm'):
             return unittest.skip('npm not installed')
         return lambda f: f
@@ -3294,7 +3282,6 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".format(self.mirrordir) + " \n")
 
     def make_git_repo(self):
-        import shutil
         self.mirrorname = "git2_git.yoctoproject.org.fstests.tar.gz"
         os.makedirs(self.clonedir)
         self.git("clone --bare {}".format(self.recipe_url), self.clonedir)
@@ -3324,7 +3311,6 @@ class FetchPremirroronlyMercurialTest(FetcherTest):
         the test covers also basic hg:// clone (see fetch_and_create_tarball
     """
     def skipIfNoHg():
-        import shutil
         if not shutil.which('hg'):
             return unittest.skip('Mercurial not installed')
         return lambda f: f
@@ -3380,7 +3366,6 @@ class FetchPremirroronlyBrokenTarball(FetcherTest):
             targz.write("This is not tar.gz file!")
 
     def test_mirror_broken_download(self):
-        import sys
         self.d.setVar("SRCREV", "0"*40)
         fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
         with self.assertRaises(bb.fetch2.FetchError), self.assertLogs() as logs:

