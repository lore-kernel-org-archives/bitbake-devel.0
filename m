Return-Path: <sh0127.shin@lge.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF2BC5DF8C
	for <webhook@archiver.kernel.org>; Sat, 22 Aug 2026 02:28:32 +0000 (UTC)
Received: from lgeamrelo13.lge.com (lgeamrelo13.lge.com [156.147.23.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16.1787365705035491483
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2026 19:28:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: lge.com, ip: 156.147.23.53, mailfrom: sh0127.shin@lge.com)
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
	by 156.147.23.53 with ESMTP; 22 Aug 2026 11:28:22 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: sh0127.shin@lge.com
Received: from unknown (HELO swfarm-oeci-r122-2204..) (156.147.61.178)
	by 156.147.1.127 with ESMTP; 22 Aug 2026 11:28:22 +0900
X-Original-SENDERIP: 156.147.61.178
X-Original-MAILFROM: sh0127.shin@lge.com
From: sh0127.shin@lge.com
To: bitbake-devel@lists.openembedded.org
Cc: sh0127.shin@lge.com
Subject: [PATCH 2/2] fetch2/tests: add test for fixperms option
Date: Sat, 22 Aug 2026 02:28:19 +0000
Message-Id: <20260822022819.194891-1-sh0127.shin@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260822012007.189830-1-sh0127.shin@lge.com>
References: <20260822012007.189830-1-sh0127.shin@lge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 22 Aug 2026 02:28:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20018

From: "sh0127.shin" <sh0127.shin@lge.com>

Add a unit test for the 'fixperms' SRC_URI parameter introduced
in FetchMethod.unpack().

The test creates a tar.gz archive containing a directory with
restrictive permissions (0o644, no execute bit), then verifies
that unpacking with fixperms=1:

  1. Successfully extracts files inside the restrictive directory.
  2. Restores the execute bit on the directory via chmod -R +X.

Signed-off-by: sh0127.shin <sh0127.shin@lge.com>
---
 lib/bb/tests/fetch.py | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a1e4b45f8..0bf6e6983 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -876,6 +876,37 @@ class FetcherLocalTest(FetcherTest):
             with self.subTest(striplevel=repr(value)):
                 self.assertInvalidStriplevel(value)
 
+    def test_local_fixperms(self):
+        """Test that fixperms=1 allows extraction of archives with restrictive directory permissions"""
+        import tarfile
+        import stat
+
+        # Create a tar archive with a directory having restrictive permissions (drw-r--r--)
+        archive_path = os.path.join(self.localsrcdir, 'archive_fixperms.tar.gz')
+        with tarfile.open(archive_path, 'w:gz') as tar:
+            # Add a directory with no execute bit (0o644)
+            dirinfo = tarfile.TarInfo(name='restrictive_dir')
+            dirinfo.type = tarfile.DIRTYPE
+            dirinfo.mode = 0o644
+            tar.addfile(dirinfo)
+            # Add a file inside the restrictive directory
+            import io
+            content = b'test content'
+            fileinfo = tarfile.TarInfo(name='restrictive_dir/testfile.txt')
+            fileinfo.size = len(content)
+            fileinfo.mode = 0o644
+            tar.addfile(fileinfo, io.BytesIO(content))
+
+        # Without fixperms, extraction may fail or leave inaccessible dirs
+        # With fixperms=1, chmod -R +X is applied after extraction
+        tree = self.fetchUnpack(['file://archive_fixperms.tar.gz;fixperms=1'])
+        self.assertIn('restrictive_dir/testfile.txt', tree)
+
+        # Verify directory is traversable after fixperms
+        dirpath = os.path.join(self.unpackdir, 'restrictive_dir')
+        dirstat = os.stat(dirpath)
+        self.assertTrue(dirstat.st_mode & stat.S_IXUSR, "Directory should have execute bit after fixperms")
+
     def dummyGitTest(self, suffix):
         # Create dummy local Git repo
         src_dir = tempfile.mkdtemp(dir=self.tempdir,
-- 
2.34.1


