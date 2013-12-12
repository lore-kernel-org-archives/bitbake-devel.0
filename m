Return-Path: <olof.johansson@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by mail.openembedded.org (Postfix) with ESMTP id 80E786E376
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 16:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 949313F215B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2C+eEJ1Gwo4t for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id 723293F215E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 6528DBE8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 583E5BE7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 56A8B3E070
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Thu, 12 Dec 2013
	17:48:59 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 1DB699C083; 
	Thu, 12 Dec 2013 17:48:58 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 Dec 2013 17:48:56 +0100
Message-ID: <1386866938-5932-4-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
References: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [RFC 3/5] bb.tests.fetch_git: initial set of tests for git fetcher
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
X-List-Received-Date: Thu, 12 Dec 2013 16:49:02 -0000
Content-Type: text/plain

This commit introduces a set of whitebox unit tests for the git
fetcher, including some minor refactoring of the fetcher itself
to increase testability.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 bin/bitbake-selftest      |   3 +-
 lib/bb/fetch2/git.py      |  31 +++++++--
 lib/bb/tests/fetch_git.py | 164 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 8 deletions(-)
 create mode 100644 lib/bb/tests/fetch_git.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 48a58fe..7f02fbf 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -25,10 +25,11 @@ try:
 except RuntimeError as exc:
     sys.exit(str(exc))
 
-tests = ["bb.tests.codeparser", 
+tests = ["bb.tests.codeparser",
          "bb.tests.cow",
          "bb.tests.data",
          "bb.tests.fetch",
+         "bb.tests.fetch_git",
          "bb.tests.utils"]
 
 for t in tests:
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index bd107db..81bf282 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -87,14 +87,10 @@ class Git(FetchMethod):
         init git specific variable within url data
         so that the git method like latest_revision() can work
         """
-        if 'protocol' in ud.parm:
-            ud.proto = ud.parm['protocol']
-        elif not ud.host:
-            ud.proto = 'file'
-        else:
-            ud.proto = "git"
 
-        if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
+        ud.proto = self._fetch_url_proto(ud)
+
+        if not self._valid_protocol(ud.proto):
             raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
 
         ud.nocheckout = ud.parm.get("nocheckout","0") == "1"
@@ -287,6 +283,27 @@ class Git(FetchMethod):
     def supports_srcrev(self):
         return True
 
+    def _fetch_url_proto(self, ud):
+        """
+        Identify protocol for Git URL.
+
+        The scheme prefix is used to couple the URL to this particular fetcher,
+        but it's not necessarily the git protocol we will use. If a protocol
+        URL parameter is supplied we will use that, otherwise we will use
+        git:// if the URL contains a hostname or file:// if it does not.
+
+        """
+        if 'protocol' in ud.parm:
+            return ud.parm['protocol']
+
+        if not ud.host:
+            return 'file'
+
+        return "git"
+
+    def _valid_protocol(self, proto):
+        return proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync')
+
     def _contains_ref(self, ud, d, name):
         cmd =  "%s branch --contains %s --list %s 2> /dev/null | wc -l" % (
             ud.basecmd, ud.revisions[name], ud.branches[name])
diff --git a/lib/bb/tests/fetch_git.py b/lib/bb/tests/fetch_git.py
new file mode 100644
index 0000000..89af515
--- /dev/null
+++ b/lib/bb/tests/fetch_git.py
@@ -0,0 +1,164 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Tests for the git fetcher (fetch2/git.py)
+#
+# Copyright (C) 2013 Olof Johansson
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import unittest
+from mock import Mock, patch
+import bb.fetch2
+from bb.fetch2.git import Git
+
+def mock_ud(url):
+    """
+    Generate a FetchData like Mock object based on a URL.
+    """
+    ud = Mock()
+    (ud.type, ud.host, ud.path,
+     ud.user, ud.pswd, ud.parm) = bb.fetch2.decodeurl(url)
+    return ud
+
+
+class GitFetcherTest(unittest.TestCase):
+    def setUp(self):
+        bb.fetch2.FetchMethod = Mock()
+        self.fetcher = Git()
+
+
+    def tearDown(self):
+        pass
+
+
+    def test_supports(self):
+        ud = Mock()
+
+        ud.type = 'git'
+        self.assertTrue(self.fetcher.supports(ud, None))
+
+        ud.type = 'ssh'
+        self.assertFalse(self.fetcher.supports(ud, None))
+
+
+    @patch("bb.fetch2.git.Git.latest_revision")
+    def test_urldata_init(self, latest_rev):
+        class MockD(object):
+            """ Mock datasmart class.  """
+            def __init__(self, **kwargs):
+                self.known = kwargs
+
+            def getVar(self, var, expand=False):
+                if var in self.known:
+                    return self.known[var]
+
+
+        bb.fetch2.git.data.getVar = lambda var, d, expand: d.getVar(var, expand)
+
+        d = MockD(
+            DL_DIR='/tmp/dl_dir',
+        )
+
+        # Invalid protocol given as url parameter
+        with self.assertRaises(bb.fetch2.ParameterError):
+            ud = mock_ud("git://example.com/foo.git;protocol=gopher")
+            self.fetcher.urldata_init(ud, d)
+
+        # Unbalanced number of branch/name parameters
+        with self.assertRaises(bb.fetch2.ParameterError):
+            ud = mock_ud(
+                "git://example.com/foo.git;branch=master,foo;name=bar")
+            # The names are usually extracted in FetchMethod constructor
+            ud.names = ['bar']
+            self.fetcher.urldata_init(ud, d)
+
+        ud = mock_ud("git://example.com/foo.git;protocol=ssh")
+        ud.names = ['default']
+        ud.revisions = {'default': None}
+
+        latest_rev.return_value = 'asd'
+
+        self.fetcher.urldata_init(ud, d)
+
+        self.assertFalse(ud.nocheckout)
+        self.assertFalse(ud.rebaseable)
+        self.assertFalse(ud.bareclone)
+        self.assertEqual(ud.branches, {'default': 'master'})
+
+
+    def test_fetch_url_proto(self):
+        for url in [
+            ('git:///foo.git', 'file'),
+            ('git://example.com/foo.git', 'git'),
+            ('git://example.com/foo.git;protocol=ssh', 'ssh')
+        ]:
+            ud = mock_ud(url[0])
+            self.assertEqual(self.fetcher._fetch_url_proto(ud), url[1])
+
+
+    def test_valid_protocol(self):
+        for valid in ['git', 'file', 'ssh', 'http', 'https', 'rsync']:
+            self.assertTrue(self.fetcher._valid_protocol(valid))
+        for invalid in ['dns', '', None]:
+            self.assertFalse(self.fetcher._valid_protocol(invalid))
+
+
+    def test_contains_ref(self):
+        commit_sha1 = '8f453bb11d72afc90a986ac604b3477d97eaf9a8'
+
+        ud = Mock()
+        ud.basecmd = 'git'
+        ud.revisions = {'default': commit_sha1}
+        ud.branches = {'default': 'master'}
+
+        d = Mock()
+
+        bb.fetch2.git.runfetchcmd = Mock()
+
+        # Two output lines from git branch --contains; _contains_ref() == True
+        # Also, while we're at it, verify that ud.basecmd changes take effect.
+        ud.basecmd = 'sudo git'
+        bb.fetch2.git.runfetchcmd.return_value = '2'
+        self.assertTrue(self.fetcher._contains_ref(ud, d, 'default'))
+        bb.fetch2.git.runfetchcmd.assert_called_with(
+            "sudo git branch --contains %s --list %s 2> /dev/null | wc -l" % (
+                ud.revisions['default'], ud.branches['default']),
+            d, quiet=True)
+        ud.basecmd = 'git'
+
+        # No output from git branch --contains; _contains_ref() == False
+        bb.fetch2.git.runfetchcmd.return_value = '0'
+        self.assertFalse(self.fetcher._contains_ref(ud, d, 'default'))
+        bb.fetch2.git.runfetchcmd.assert_called_with(
+            "git branch --contains %s --list %s 2> /dev/null | wc -l" % (
+                ud.revisions['default'], ud.branches['default']),
+            d, quiet=True)
+
+        # Strange wc -l output should throw FetchError exception
+        with self.assertRaises(bb.fetch2.FetchError):
+            bb.fetch2.git.runfetchcmd.return_value = '0 1'
+            self.fetcher._contains_ref(ud, d, 'default')
+            bb.fetch2.git.runfetchcmd.assert_called_with(
+                "git branch --contains %s --list %s 2> /dev/null | wc -l" % (
+                    ud.revisions['default'], ud.branches['default']),
+                d, quiet=True)
+
+
+    def test_supports_checksum(self):
+        self.assertFalse(self.fetcher.supports_checksum(None))
+
+
+    def test_supports_srcrev(self):
+        self.assertTrue(self.fetcher.supports_srcrev())
-- 
1.8.4.rc3


