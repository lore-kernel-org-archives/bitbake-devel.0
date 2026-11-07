Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2197.1794083034819602818
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 07 Nov 2026 12:23:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=hubllTGl;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: setairidis@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e46e449e8so16436f8f.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 07 Nov 2026 12:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794083033; x=1794687833; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W4iJ8MqLMHXn+YZy4whpPA+IWcZCQ24zRU6EDgf5img=;
        b=hubllTGldAFauwpVVXutBGCD+cSSdB+BanYyeaBqvOPeyiGCuq3qWU0pH/fSrHWbVc
         OCaaU/NNpbgVegmFJylb4zgYQQser6AeWPmyMwoA3o1HgPsbl4kErcwU1s8m6FJZbWJT
         K34TAbykbIFyYvXMnpkP5Sh7o1YfbCmwo6Yl9cgmQwt0zzCiMjY7n74dluVXHrrnsX9S
         eon4kwvc6FF3mC8L2svjr/oJ+INC5QZB48npqYdslkMuBQn7A+uemHJisqsiG4LsYFcJ
         uy7JOKn0htbpegdlueayX7zJFa96ZuHIJC/eu5AzTI2LUM+HfNq0hnmHaJ12adahSmQN
         iwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794083033; x=1794687833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W4iJ8MqLMHXn+YZy4whpPA+IWcZCQ24zRU6EDgf5img=;
        b=EknC9FfPFkX+105dFBSgYwNJrKCq5ZwZUu8N1q+mQQbnLcim8+hRkC7IzWNDuSkzua
         9yvjk2to2U3wbz7eJoHNLA/1hg0Yf4Lf2NcuxdAtWxKThDkpQI3glLZVTCGvWpNnVlDM
         Em7NxY5VXwAQFXzWfoSQ+589+Vsmb6iunHtC/WziGQTYNZ7Rn7afue16bHQYivN6O7vk
         +yYPlE6wA3hQ/idbaEc2FhdLvGVYJ2IXXUIhyOxP53yQMcw0IOhZQDi8dChh3FC8bjnT
         sAZOzs4azHmEPYZHQCuViRV0E0g4ykXUi/N9Cjf+dU2W54UVp3JfSc5cpBTcUGQLidiq
         pLNg==
X-Gm-Message-State: APuU4Z86ZuKlw3Kdl+87gkHMvkXsCi4gfJIoITQUzEQPPCD/rvuMoHfS
	hNGHczPwLLIyzTtSBRauSP2WCs2Btz3NZyQ7BNb6jThYHzBfB+35u+J8hb9TYRLk
X-Gm-Gg: AYBFou0SExwkR3av+fiKtw05YRfOmSUtXouN3FCe5j4bDEttCBycdlJs+crqbHJgC15
	YU3d5sq2w71waWRM2+wLfHOsLzYfW7YXmYI/YhRDQhsHw0WWdxdZZJgBpoYwk78CMLXfs4CDMTz
	D3QqckSSngWHKsZ7bOFkIP564XCzvgFHzEuh3+EHzElLKGNOtQ4B6n81WUM+clvmUhRw4KZh6nx
	PpZoYFae4S880ghQfWeaYE8TjiNpx0IUwyrBQco4GGm/qVVUHENiNpkZibi+zimfxhYCcf9zYuT
	M7XUO8MwssVMyJy9XApeUVGQ3q4I9DiIy+0m/Mfy0quD8yqOM2xeOB+/PYQo61r5JtkrT4R88zq
	uOOB7VNjvu+I+gjr04TavZSWDpUDMEDUnwWPia+h+nkyqEwawuoON+WzMo+9aygmCusWD7+3cue
	WMde6sYFBniX5L3h4VYH3u5wSL/2vzRwQ7vXdkgmSMRbgHiJ3tyD64WVM6fBVmPzaqhw8sDur20
	56ZoYB5gEQl6ebmHz1ghBnj1uhTmmlttLlrvR0O5BEIq+A0OLELwTsZCIqWxEcwdf9DWaChxag7
	R0oi+dpWkiqwMkIlfzwcC1X/N8g8KR+mIgpqI4ZYeuk7+98UZrQsr8Lzuk5sqMApDDXFh+HenXh
	ztdGyZjnht4BADWKzrU8U85NgUSUHGBuWmwPNkyfgfg6P9rn9wjxY85u/XpH4d16Hl2JHCYBzN+
	XKh4RMOnF5ceiDvkILUWM=
X-Received: by 2002:a05:6000:2689:b0:490:b23b:8017 with SMTP id ffacd0b85a97d-4958c1b4e1fmr86891f8f.34.1794083032530;
        Sat, 07 Nov 2026 12:23:52 -0800 (PST)
Return-Path: <setairidis@gmail.com>
Received: from DESKTOP-LR19VKC.localdomain (ipservice-092-209-186-048.092.209.pools.vodafone-ip.de. [92.209.186.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7701af6sm11640652f8f.38.2026.11.07.12.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 12:23:52 -0800 (PST)
From: Savvas Etairidis <setairidis@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paul Barker <paul@pbarker.dev>,
	Jhonata Poma-Hansen <jhonata.poma@gmail.com>,
	Savvas Etairidis <setairidis@gmail.com>
Subject: [PATCH v9] fetch/local: verify checksums for file:// urls
Date: Sat,  7 Nov 2026 21:23:48 +0100
Message-ID: <20261107202348.29338-1-setairidis@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <344401.1794082642467075956@lists.openembedded.org>
References: <344401.1794082642467075956@lists.openembedded.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sat, 07 Nov 2026 20:24:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20407
Content-Type: text/plain; charset="utf-8"

[YOCTO #9993]

A checksum given in a file:// url (e.g. UNINATIVE_CHECKSUM when
UNINATIVE_URL points at a local file://) was never verified, because
Local disables the donestamp and so verify_checksum() was never called.
Enable the donestamp in Local.urldata_init() for file:// urls that carry
a checksum parameter.

Based on a patch by Jhonata Poma-Hansen.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Savvas Etairidis <setairidis@gmail.com>

---
changes in v9:
- Moved the donestamp decision from FetchData.__init__() into
  Local.urldata_init(), with a Local.checksum_expected() helper that
  checks the url parameters (the *_expected attributes are not yet set
  when urldata_init() runs).
- Made rename_bad_checksum() a FetchMethod method, overridden in Local,
  instead of special-casing Local in the base fetcher code.
- Tested with BB_SKIP_NETTESTS=yes bin/bitbake-selftest bb.tests.fetch

changes in v8:
- Dropped the local-checksums stamps and re-used the regular donestamp,
  enabled only for file:// urls with a checksum. local.py is unchanged
  again.
- Tests reduced to a checksum match and a mismatch test.
- Tested with BB_SKIP_NETTESTS=yes bin/bitbake-selftest bb.tests.fetch

changes in v7:
- We shouldn't assume that anything coming from a file:// URL is
  "typically small", or that it is on fast local storage (it could be on a
  HDD array accessed over NFS).
* Rework the code to avoid re-hashing the file on every fetch, and
  instead only re-hash it when the checksum is actually expected to be verified.
- You don't need to mention this if it didn't result in actual change.
* Wont do in the future.
- Such as? This is a completely different approach so it's useful to know
  which bits of feedback were actually relevant and which were made
  obsolete by the change in approach.
* Hoped I did better this time.
- What does "edited with an old mtime" mean?
* In that test the file attributes are modified to have an old mtime,
  which is a corner case that was not handled correctly before.
  This test was removed in v6 because the new approach doesn't have
  that issue anymore.
- Why complicate this by using different hash algorithms for the different
  tests?
  The test wants to cover the case where we have a valid md5sum but an
  invalid sha256sum or a invalid md5sum but a valid sha256sum.
- Added a test to covern new functionality.

changes in v6:
- Rebased on top of master
- Fixed issues reported by reviewer
- Check the file directly in Local.verify_donestamp(), via a new
  FetchData.verify_checksum_if_expected() helper, instead of enabling
  the donestamp. Fixes stale checksums for files edited with an old
  mtime and DL_DIR stamp/lock path collisions
- Drop the rename_bad_checksum() refactor, no longer needed
- Document the cost of re-hashing on every fetch
- Tests: use a correct md5sum and a wrong sha256sum in the mismatch
  test, add a test for a file edited with an old mtime, and check that
  nothing is written to DL_DIR
- Tested with BB_SKIP_NETTESTS=yes bin/bitbake-selftest bb.tests.fetch

changes in v5:
- Rebased on top of master, added changelog entry

changes in v4:
- Rebased on top of master

changes in v3:
- Cherry-picked the patch from Jhonata Poma-Hansen

---
---
 lib/bb/fetch/__init__.py | 41 ++++++++++++++++++++--------------------
 lib/bb/fetch/local.py    | 20 +++++++++++++++++++-
 lib/bb/fetch/wget.py     |  2 +-
 lib/bb/tests/fetch.py    | 30 +++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 23 deletions(-)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index eb3483a48..d339ac1da 100644
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
 
@@ -1079,23 +1079,6 @@ def build_mirroruris(origud, mirrors, ld):
 
     return uris, uds
 
-def rename_bad_checksum(ud, suffix, localpath=None):
-    """
-    Renames files to have suffix from parameter
-    """
-
-    if ud.localpath is None:
-        return
-
-    if localpath is None:
-        localpath = ud.localpath
-
-    new_localpath = "%s_bad-checksum_%s" % (ud.localpath, suffix)
-    bb.warn("Renaming %s to %s" % (localpath, new_localpath))
-    if not bb.utils.movefile(localpath, new_localpath):
-        bb.warn("Renaming %s to %s failed, grep movefile in log.do_fetch to see why" % (localpath, new_localpath))
-
-
 def try_mirror_url(fetch, origud, ud, ld, check = False):
     # Return of None or a value means we're finished
     # False means try another url
@@ -1166,7 +1149,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
             logger.warning("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (ud.url, origud.url))
             logger.warning(str(e))
             if os.path.exists(ud.localpath):
-                rename_bad_checksum(ud, e.checksum)
+                ud.method.rename_bad_checksum(ud, e.checksum)
         elif isinstance(e, NoChecksumError):
             raise
         else:
@@ -1482,6 +1465,22 @@ class FetchMethod(object):
         """
         return True
 
+    def rename_bad_checksum(self, ud, suffix, localpath=None):
+        """
+        Renames files to have suffix from parameter
+        """
+
+        if ud.localpath is None:
+            return
+
+        if localpath is None:
+            localpath = ud.localpath
+
+        new_localpath = "%s_bad-checksum_%s" % (ud.localpath, suffix)
+        bb.warn("Renaming %s to %s" % (localpath, new_localpath))
+        if not bb.utils.movefile(localpath, new_localpath):
+            bb.warn("Renaming %s to %s failed, grep movefile in log.do_fetch to see why" % (localpath, new_localpath))
+
     def verify_donestamp(self, ud, d):
         """
         Verify the donestamp file
@@ -1946,7 +1945,7 @@ class Fetch(object):
                             logger.warning("Checksum failure encountered with download of %s - will attempt other sources if available" % u)
                             logger.debug(str(e))
                             if os.path.exists(ud.localpath):
-                                rename_bad_checksum(ud, e.checksum)
+                                ud.method.rename_bad_checksum(ud, e.checksum)
                         elif isinstance(e, NoChecksumError):
                             raise
                         else:
diff --git a/lib/bb/fetch/local.py b/lib/bb/fetch/local.py
index dfc5b564c..0c36ec39d 100644
--- a/lib/bb/fetch/local.py
+++ b/lib/bb/fetch/local.py
@@ -31,11 +31,29 @@ class Local(FetchMethod):
         # We don't set localfile as for this fetcher the file is already local!
         ud.basename = os.path.basename(ud.path)
         ud.basepath = ud.path
-        ud.needdonestamp = False
+        # Only use a donestamp when a checksum is given in the url, so that
+        # verify_checksum() gets called for the file
+        ud.needdonestamp = self.checksum_expected(ud)
         if "*" in ud.path:
             raise bb.fetch.ParameterError("file:// urls using globbing are no longer supported. Please place the files in a directory and reference that instead.", ud.url)
         return
 
+    def checksum_expected(self, ud):
+        """
+        Is any checksum given in the url parameters?
+        """
+        for checksum_id in bb.fetch.CHECKSUM_LIST:
+            if "%ssum" % checksum_id in ud.parm or \
+               "%s.%ssum" % (ud.name, checksum_id) in ud.parm:
+                return True
+        return False
+
+    def rename_bad_checksum(self, ud, suffix, localpath=None):
+        """
+        A file:// url refers to the user's own file, leave it in place
+        """
+        return
+
     def localpath(self, urldata, d):
         """
         Return the local filename of a given url assuming a successful fetch.
diff --git a/lib/bb/fetch/wget.py b/lib/bb/fetch/wget.py
index 0411a6740..a4eb9bf98 100644
--- a/lib/bb/fetch/wget.py
+++ b/lib/bb/fetch/wget.py
@@ -181,7 +181,7 @@ class Wget(FetchMethod):
         except bb.fetch.ChecksumError as e:
             # The download is resumed with --continue, so a bad file left in place
             # would be reused by the mirrors and by every later attempt
-            bb.fetch.rename_bad_checksum(ud, e.checksum, localpath=localpath)
+            self.rename_bad_checksum(ud, e.checksum, localpath=localpath)
             raise
 
         # Remove the ".tmp" and move the file into position atomically
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 0f29cdf11..3c518805c 100644
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
2.53.0

