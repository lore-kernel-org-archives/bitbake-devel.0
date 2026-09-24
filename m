Return-Path: <setairidis@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E039AC9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 20:45:54 +0000 (UTC)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8235.1790282747795828828
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Sep 2026 13:45:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FZjYgw46;
 spf=pass (domain: gmail.com, ip: 74.125.225.76, mailfrom: setairidis@gmail.com)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so172469f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Sep 2026 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790282746; x=1790887546; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ht7u8u3o/KQUGR4EyumjRYjGtIKkgMHrAdfV936Gp6g=;
        b=FZjYgw46tgJWRcQsItyXDM7a4EQmZm9/a0DrbPIbNxBfZWta8lKFGCa78obQ7gqNZm
         Y2JBywZywtPp/VuW/OCyc4ZkDNz+YBRQiH2sAzXHOYfC2JFKSrrehyh2CA7AjF9LeH8h
         5jGgkeaNDNfpA+Fmx/6hZ+VOxYxUe1bAKGDosiFkLI4SklV+dRbZ1fhDvz0aWDW4g3PZ
         f4+lOw+un7Q3umy4Mcj0dOQokLuacUeupJYecKpMrndT1nbpT6Lj0r/aR1w4eRtL1rNi
         OsKRvy77gbvZO1qaQYyeqCv4uqi+5oNivs3G+xFzWg2SmSz0pvsDWvLPadTRBK1J/EbD
         /QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790282746; x=1790887546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ht7u8u3o/KQUGR4EyumjRYjGtIKkgMHrAdfV936Gp6g=;
        b=EfnLndw+WQMIV41hLakg+eyaQqXUQ9Mmf++M041ryv6vsl0kXPphRnxjazk88HvYv7
         t5SrS2FOQCCgKFaKgJVdgeTpgctMLZNNFx3W1BGPF3Id3jaNBgAYCy2xsgcmzB3tckB4
         pXs6gnprz6K7Klk/QiaDBsUtTYtOjRt78i3895tYj7TjvDTPyyQPFfrgRshT6pJH8vkq
         9+KU3y7xHd8RMEQ+NbMlc1DDBmUj3Hl+UD22K9D1R7FhbPWghQJsq/yGRZwaufBx5bJe
         I795xdMhJ9CYuvIDt2Oh0l6mGDD/xcZZ3aDl/JZ19/K6tcb8VasGykqYSs61fFZ3gbHu
         IJVg==
X-Gm-Message-State: AFuF++lSo3AhB7sCqpOuXHsCU2eGFO2K4FPV5UV3wihSIFUHeoHcQ+7X
	ubCeWrxP3rtUON4BMPpcZaLOYbPnZVfpkhkJaXUAXocPFGB/r0rofGUP24pvKyEy
X-Gm-Gg: AYBFou1WieLA/+EKRDaIKj+EWRhzTrbhvrX9xt4bis/3OBlhvu1ZfSTyj9dUtdg6Smi
	hOwtelpVN5Xc+rRAoBJ5CiYsatwDpzVbynkXL6qass1AwbrAxecZtQh6qH2cclynhFjtxQw25lD
	G6u5E+QNNolH99sT4+4S2fJp5Mo5U8CFJSHUFH05ZWPuSB5V/cyiKM0eeKUFSCzeT+uHZhJKmvZ
	hikE4OdwKWH2O8KdwfIX7nciZSR683g2wo93Ytfghz9wN0eRXzHMmgyDJyRZZ42guhV3beDx8pp
	eRPFws31awhnlP5ywm2w18r49kJ69LvGR2Vb3BZ0jC49kt/N/MWEl4agV84EOSDYuMaYNllPL6X
	FQ+j9Hb8NLLWvLy1sEg8GHmhU1uNMWaNkTobtOhVsz3gRzt8ZEyAoWxAT52dC6BIx5GV1maiz8B
	zltiTCh7Qdu79yZGDfVg6a2RZF1UaK/m2A6xVSgNzqP9N9FsJKm6x442i1GPK0B7+6RgBha0bxN
	K+e87V8fIcvOXFyAXEAJ05iVFOzGeER8yC3tf18S+wUud1xgVuyqONCTLygREDU2mQWL1/U6ue4
	96SvreO4DzzYgVtswQ==
X-Received: by 2002:a05:6000:1887:b0:487:b00:3853 with SMTP id ffacd0b85a97d-4887175fc07mr6492753f8f.27.1790282745739;
        Thu, 24 Sep 2026 13:45:45 -0700 (PDT)
Received: from DESKTOP-LR19VKC.localdomain (ipservice-092-209-186-036.092.209.pools.vodafone-ip.de. [92.209.186.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a6470b7sm1484859f8f.27.2026.09.24.13.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:45:45 -0700 (PDT)
From: Savvas Etairidis <setairidis@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: jhonata.poma@gmail.com,
	paul@pbarker.dev,
	Savvas Etairidis <setairidis@gmail.com>
Subject: [PATCH v4] fetch/local: verify checksums for file:// urls
Date: Thu, 24 Sep 2026 22:45:19 +0200
Message-Id: <20260924204518.19931-1-setairidis@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DLNC7K9T9IRB.3TSABE8ZFLIZF@bootlin.com>
References: <DLNC7K9T9IRB.3TSABE8ZFLIZF@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Sep 2026 20:45:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20253

[YOCTO #9993]

Local.urldata_init() always cleared needdonestamp, so a checksum given
in a file:// url (e.g. UNINATIVE_CHECKSUM when UNINATIVE_URL points at
a local file://) was never verified. Keep the donestamp when the url
carries a checksum so verify_checksum runs, and make
rename_bad_checksum() a FetchMethod method that Local overrides as a
no-op, so a mismatch doesn't rename the user's source file.

Based on a patch by Jhonata Poma-Hansen.

Signed-off-by: Savvas Etairidis <setairidis@gmail.com>
---
 lib/bb/fetch/__init__.py | 36 ++++++++++++++++++------------------
 lib/bb/fetch/local.py    | 18 ++++++++++++++++--
 lib/bb/tests/fetch.py    | 30 ++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index 55ab710f3..a9f0add78 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -742,7 +742,7 @@ def verify_donestamp(ud, d, origud=None):
         logger.warning("Checksum mismatch for local file %s\n"
                        "Cleaning and trying again." % ud.localpath)
         if os.path.exists(ud.localpath):
-            rename_bad_checksum(ud, e.checksum)
+            ud.method.rename_bad_checksum(ud, e.checksum)
         bb.utils.remove(ud.donestamp)
     return False
 
@@ -775,7 +775,7 @@ def update_stamp(ud, d):
             logger.warning("Checksum mismatch for local file %s\n"
                            "Cleaning and trying again." % ud.localpath)
             if os.path.exists(ud.localpath):
-                rename_bad_checksum(ud, e.checksum)
+                ud.method.rename_bad_checksum(ud, e.checksum)
             bb.utils.remove(ud.donestamp)
             raise
 
@@ -1079,20 +1079,6 @@ def build_mirroruris(origud, mirrors, ld):
 
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
@@ -1163,7 +1149,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
             logger.warning("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (ud.url, origud.url))
             logger.warning(str(e))
             if os.path.exists(ud.localpath):
-                rename_bad_checksum(ud, e.checksum)
+                ud.method.rename_bad_checksum(ud, e.checksum)
         elif isinstance(e, NoChecksumError):
             raise
         else:
@@ -1479,6 +1465,20 @@ class FetchMethod(object):
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
@@ -1943,7 +1943,7 @@ class Fetch(object):
                             logger.warning("Checksum failure encountered with download of %s - will attempt other sources if available" % u)
                             logger.debug(str(e))
                             if os.path.exists(ud.localpath):
-                                rename_bad_checksum(ud, e.checksum)
+                                ud.method.rename_bad_checksum(ud, e.checksum)
                         elif isinstance(e, NoChecksumError):
                             raise
                         else:
diff --git a/lib/bb/fetch/local.py b/lib/bb/fetch/local.py
index dfc5b564c..a92c0d267 100644
--- a/lib/bb/fetch/local.py
+++ b/lib/bb/fetch/local.py
@@ -17,7 +17,7 @@ import os
 import urllib.request, urllib.parse, urllib.error
 import bb
 import bb.utils
-from   bb.fetch import FetchMethod, FetchError, ParameterError
+from   bb.fetch import CHECKSUM_LIST, FetchMethod, FetchError, ParameterError
 from   bb.fetch import logger
 
 class Local(FetchMethod):
@@ -31,11 +31,25 @@ class Local(FetchMethod):
         # We don't set localfile as for this fetcher the file is already local!
         ud.basename = os.path.basename(ud.path)
         ud.basepath = ud.path
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
         if "*" in ud.path:
             raise bb.fetch.ParameterError("file:// urls using globbing are no longer supported. Please place the files in a directory and reference that instead.", ud.url)
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
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 71b0a63fe..60d356fc6 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -876,6 +876,36 @@ class FetcherLocalTest(FetcherTest):
             with self.subTest(striplevel=repr(value)):
                 self.assertInvalidStriplevel(value)
 
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
+        with self.assertRaises(bb.fetch.FetchError):
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


