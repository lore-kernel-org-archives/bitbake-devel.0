Return-Path: <setairidis@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CD7C98304
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 19:45:04 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3878.1790192697221179128
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2026 12:44:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=i1Rtn+eT;
 spf=pass (domain: gmail.com, ip: 74.125.225.141, mailfrom: setairidis@gmail.com)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b965f447cso10218325e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790192695; x=1790797495; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pmo3QZLpbC/TSAVFWx254rXvWu38NoCqPnVFqcSp7J0=;
        b=i1Rtn+eTQACfA+kNOUYxnZ+aH1q5OWGPuGKp/Ipmu7Tq/W1QvkatZVFX9UzLwWKGdr
         jRRG1Zh2SAe5UQjKh+Jn6MMPXlgLGT8F4E6Z9A1RQwTPZxnXpm19iccheaJ9+no6YanM
         FY5qc3PBvd2z8Eyh9is0W/QWQesX8K/5QsVAzFgd5XhBfCpt6gBv86Kne+45odzajRor
         DVZ5jybb7kT+2MKpH+DaVLX3RNhLyeuwSx7cmqac1atU8gJ9Zgh9kjre1VLpRzQ41lNE
         Go35/UDmkizGCk819LPTxwf0Hw2rFJI9jseDKSpXECVIAuw74F8weOna7u+FaCboknjR
         ZUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790192695; x=1790797495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pmo3QZLpbC/TSAVFWx254rXvWu38NoCqPnVFqcSp7J0=;
        b=bmaS8opVp2EHjn+vh8rjDwuRITikPFbPdb3g6oj3BZNLASu14cb4Pdo0nFLe2qzodA
         T6EzwcnRRL8plJDTXjguvGEr4LQBB8NFQthKLWxfKOuWyoys2RTgBGjrh4l4xk3k7CTi
         JjmVpZTLRwkCorJ246jXvJbA52eW76BTnrGaAThSVozxylvjkBgLmUQR0C9/Olqa9avZ
         NF7YQE9t3AWPngc9dxh/kjTGx60Hc6Mgsef3ULUHYqwjXGnAlvPFokva7op/0QlxW2mL
         Pba+5aARdj3DUl95devYPmsgchyPp9cyKcnU7S108fVMNhBuB0/Yf7rLJx6FFm+A6EXW
         9Grw==
X-Gm-Message-State: AFuF++nxudlPlDaYswT58F1gD/Q40emae1d7xmb+uGEtPc6e7onf/3u9
	vA6Iv+lv4MCvJl/MhqmMPbgdqIAcSi8ujz9T4W8MJhgMZvdtpLE9+xzu1nPmhj4IClE=
X-Gm-Gg: AYBFou1S+Wg3mDh3dG37Iz0xvZhWueKJoBKAY1HT3ma950yZ7sTOfCiNtkkJ9QJyu+H
	NYEHHzjV3jvHwIGxxEbSGDXCjY8mbk6RMZ8NjZVmvqIK3FGqtBdpzTLCUtUTL6Ym8d6/T+vNpjE
	xpZcgj5WrGONue5Uj7OYd6UgJuystKKBIlV6DLydt2zg7n0x7O5ZAnPZABNa7sM/yIbxP+OPKQi
	oFrxbGAZzEPvPzEJ2f93qkc6N/0KKaiQ8wpdWJJaRvx4mlSmbgu6KXKb1jrsOsZUOtSOUj0V4JV
	8clPfbpx5Z0tXQ41bu4Mdh7n0hzERCpsnEyTqqBZDidXtc3Jq+NjP9qIoJOVUDYK2DqMp5SXTDS
	PyYCro+ATliSxDrG96eFeV6QKbnBdzIu9JwK2q07KHOF+6d3aTD1a8oM0zJ1dPIcdDzq0uctWew
	Pw345r481TGVmluFbRfYYiMEkLkPeRnnPLRNk/xFJ/yCosPb34yUn1ndrCCb48aQ5xUdFeWa3hB
	URDxHcFH13H9zQYfYW8l422IAUFU/M7xdqxEH5HTI/WQ+TGvl/mlL3NMXH4J+xkmZOypvUI6PuP
	YluvBA8P
X-Received: by 2002:a05:600c:468f:b0:49c:fa20:cc02 with SMTP id 5b1f17b1804b1-49fe66f4fc6mr3527145e9.25.1790192694966;
        Wed, 23 Sep 2026 12:44:54 -0700 (PDT)
Received: from DESKTOP-LR19VKC.localdomain (ipservice-092-209-186-138.092.209.pools.vodafone-ip.de. [92.209.186.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5ce4941sm8691185e9.6.2026.09.23.12.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:44:54 -0700 (PDT)
From: Savvas Etairidis <setairidis@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: jhonata.poma@gmail.com,
	paul@pbarker.dev,
	Savvas Etairidis <setairidis@gmail.com>
Subject: [PATCH v3] fetch2/local: verify checksums for file:// urls
Date: Wed, 23 Sep 2026 21:44:35 +0200
Message-Id: <20260923194435.58965-1-setairidis@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511-b4-yocto-9993-v2-1-9d5a1c1451ba@gmail.com>
References: <20260511-b4-yocto-9993-v2-1-9d5a1c1451ba@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 19:45:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20248

Local.urldata_init unconditionally cleared ud.needdonestamp, which
skipped the donestamp + verify_checksum cycle for every file:// url.
A checksum supplied via a url parameter, such as UNINATIVE_CHECKSUM
expanded into the uninative tarball's file:// url, was therefore
never compared against the file's actual contents.

Keep needdonestamp at its default when the url carries a checksum
parameter, and move rename_bad_checksum onto FetchMethod so Local can
override it as a no-op, avoiding a rename of the user's source file
on mismatch.

Based on a patch by Jhonata Poma-Hansen, adapted to this tree's
Local.urldata_init(), which now uses ud.decodedurl in place of the
ud.path referenced by the original patch.

[YOCTO #9993]

Signed-off-by: Savvas Etairidis <setairidis@gmail.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 36 +++++++++++++++----------------
 bitbake/lib/bb/fetch2/local.py    | 18 ++++++++++++++--
 bitbake/lib/bb/tests/fetch.py     | 30 ++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 8f0ed2b9e2..da96a4c399 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -701,7 +701,7 @@ def verify_donestamp(ud, d, origud=None):
         logger.warning("Checksum mismatch for local file %s\n"
                        "Cleaning and trying again." % ud.localpath)
         if os.path.exists(ud.localpath):
-            rename_bad_checksum(ud, e.checksum)
+            ud.method.rename_bad_checksum(ud, e.checksum)
         bb.utils.remove(ud.donestamp)
     return False
 
@@ -734,7 +734,7 @@ def update_stamp(ud, d):
             logger.warning("Checksum mismatch for local file %s\n"
                            "Cleaning and trying again." % ud.localpath)
             if os.path.exists(ud.localpath):
-                rename_bad_checksum(ud, e.checksum)
+                ud.method.rename_bad_checksum(ud, e.checksum)
             bb.utils.remove(ud.donestamp)
             raise
 
@@ -1029,20 +1029,6 @@ def build_mirroruris(origud, mirrors, ld):
 
     return uris, uds
 
-def rename_bad_checksum(ud, suffix):
-    """
-    Renames files to have suffix from parameter
-    """
-
-    if ud.localpath is None:
-        return
-
-    new_localpath = "%s_bad-checksum_%s" % (ud.localpath, suffix)
-    bb.warn("Renaming %s to %s" % (ud.localpath, new_localpath))
-    if not bb.utils.movefile(ud.localpath, new_localpath):
-        bb.warn("Renaming %s to %s failed, grep movefile in log.do_fetch to see why" % (ud.localpath, new_localpath))
-
-
 def try_mirror_url(fetch, origud, ud, ld, check = False):
     # Return of None or a value means we're finished
     # False means try another url
@@ -1111,7 +1097,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
             logger.warning("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (ud.url, origud.url))
             logger.warning(str(e))
             if os.path.exists(ud.localpath):
-                rename_bad_checksum(ud, e.checksum)
+                ud.method.rename_bad_checksum(ud, e.checksum)
         elif isinstance(e, NoChecksumError):
             raise
         else:
@@ -1450,6 +1436,20 @@ class FetchMethod(object):
         """
         return True
 
+    def rename_bad_checksum(self, ud, suffix):
+        """
+        Rename ud.localpath with the given suffix on checksum mismatch.
+        Local overrides this to a no-op since its localpath points at the
+        user's source tree.
+        """
+        if ud.localpath is None:
+            return
+
+        new_localpath = "%s_bad-checksum_%s" % (ud.localpath, suffix)
+        bb.warn("Renaming %s to %s" % (ud.localpath, new_localpath))
+        if not bb.utils.movefile(ud.localpath, new_localpath):
+            bb.warn("Renaming %s to %s failed, grep movefile in log.do_fetch to see why" % (ud.localpath, new_localpath))
+
     def verify_donestamp(self, ud, d):
         """
         Verify the donestamp file
@@ -1887,7 +1887,7 @@ class Fetch(object):
                             logger.warning("Checksum failure encountered with download of %s - will attempt other sources if available" % u)
                             logger.debug(str(e))
                             if os.path.exists(ud.localpath):
-                                rename_bad_checksum(ud, e.checksum)
+                                ud.method.rename_bad_checksum(ud, e.checksum)
                         elif isinstance(e, NoChecksumError):
                             raise
                         else:
diff --git a/bitbake/lib/bb/fetch2/local.py b/bitbake/lib/bb/fetch2/local.py
index 7d7668110e..43b8dd25ab 100644
--- a/bitbake/lib/bb/fetch2/local.py
+++ b/bitbake/lib/bb/fetch2/local.py
@@ -17,7 +17,7 @@ import os
 import urllib.request, urllib.parse, urllib.error
 import bb
 import bb.utils
-from   bb.fetch2 import FetchMethod, FetchError, ParameterError
+from   bb.fetch2 import CHECKSUM_LIST, FetchMethod, FetchError, ParameterError
 from   bb.fetch2 import logger
 
 class Local(FetchMethod):
@@ -32,11 +32,25 @@ class Local(FetchMethod):
         ud.decodedurl = urllib.parse.unquote(ud.url.split("://")[1].split(";")[0])
         ud.basename = os.path.basename(ud.decodedurl)
         ud.basepath = ud.decodedurl
-        ud.needdonestamp = False
+        # Honor explicit checksum params (UNINATIVE_CHECKSUM, recipe
+        # ;sha256sum=) by leaving needdonestamp at FetchData's default so
+        # verify_checksum runs.
+        name = ud.parm.get("name")
+        ud.needdonestamp = any(
+            (name and "%s.%ssum" % (name, a) in ud.parm)
+            or "%ssum" % a in ud.parm
+            for a in CHECKSUM_LIST
+        )
         if "*" in ud.decodedurl:
             raise bb.fetch2.ParameterError("file:// urls using globbing are no longer supported. Please place the files in a directory and reference that instead.", ud.url)
         return
 
+    def rename_bad_checksum(self, ud, suffix):
+        # file:// urls point at the user's source tree (recipe-shipped files
+        # under FILESPATH or an absolute path the user passed in); skip the
+        # rename so a ChecksumError surfaces without mutating their files.
+        return
+
     def localpath(self, urldata, d):
         """
         Return the local filename of a given url assuming a successful fetch.
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 68b2dbba96..4bc82af422 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -808,6 +808,36 @@ class FetcherLocalTest(FetcherTest):
         tree = self.fetchUnpack(['file://archive.tar.bz2;subdir=bar;striplevel=1'])
         self.assertEqual(tree, ['bar/c', 'bar/d', 'bar/subdir/e'])
 
+    def test_local_checksum_match(self):
+        # Correct sha256 must run verify_checksum to completion; donestamp
+        # lands in DL_DIR.
+        import hashlib
+        content = b"file:// checksum match test\n"
+        with open(os.path.join(self.localsrcdir, 'sumfile'), 'wb') as f:
+            f.write(content)
+        good = hashlib.sha256(content).hexdigest()
+        fetcher = bb.fetch.Fetch(['file://sumfile;sha256sum=' + good], self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
+        self.assertTrue(ud.needdonestamp)
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.donestamp))
+
+    def test_local_checksum_mismatch(self):
+        # Bad sha256 raises ChecksumError without renaming the user's
+        # source file to the <localpath>_bad-checksum_<sha> sibling.
+        content = b"file:// checksum mismatch test\n"
+        srcpath = os.path.join(self.localsrcdir, 'sumfile')
+        with open(srcpath, 'wb') as f:
+            f.write(content)
+        bad = "0" * 64
+        fetcher = bb.fetch.Fetch(['file://sumfile;sha256sum=' + bad], self.d)
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
+        self.assertTrue(os.path.exists(srcpath))
+        with open(srcpath, 'rb') as f:
+            self.assertEqual(f.read(), content)
+        self.assertFalse(os.path.exists(srcpath + '_bad-checksum_' + bad))
+
     def dummyGitTest(self, suffix):
         # Create dummy local Git repo
         src_dir = tempfile.mkdtemp(dir=self.tempdir,
-- 
2.34.1


