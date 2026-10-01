Return-Path: <setairidis@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ACDCA5FCE
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 20:53:58 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21468.1790888029411719856
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Oct 2026 13:53:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=QFeKA1Th;
 spf=pass (domain: gmail.com, ip: 74.125.225.140, mailfrom: setairidis@gmail.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso53381085e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 01 Oct 2026 13:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790888027; x=1791492827; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=reWlFLwIUX22DvpSGRZ3wvoP/PwE+nqpfeOHLY8vSPU=;
        b=QFeKA1ThR84VMyV16GULBYjFzKrnlw2lyZT7Y9l+kCsTduHE1hachvo3tQq2UUFhaU
         V0m3YL/K0ySWQKlIFGf7gkvBsWv1cderAenErOUiVLzdT2aUITAoU5NLozFvlg/J9fyF
         zM7ZPgGCT9AaM0vPbx9crTpjhcoSHfKRip2XJyCowwbozhQ0hVSbkgrwuTK/owx7Qd4s
         Nftbqnzm4eTor2KZWVDVh/riB3MWs5oFuCO9VoqzXt/b6oyRopP5iel9KtYhWDqrJ95Q
         BaDhDcCjkVgrx+EfGdAzvQX1UFS28v9ilk1oB+Am+T8tnG+XPoCDRNegeRvedEvsduUq
         GnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790888027; x=1791492827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=reWlFLwIUX22DvpSGRZ3wvoP/PwE+nqpfeOHLY8vSPU=;
        b=zJfuFqKj/UCQqMvah6NFHlXuH4sedU0ZCUBAvYomEkHmtm4Q4ushzt02neOxDKJKcz
         ATL584kWF8F5N0JqhpRyTZ4RPSQCM98b3O1gqAQv9Eoso4BtquFnABEuTS0ha0FhQWtU
         ZAx9A4/z1BPscvp0KQ6btWvy8PW+17bkrbcgK8BxTjHw4qiBMZMZN4l0vOjr2KpKABNQ
         stGKPUm8RqUnYNlD7J0gskxjFYmDMyRrhWUKO1w77BwiYpm8oZgTt0vQJjOkDO3TKwxc
         3ZhFNyGapne5dqt8GlCP/3JV+mBebt/BfRTywjun7qPFKT70bJp+OtVBgTr7H2ZjU8Fe
         g+tw==
X-Gm-Message-State: AFuF++m1SX9gt9zIc69IGww+p1dPJkA7JM2UF+098mR3MljvFwqTPhLg
	yR7DSteLnKnwOSX5PZB7nSzs9Z2PzXlC8daM2igosPR6AJyzNuQTYneOB9ZoNfRODyM=
X-Gm-Gg: AYBFou3WyZ22zMhHj6oKoLdHX2he6egdr0xfrUdNEgZDReb+fTY9HBo7fOmgsMwhiEM
	LtSCyf+T2IVlWFk9oPMU+aqkZz9AsgMpyENaWj/NtNE9LdBU4NoLN5vuTZ0bhhjvIKJnAUyuDnM
	TlS341gkJ50d/H4HBAXu8OMn0pRyErhhGY5WxnhWYAJ/NnjEdNL9VBSUL6SOkfx2/qFHR8FoRuj
	0OHjgoH/+dfbzYyKg8SSTsyixufa/gaQyB1RYgDxZMw3ulHRqcvLew0voeLF+yYLopSd3cnP0xT
	CzKj4S2szfheks6mO93srIWUCRk2jdi5xPuPSUJX1cpuleuNLr7A55JW52P7bcgfuO4TL3u6+Hz
	uvJFFkE5q6VvZGZCpojbEkBBdfno2cA7APzj4MOfNy+x7Caw8HfrczepzH0oaDiuB4eswOnKjcR
	xZSkUrKqrQWXBeo7EMSj+9nc9vuMcYWD1TZRe5GL9oR9ymbYQEUsSM0TMBm7WB0Ea1EIz0WlQj8
	eA8mg8+ZjRVH2PNAXqaTOzuXebAvHjIYp8mse4b0DgwycrsaGlGj2hbYx4RfUp00zDheBHS4Qwf
	VnnEXkc/2Q==
X-Received: by 2002:a05:600d:6413:20b0:49f:c331:39e4 with SMTP id 5b1f17b1804b1-4a02758ff4dmr10113835e9.7.1790888027292;
        Thu, 01 Oct 2026 13:53:47 -0700 (PDT)
Received: from DESKTOP-LR19VKC.localdomain (ipservice-092-208-106-062.092.208.pools.vodafone-ip.de. [92.208.106.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f9ad6sm731744f8f.40.2026.10.01.13.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 13:53:46 -0700 (PDT)
From: Savvas Etairidis <setairidis@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Jhonata Poma-Hansen <jhonata.poma@gmail.com>,
	Paul Barker <paul@pbarker.dev>,
	Savvas Etairidis <setairidis@gmail.com>
Subject: [PATCH v7] fetch/local: verify checksums for file:// urls
Date: Thu,  1 Oct 2026 22:53:44 +0200
Message-Id: <20261001205344.99638-1-setairidis@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <abf12d51916cac8780914605168243c54494ca32.camel@pbarker.dev>
References: <abf12d51916cac8780914605168243c54494ca32.camel@pbarker.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Oct 2026 20:53:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20288

[YOCTO #9993]

A checksum given in a file:// url (e.g. UNINATIVE_CHECKSUM when
UNINATIVE_URL points at a local file://) was never verified, because
Local disables the donestamp and so verify_checksum() was never called.
Override verify_donestamp() in Local to check the file against those
checksums. A mismatch raises ChecksumError before the rename/mirror
handling, so the user's file is never renamed.

Based on a patch by Jhonata Poma-Hansen.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Savvas Etairidis <setairidis@gmail.com>

---
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
 lib/bb/fetch/__init__.py |   9 ++++
 lib/bb/fetch/local.py    |  82 +++++++++++++++++++++++++++++
 lib/bb/tests/fetch.py    | 109 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index fb6278439..d74c20df4 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -1413,6 +1413,15 @@ class FetchData(object):
         self.donestamp = basepath + '.done'
         self.lockfile = basepath + '.lock'
 
+    def checksum_expected(self):
+        """
+        Is any checksum given for this url?
+        """
+        for checksum_id in CHECKSUM_LIST:
+            if getattr(self, "%s_expected" % checksum_id):
+                return True
+        return False
+
     def setup_revisions(self, d):
         self.revision = srcrev_internal_helper(self, d, self.name)
 
diff --git a/lib/bb/fetch/local.py b/lib/bb/fetch/local.py
index dfc5b564c..ca9f91497 100644
--- a/lib/bb/fetch/local.py
+++ b/lib/bb/fetch/local.py
@@ -14,6 +14,8 @@ BitBake build tools.
 #
 
 import os
+import hashlib
+import json
 import urllib.request, urllib.parse, urllib.error
 import bb
 import bb.utils
@@ -36,6 +38,82 @@ class Local(FetchMethod):
             raise bb.fetch.ParameterError("file:// urls using globbing are no longer supported. Please place the files in a directory and reference that instead.", ud.url)
         return
 
+    def checksum_stamp(self, ud, d):
+        """
+        Return the stamp file caching the checksums of ud.localpath, or None.
+        """
+        dldir = d.getVar("DL_DIR")
+        if not dldir or not ud.localpath:
+            return None
+        path = os.path.abspath(ud.localpath)
+        return os.path.join(dldir, "local-checksums",
+                            hashlib.sha256(path.encode("utf-8")).hexdigest())
+
+    def checksum_filestat(self, st):
+        """
+        Return a list of the file's stat information that is used to detect changes.
+        """
+        return [st.st_ino, st.st_size, st.st_mtime_ns, st.st_ctime_ns]
+
+    def read_checksum_stamp(self, ud, d, st):
+        """
+        Return the checksums cached in the stamp file for ud.localpath, or {}
+        if there are none or the file has changed since they were computed.
+        """
+        stamp = self.checksum_stamp(ud, d)
+        if not stamp:
+            return {}
+        try:
+            with open(stamp) as f:
+                cached = json.load(f)
+            if cached["stat"] == self.checksum_filestat(st) and isinstance(cached["checksums"], dict):
+                return cached["checksums"]
+        except (OSError, ValueError, KeyError, TypeError):
+            pass
+        return {}
+
+    def write_checksum_stamp(self, ud, d, st, checksums):
+        """
+        Cache the checksums computed for ud.localpath, which had the stat
+        result st before it was hashed, in the stamp file.
+        """
+        stamp = self.checksum_stamp(ud, d)
+        if not stamp:
+            return
+
+        # Written via rename as no lock is held for file:// urls. Errors
+        # aren't fatal, the file is just hashed again next time.
+        tmpstamp = "%s.%d" % (stamp, os.getpid())
+        try:
+            bb.utils.mkdirhier(os.path.dirname(stamp))
+            with open(tmpstamp, "w") as f:
+                json.dump({"path": ud.localpath, "stat": self.checksum_filestat(st), "checksums": checksums}, f)
+            os.rename(tmpstamp, stamp)
+        except OSError:
+            try:
+                os.unlink(tmpstamp)
+            except OSError:
+                pass
+
+    def verify_donestamp(self, ud, d):
+        # file:// urls have no donestamp; verify any checksum given in the url
+        # against the file itself. A missing file is reported by download()
+        # with the searched paths, so there's nothing to check here. A mismatch
+        # raises ChecksumError rather than returning False, as there's nothing
+        # to re-download.
+        if not ud.checksum_expected():
+            return True
+        try:
+            st = os.stat(ud.localpath)
+        except OSError:
+            return True
+
+        precomputed = self.read_checksum_stamp(ud, d, st)
+        checksums = bb.fetch.verify_checksum(ud, d, precomputed)
+        if checksums and checksums != precomputed:
+            self.write_checksum_stamp(ud, d, st, checksums)
+        return True
+
     def localpath(self, urldata, d):
         """
         Return the local filename of a given url assuming a successful fetch.
@@ -87,5 +165,9 @@ class Local(FetchMethod):
         return False
 
     def clean(self, urldata, d):
+        # The file is the user's; only remove our cached checksums for it
+        stamp = self.checksum_stamp(urldata, d)
+        if stamp:
+            bb.utils.remove(stamp)
         return
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 71b0a63fe..cbb47849c 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -21,6 +21,7 @@ import subprocess
 import json
 import tarfile
 import threading
+import time
 from bb.fetch import URI
 import bb
 import bb.utils
@@ -876,6 +877,114 @@ class FetcherLocalTest(FetcherTest):
             with self.subTest(striplevel=repr(value)):
                 self.assertInvalidStriplevel(value)
 
+    def writeSumfile(self, content, dirname=None):
+        path = os.path.join(dirname or self.localsrcdir, 'sumfile')
+        with open(path, 'wb') as f:
+            f.write(content)
+        return path, hashlib.sha256(content).hexdigest()
+
+    def localChecksumStamps(self):
+        stampdir = os.path.join(self.dldir, 'local-checksums')
+        return os.listdir(stampdir) if os.path.exists(stampdir) else []
+
+    def test_local_checksum_match(self):
+        srcpath, good = self.writeSumfile(b"file:// checksum match test\n")
+        fetcher = bb.fetch.Fetch(['file://sumfile;sha256sum=' + good], self.d)
+        fetcher.download()
+        # Only the checksum stamp should be created in DL_DIR
+        self.assertEqual(os.listdir(self.dldir), ['local-checksums'])
+        stamps = self.localChecksumStamps()
+        self.assertEqual(len(stamps), 1)
+        # The stamp must follow the umask, so a shared DL_DIR can re-use it
+        umask = os.umask(0)
+        os.umask(umask)
+        mode = os.stat(os.path.join(self.dldir, 'local-checksums', stamps[0])).st_mode
+        self.assertEqual(mode & 0o777, 0o666 & ~umask)
+        # Cleaning removes the stamp but not the user's file
+        fetcher.clean()
+        self.assertEqual(self.localChecksumStamps(), [])
+        self.assertTrue(os.path.exists(srcpath))
+
+    def test_local_checksum_no_checksum_no_stamp(self):
+        self.writeSumfile(b"file:// no checksum test\n")
+        bb.fetch.Fetch(['file://sumfile'], self.d).download()
+        self.assertEqual(os.listdir(self.dldir), [])
+
+    def test_local_checksum_stamp_write_failure(self):
+        # A failure to write the stamp isn't fatal and leaves nothing behind
+        srcpath, good = self.writeSumfile(b"file:// checksum stamp failure test\n")
+        with unittest.mock.patch('os.rename', side_effect=OSError("rename failed")):
+            bb.fetch.Fetch(['file://sumfile;sha256sum=' + good], self.d).download()
+        self.assertEqual(self.localChecksumStamps(), [])
+
+    def test_local_checksum_unreachable_file(self):
+        # A path below a regular file can't be stat()ed; this should be
+        # reported as a missing file, not as an OSError
+        srcpath, good = self.writeSumfile(b"file:// checksum unreachable test\n")
+        fetcher = bb.fetch.Fetch(['file://%s/sub;sha256sum=%s' % (srcpath, good)], self.d)
+        with self.assertRaises(bb.fetch.FetchError):
+            fetcher.download()
+
+    def test_local_checksum_unchanged_not_rehashed(self):
+        stampdir, good = self.writeSumfile(b"file:// checksum rehash test\n")
+        url = 'file://sumfile;sha256sum=' + good
+        with unittest.mock.patch('bb.utils.sha256_file',
+                                 wraps=bb.utils.sha256_file) as sha256_file:
+            bb.fetch.Fetch([url], self.d).download()
+            self.assertEqual(sha256_file.call_count, 1)
+            # A later fetch re-uses the checksums stored in the stamp
+            bb.fetch.Fetch([url], self.d).download()
+            self.assertEqual(sha256_file.call_count, 1)
+            # A wrong checksum in the url is still caught without re-hashing
+            with self.assertRaises(bb.fetch.ChecksumError):
+                bb.fetch.Fetch(['file://sumfile;sha256sum=' + "0" * 64], self.d).download()
+            self.assertEqual(sha256_file.call_count, 1)
+
+    def test_local_checksum_modified_keeping_mtime(self):
+        srcpath, good = self.writeSumfile(b"file:// checksum original content\n")
+        url = 'file://sumfile;sha256sum=' + good
+        bb.fetch.Fetch([url], self.d).download()
+
+        # Replace the content in place with the same size and restore the
+        # exact original mtime, as rsync -a or touch -r could; only ctime
+        # changes. Filesystem timestamps may only advance once per timer
+        # tick, so wait for longer than that first.
+        st = os.stat(srcpath)
+        time.sleep(0.05)
+        with open(srcpath, 'wb') as f:
+            f.write(b"file:// checksum modified content\n")
+        os.utime(srcpath, ns=(st.st_atime_ns, st.st_mtime_ns))
+        with self.assertRaises(bb.fetch.ChecksumError):
+            bb.fetch.Fetch([url], self.d).download()
+        self.assertTrue(os.path.exists(srcpath))
+
+    def test_local_checksum_mismatch(self):
+        content = b"file:// checksum mismatch test\n"
+        srcpath, _ = self.writeSumfile(content)
+        md5 = hashlib.md5(content).hexdigest()
+        # A correct checksum must not hide a wrong one
+        url = 'file://sumfile;md5sum=%s;sha256sum=%s' % (md5, "0" * 64)
+        fetcher = bb.fetch.Fetch([url], self.d)
+        with self.assertRaises(bb.fetch.ChecksumError) as cm:
+            fetcher.download()
+        self.assertIn("has sha256 checksum", str(cm.exception))
+        # The user's file must not be renamed to *_bad-checksum_*
+        self.assertTrue(os.path.exists(srcpath))
+        self.assertEqual(self.localChecksumStamps(), [])
+
+    def test_local_checksum_same_name_different_dirs(self):
+        # Files with the same name must not share a stamp
+        sums = {}
+        for name in ('a', 'b'):
+            dirname = os.path.join(self.localsrcdir, 'sumdir-' + name)
+            os.mkdir(dirname)
+            sums[name] = self.writeSumfile(b"file:// checksum dir %s\n" % name.encode(), dirname)
+        for srcpath, good in sums.values():
+            bb.fetch.Fetch(['file://%s;sha256sum=%s' % (srcpath, good)], self.d).download()
+        self.assertEqual(len(self.localChecksumStamps()), 2)
+        with self.assertRaises(bb.fetch.ChecksumError):
+            bb.fetch.Fetch(['file://%s;sha256sum=%s' % (sums['a'][0], sums['b'][1])], self.d).download()
+
     def dummyGitTest(self, suffix):
         # Create dummy local Git repo
         src_dir = tempfile.mkdtemp(dir=self.tempdir,
-- 
2.34.1


