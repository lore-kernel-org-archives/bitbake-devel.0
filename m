Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B723C3ABA1
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 10:18:38 +0000 (UTC)
Received: from esa6.hc324-48.eu.iphmx.com (esa6.hc324-48.eu.iphmx.com [207.54.71.69])
 by mx.groups.io with SMTP id smtpd.web10.3559.1745576309445575421
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 03:18:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=ZUasTNHe;
 spf=pass (domain: bmw.de, ip: 207.54.71.69, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745576309; x=1777112309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFUs339dldr+AL+nMX5mR8UYsSCYNtjbSwumyxZ306Q=;
  b=ZUasTNHeEO2XS+GW/DHZKSNjaXHqx6rMAvn5j5K+tR6nzT87Cyen7Pq/
   oD5qFlB5QYRsvNy7gOrSFZzJKdSw8wcm60UbJegXlETtJjDrmG1X89Ihx
   gGASZHdJ5Yx3zBvPNUEBP5DwyuL0D+ZSSsBZ3eAx7MKQqyBaTjrzXz8fN
   k=;
X-CSE-ConnectionGUID: mCnDBbWVSDeAF3d5As26gg==
X-CSE-MsgGUID: 1zPe+TxTQUCvAZdRReg8zA==
Received: from 160.46.252.38.spf.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
 esa6.hc324-48.eu.iphmx.com with ESMTP/TLS; 25 Apr 2025 12:18:27 +0200
Received: from esabb2.muc ([160.50.100.34])  by esagw2.muc with ESMTP/TLS;
 25 Apr 2025 12:18:27 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb2.muc with ESMTP/TLS; 25 Apr 2025 12:18:27 +0200
Received: from localhost.localdomain (10.30.85.206) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 12:18:27 +0200
X-CSE-ConnectionGUID: P9uGBygAQbOO3MCBdSRF7Q==
X-CSE-MsgGUID: YxkPXyDVQ06yVGR0nAEotw==
X-CSE-ConnectionGUID: 7mYuVwxMSZeAlG5z5xlx8Q==
X-CSE-MsgGUID: ELY+JNiyRj2A65ZHsf/G4g==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v2 2/8] tests/fetch: Move commonly used imports to top
Date: Fri, 25 Apr 2025 12:11:49 +0200
Message-ID: <20250425101155.2905972-3-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425101155.2905972-1-philip.lorenz@bmw.de>
References: <20250425101155.2905972-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCMP09F.europe.bmw.corp (2a03:1e80:a15:58f::1:2d) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 10:18:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17557

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

