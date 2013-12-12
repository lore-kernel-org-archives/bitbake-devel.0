Return-Path: <olof.johansson@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by mail.openembedded.org (Postfix) with ESMTP id 8D8D76E376
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 16:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 6C78713BE4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RA7eLnqeTpGV for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id 438E713D22
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 34570BEA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 28AEE937
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 25AC23E070
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Thu, 12 Dec 2013
	17:48:59 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 0995B9C075; 
	Thu, 12 Dec 2013 17:48:58 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 Dec 2013 17:48:57 +0100
Message-ID: <1386866938-5932-5-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
References: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [RFC 4/5] bb.fetch2.git: support resolving both tags and branches
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
X-List-Received-Date: Thu, 12 Dec 2013 16:49:01 -0000
Content-Type: text/plain

Before this change, the resolution of a git reference to a commit sha1,
was done in a way that was prone to bogus matches. Looking for a tag
R1.2.3 would potentially get the SHA1 of a branch ending in R1.2.3, like
refs/heads/foo/bar/R1.2.3, instead of refs/tags/R1.2.3.

But since tags and branches are used somewhat ambiguously, we will fall
back to resolve it as a branch with that exact name, if no tag with the
exact name was found.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/git.py      | 47 ++++++++++++++++++++---
 lib/bb/tests/fetch_git.py | 97 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 137 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 81bf282..c01c82b 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -321,23 +321,58 @@ class Git(FetchMethod):
         """
         return "git:" + ud.host + ud.path.replace('/', '.') + ud.unresolvedrev[name]
 
-    def _latest_revision(self, ud, d, name):
+    def _gen_git_url(self, ud, d):
         """
-        Compute the HEAD revision for the url
+        Based on the FetchData object, return a valid remote url that
+        you can pass to git.
         """
         if ud.user:
             username = ud.user + '@'
         else:
             username = ""
 
-        cmd = "%s ls-remote %s://%s%s%s %s" % \
-              (ud.basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name])
+        return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
+
+    def _resolve_ref(self, ud, d, ref):
+        """
+        Try to resolve a reference using git ls-remote. We assume the
+        reference is fully qualified, or otherwise can be uniquely
+        resolved. Will return the commit sha1 of the reference.
+
+        If more than one line of output is returned, we'll raise an
+        FetchError exception. Same if no output is returned.
+        """
+        url = self._gen_git_url(ud, d)
+        cmd = "%s ls-remote %s %s" % (ud.basecmd, url, ref)
+
         if ud.proto.lower() != 'file':
             bb.fetch2.check_network_access(d, cmd)
+
         output = runfetchcmd(cmd, d, True)
         if not output:
-            raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, ud.url)
-        return output.split()[0]
+            raise bb.fetch2.FetchError(
+                "The command %s gave empty output unexpectedly" % cmd, ud.url)
+
+        output = output.split()
+        if len(output) > 2:
+            raise bb.fetch2.FetchError(
+                "The command %s gave more than one result" % cmd, ud.url)
+
+        return output[0]
+
+    def _latest_revision(self, ud, d, name):
+        """
+        Compute the HEAD revision for the url. The reference is first
+        tried as refs/tags/<ref>^{}, which should return a sha1 of the
+        commit object pointed to by the tag. If nothing is found, we'll
+        try to resolve it as refs/heads/<tag> instead.
+        """
+        ref = ud.unresolvedrev[name]
+
+        try:
+            return self._resolve_ref(ud, d, "refs/tags/%s^{}" % ref)
+        except:
+            return self._resolve_ref(ud, d, "refs/heads/%s" % ref)
 
     def _build_revision(self, ud, d, name):
         return ud.revisions[name]
diff --git a/lib/bb/tests/fetch_git.py b/lib/bb/tests/fetch_git.py
index 89af515..b11c335 100644
--- a/lib/bb/tests/fetch_git.py
+++ b/lib/bb/tests/fetch_git.py
@@ -3,7 +3,7 @@
 #
 # BitBake Tests for the git fetcher (fetch2/git.py)
 #
-# Copyright (C) 2013 Olof Johansson
+# Copyright (C) 2013 Olof Johansson <olof.johansson@axis.com>
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
@@ -30,6 +30,7 @@ def mock_ud(url):
     ud = Mock()
     (ud.type, ud.host, ud.path,
      ud.user, ud.pswd, ud.parm) = bb.fetch2.decodeurl(url)
+    ud.basecmd = 'git'
     return ud
 
 
@@ -156,6 +157,100 @@ class GitFetcherTest(unittest.TestCase):
                 d, quiet=True)
 
 
+    def test_gen_git_url(self):
+        ud = mock_ud("git://example.com/repo.git")
+        ud.proto = 'git'
+        self.assertEqual(
+            self.fetcher._gen_git_url(ud, Mock()),
+            'git://example.com/repo.git')
+
+        ud = mock_ud("git://example.com/repo.git;param=value")
+        ud.proto = 'git'
+        self.assertEqual(
+            self.fetcher._gen_git_url(ud, Mock()),
+            'git://example.com/repo.git')
+
+        ud = mock_ud("git://example.com/repo.git;protocol=ssh")
+        ud.proto = 'ssh'
+        self.assertEqual(
+            self.fetcher._gen_git_url(ud, Mock()),
+            'ssh://example.com/repo.git')
+
+        ud = mock_ud("git://example.com/repo.git?query=param")
+        ud.proto = 'git'
+        self.assertEqual(
+            self.fetcher._gen_git_url(ud, Mock()),
+            'git://example.com/repo.git?query=param')
+
+        ud = mock_ud("git://user@example.com/repo.git")
+        ud.proto = 'git'
+        self.assertEqual(
+            self.fetcher._gen_git_url(ud, Mock()),
+            'git://user@example.com/repo.git')
+
+
+    @patch('bb.fetch2.check_network_access')
+    @patch('bb.fetch2.git.runfetchcmd')
+    def test_resolve_ref(self, mock_runcmd, mock_check_net):
+        ud = mock_ud("git:///repo.git")
+        ud.proto = 'file'
+        d = Mock()
+
+        self.fetcher._resolve_ref(ud, d, "v1.2.3")
+        self.assertFalse(mock_check_net.called)
+        mock_runcmd.assert_called_once_with(
+            "git ls-remote file:///repo.git v1.2.3",
+            d, True)
+        mock_runcmd.reset_mock()
+
+        ud = mock_ud("git://example.com/repo.git")
+        ud.proto = 'git'
+        mock_runcmd.return_value = "%s %s" % ('a'*40, "R1.2.3^{}")
+        self.fetcher._resolve_ref(ud, d, "refs/tags/R1.2.3^{}")
+        self.assertTrue(mock_check_net.called)
+        mock_runcmd.assert_called_once_with(
+            "git ls-remote git://example.com/repo.git refs/tags/R1.2.3^{}",
+            d, True)
+
+        # Two matches; two output lines. Should raise exception
+        with self.assertRaises(bb.fetch2.FetchError):
+            mock_runcmd.return_value = '\n'.join(
+                ["%s %s" % ('a'*40, "R1.2.3^{}")*2])
+            self.fetcher._resolve_ref(ud, d, "refs/tags/R1.2.3^{}")
+
+        # No match; no output. Should raise exception
+        with self.assertRaises(bb.fetch2.FetchError):
+            mock_runcmd.return_value = ''
+            self.fetcher._resolve_ref(ud, d, "refs/tags/R1.2.3^{}")
+
+
+    @patch('bb.fetch2.git.Git._resolve_ref')
+    def test_latest_revision(self, mock_resolve):
+        ud = mock_ud('git://example.com/repo.git')
+        d = Mock()
+        ud.revisions = {'default': 'ref'}
+
+        # Find match for refs/tags/ref^{}.
+        mock_resolve.return_value = 'a'*40
+        sha1 = self.fetcher._latest_revision(ud, d, 'default')
+        self.assertEqual(sha1, 'a'*40)
+        mock_resolve.assert_called_once_with(ud, d, 'refs/tags/ref^{}')
+
+        # Doesn't find match for refs/tags/ref^{}. Moves on to refs/heads/ref.
+        mock_resolve.side_effect = [
+            bb.fetch2.FetchError('fail'), 'b'*40
+        ]
+        sha1 = self.fetcher._latest_revision(ud, d, 'default')
+        self.assertEqual(sha1, 'b'*40)
+        mock_resolve.assert_called_with(ud, d, 'refs/heads/ref')
+
+        # Doesn't find match for anything.
+        with self.assertRaises(bb.fetch2.FetchError):
+            mock_resolve.reset_mock()
+            mock_resolve.side_effect = bb.fetch2.FetchError("fail")
+            self.fetcher._latest_revision(ud, d, 'default')
+
+
     def test_supports_checksum(self):
         self.assertFalse(self.fetcher.supports_checksum(None))
 
-- 
1.8.4.rc3


