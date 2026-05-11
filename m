Return-Path: <Jhonata.poma@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2EDCD37BE
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 14:58:41 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52314.1778511512886789105
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 May 2026 07:58:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=UQURqMRG;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: jhonata.poma@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd2087858c4so40278066b.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 11 May 2026 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778511511; x=1779116311; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O1b8UEx/oFnNQBTqxm406CKxkC+mCbcryYA2SRZ2aU=;
        b=UQURqMRGD0oltcuVtzz+DloirEJpj9V5sXsnNEka8eQtY12bNzeGdvN3HSxcfKxe6I
         iWGol7QZ0FZQ0Fmj/+uQxGbKP+UQR5uhOX8+kxh4sc4aT/KRy+lpLuBzG3w6chuxSWOa
         0dnxJc/aUqunZgTWHLkQkbNYH2urlRJ9934bU9SR1+0E2m2Cx4LOP2j2z2shQiQKofq+
         HJ7I0DiFYkm3xqlP57m3BBKsGjJuymzz+neAbzdHsE8EBrRgQhpdHUrw393ywpmSKVEJ
         foxs0zoHOBKG+a5m16v48LZI+REBMm8Q4OcHkq2P2HIrfWZpPdiZwrHHxwSXZ+tRFdGc
         fr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511511; x=1779116311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/O1b8UEx/oFnNQBTqxm406CKxkC+mCbcryYA2SRZ2aU=;
        b=BA+nBF5TCqDOdrYq6Hg0V79QWF/iYHowNPzD9ohXPrDHge8OP/ZHgceUbIRVHj1A67
         MESJ+naDRv5gdfA8pCOMoGVJG1IeZAfaigVieVlFjF95IwHsSjGiu97bLMD2eqqB1HkJ
         Dt4fpw4wcpj8vjc52dskMXpQTCMJwJbDBfVMHlVfiZOAZvcICiR33jx3MwUWYNl6k+1h
         ppJa5vYm53VpDJYExDX+Qw/vh5WiTZ38m4JSV28Uvq1PrIwWcuAop7HC0DmT/FKHVLF3
         UIFQid8EwYSC1Jlh8RH24wYlNgtgC4keciRtX87XqjSGfixcqbAAA5BF2LZJiuN5FyZE
         PXDA==
X-Gm-Message-State: AOJu0YydIB1vQZuxoaYs7ewyWzEfZox9p/NvuVsULLMOHfhLLvcyd/4f
	pg8FKa3xd9FaGLTtcP/jbpbEbo0urHDBarIQjDvQGc4fOickWIEFldhGBE67HdX8
X-Gm-Gg: Acq92OECWT0r+/3714eS6OXdzXxGaelbQ3MWcvKgBJtR7PsiBo7A5uukNHhxC2b0HSP
	odZ7EOFjqqav3TnUv0xIGnmYe6LmobGDHFmdRti8HTaz3FCu8iAf+cVutOqcjXpPe/SkY950A39
	PhzBjOP2ZXzW+PnsNZKqy0t7BgL3/5QNhG3xXV+3ZbHZRRDtQzVGGfpCAdqrmc/YeGsVKOQIpxg
	oCwCtB3BbgXdhCcKjYoHf5mGXJ0lwTbYuDBHIeRKNMMF9CmlRm4K/5PToJPXAMltEKhtXvilfkE
	mNJZK4doX+pLhzhfd6USoUj/vTFOgheaQY/ZvHiI3mFg+B+4Y56XmlJxSIQyirS1xD+qgBEEm6B
	TZKqWN8CaG/5HsaAN5yNDxfN8C+TZHxKuiZgKtKmat18zKGH26zKsx/2XOS0apb2kjT7Ajf3NKf
	BKBJMIsJfQsk0Vmioxv8HvFDoT8n9e+z00fjT76jbggsHSZaPs2TFIBa2qFy/mjcnVHdkkHAvAz
	Ry8bBFvsmsA
X-Received: by 2002:a17:907:d508:b0:bd1:d4b8:b05c with SMTP id a640c23a62f3a-bd1d4b8b0b0mr99033666b.28.1778511510658;
        Mon, 11 May 2026 07:58:30 -0700 (PDT)
Received: from karaburan ([89.150.155.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bce4c41b1e8sm252529766b.8.2026.05.11.07.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:58:30 -0700 (PDT)
From: Jhonata Poma-Hansen <jhonata.poma@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	richard.purdie@linuxfoundation.org,
	peter.kjellerstedt@axis.com,
	jhonata.poma@gmail.com
Subject: [PATCH v2] fetch2/local: verify checksums for file:// urls
Date: Mon, 11 May 2026 16:58:27 +0200
Message-ID: <20260511-b4-yocto-9993-v2-1-9d5a1c1451ba@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <162413fca4aa8fa53472aa6ba1e12b56c1a5c5c9.camel@pbarker.dev>
References: <20260430-b4-yocto-9993-v1-1-a54d842cd0fd@gmail.com> <162413fca4aa8fa53472aa6ba1e12b56c1a5c5c9.camel@pbarker.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260429-b4-yocto-9993-cadd9cbed7ce
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 May 2026 14:58:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19490

UNINATIVE_URL ships as an https:// url in metadata and verify_checksum
catches a corrupt download. Replace it with a local file:// (the
supported form for offline or pinned uninative tarballs) and the
checksum supplied via UNINATIVE_CHECKSUM was silently ignored:
Local.urldata_init unconditionally cleared ud.needdonestamp,
short-circuiting the donestamp + verify_checksum cycle for every
file:// url. Recipes that supply ;sha256sum= on a file:// url hit the
same hole.

Keep needdonestamp at the FetchData default (True) when the url carries
any of the known checksum parameters (bare ;<algo>sum= or named
;name=foo;foo.<algo>sum= form), so the standard verify_checksum flow
runs and a mismatch raises ChecksumError just like it does for
http(s)://. When no checksum is supplied (the common file:// recipe
patch case) needdonestamp stays False and behavior is unchanged.

A checksum mismatch on a file:// url must not mutate the user's source
tree the way it does for downloaded artifacts under DL_DIR. Move
rename_bad_checksum onto FetchMethod and override it as a no-op in the
Local fetcher so a ChecksumError surfaces without an on-disk
<localpath>_bad-checksum_<sha> sibling.

Link: https://bugzilla.yoctoproject.org/show_bug.cgi?id=9993
[YOCTO #9993]

Signed-off-by: Jhonata Poma-Hansen <jhonata.poma@gmail.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20260430-b4-yocto-9993-v1-1-a54d842cd0fd@gmail.com
---
 lib/bb/fetch2/__init__.py | 36 ++++++++++++++++++------------------
 lib/bb/fetch2/local.py    | 18 ++++++++++++++++--
 lib/bb/tests/fetch.py     | 30 ++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 52d5556d..5f4db608 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -738,7 +738,7 @@ def verify_donestamp(ud, d, origud=None):
         logger.warning("Checksum mismatch for local file %s\n"
                        "Cleaning and trying again." % ud.localpath)
         if os.path.exists(ud.localpath):
-            rename_bad_checksum(ud, e.checksum)
+            ud.method.rename_bad_checksum(ud, e.checksum)
         bb.utils.remove(ud.donestamp)
     return False
 
@@ -771,7 +771,7 @@ def update_stamp(ud, d):
             logger.warning("Checksum mismatch for local file %s\n"
                            "Cleaning and trying again." % ud.localpath)
             if os.path.exists(ud.localpath):
-                rename_bad_checksum(ud, e.checksum)
+                ud.method.rename_bad_checksum(ud, e.checksum)
             bb.utils.remove(ud.donestamp)
             raise
 
@@ -1067,20 +1067,6 @@ def build_mirroruris(origud, mirrors, ld):
 
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
@@ -1156,7 +1142,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
             logger.warning("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (ud.url, origud.url))
             logger.warning(str(e))
             if os.path.exists(ud.localpath):
-                rename_bad_checksum(ud, e.checksum)
+                ud.method.rename_bad_checksum(ud, e.checksum)
         elif isinstance(e, NoChecksumError):
             raise
         else:
@@ -1472,6 +1458,20 @@ class FetchMethod(object):
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
@@ -1937,7 +1937,7 @@ class Fetch(object):
                             logger.warning("Checksum failure encountered with download of %s - will attempt other sources if available" % u)
                             logger.debug(str(e))
                             if os.path.exists(ud.localpath):
-                                rename_bad_checksum(ud, e.checksum)
+                                ud.method.rename_bad_checksum(ud, e.checksum)
                         elif isinstance(e, NoChecksumError):
                             raise
                         else:
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index fda56a56..f9808e9b 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -17,7 +17,7 @@ import os
 import urllib.request, urllib.parse, urllib.error
 import bb
 import bb.utils
-from   bb.fetch2 import FetchMethod, FetchError, ParameterError
+from   bb.fetch2 import CHECKSUM_LIST, FetchMethod, FetchError, ParameterError
 from   bb.fetch2 import logger
 
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
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 077f741e..93e889fd 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -813,6 +813,36 @@ class FetcherLocalTest(FetcherTest):
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

---
base-commit: 5d722b5d65e4eef7befe6376983385421e993f86
change-id: 20260429-b4-yocto-9993-cadd9cbed7ce

Best regards,
-- 
Jhonata Poma-Hansen <jhonata.poma@gmail.com>

