Return-Path: <setairidis@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4963CA5FC4
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 21:21:33 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1798.1790803290910591916
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Sep 2026 14:21:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=X1QxyNe5;
 spf=pass (domain: gmail.com, ip: 74.125.225.140, mailfrom: setairidis@gmail.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so35970525e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Sep 2026 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790803289; x=1791408089; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2VLxzSpHwxPluoxbXJJWN9RBDVfiCgY98ZkOIrlos8=;
        b=X1QxyNe5SG8Zeku9EaEv4AKi+hcYZvxsSpWf4S/4sD0KLlV7FvsPQZB/LGfdFjmGq8
         X5W2RLskj2KEohfFiogpeYiicOufvjGcdB69xtkNV9Sb8Cl+IYXbIG47wzXTHZYp+FCK
         jGgz3unSYagRNog8E9bTWn5UhENInboxfE9vW2Cmm8UzV3vBUhLBbzLgCNIxzJ7uBpFY
         4Ri+KILUpWTctZYTofqfDMiWlOiA9kwXxZ4E75oQwK0UtOEsruphynjjTA43ICTKKCJp
         O7rSrwhfPleihQu5e02IfOsq7Rs94HpI2MO6BfQA+s74nrerq6XVeeHXaXfxjW5qbZDq
         7kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803289; x=1791408089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v2VLxzSpHwxPluoxbXJJWN9RBDVfiCgY98ZkOIrlos8=;
        b=DrKV7qzxiFl66DMFiClFA3/KhyaF4t9IW8AXjlijjQieKbYGrd1zIo3JuG3P6hWJLl
         qxa6RX7c3y9jkbVWUWUgbj31fuZm5KTkWkujISuBksYlyVXmYZ1nWVb7jXy3aq/Nd3I1
         JEaKJI9j6xuyCG4K/PtIzzR4wLqqf8WkCHIIQ7a+2ittlNedUJCXaqkjYaAfybBkZzs+
         nkNnyAyJkW4uPQhXkxOPi/k2Hj7HVbxVlzgZkFqH9qHEiHXafv0ruw9pvZFG+S5iLZW9
         H/in/dqiBIFVxrzEJwJPtO8+C68rdMaIT8b4ICEgGWJyq9lriL4woxOerfDGNhBJZfrD
         QQAg==
X-Gm-Message-State: AFuF++kEnF+lP0gDOhLfGyEfJPgRMKDtFcJ28CY0WJo4RvKut/mRle64
	BgmpekCRrcdIjsh45M5g9O3ZNojg6UadR2CTyCYMrGm/74tnJMH5yHIi1Onz14Zo
X-Gm-Gg: AYBFou3/tb1qyZw89dEduShKYOuymMXNH/IilU73onYCsel3+uzYnvMZToP3yD5/k/Q
	FZjJrq9faOGk5M07A2Po/Sg+3Om+r9wjF/bsToUId+2uEQGZUijXeJJYDRfuPubfLgyMFa6AJEa
	8EAjHm98F7OyTNgco8/VRokonfEsAM0XXY/BEazvi7LWuMeZZ/MSnabwyyXUHmqDhewh9xHkmCb
	6o8l3MLl0rMDSOKK+dpRJQU9ylDXAC/9a8Zbzz7EROCVaSB80ag6SSOdcvJlJRYVq3boryJBRSj
	FC8w41WtnUsooHMasitwzDB93xg9nvbFjbwI4tQMHqACRf6acn3vaUZKqIQMSGSK/iGMxbPKycI
	uEFHPsIpB/z4Lq9h8Aua0bIH3WGyFZ3gQUK23zFD1sk953KAlp9Zc8sJ/AlWvZ1CjNmIgXvXrAL
	MfjfG184/yKC6MlrSMJtoQ4C52eN6kht9bwWFE2f5LZh7dEBtjgXUQDC5QjbdKXKJM/SKYAuZ63
	6/H02XuFDXoWLHG2wl/sRADM6aAD0I+p5TUThSztkkcp99z11t4YuBgNm5noMISnTQrl4ZEJcB4
	gA+U0PYGlG2ExuLijXM=
X-Received: by 2002:a05:600c:e54a:10b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-4a01b11ea41mr29256115e9.23.1790803288813;
        Wed, 30 Sep 2026 14:21:28 -0700 (PDT)
Received: from DESKTOP-LR19VKC.localdomain (ipservice-092-208-102-108.092.208.pools.vodafone-ip.de. [92.208.102.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01fa15e51sm10792365e9.2.2026.09.30.14.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:21:28 -0700 (PDT)
From: Savvas Etairidis <setairidis@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Jhonata Poma-Hansen <jhonata@example.com>,
	Paul Barker <paul@pbarker.dev>,
	Savvas Etairidis <setairidis@gmail.com>
Subject: [PATCH v6] fetch/local: verify checksums for file:// urls
Date: Wed, 30 Sep 2026 23:21:25 +0200
Message-Id: <20260930212125.118877-1-setairidis@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0aca7b91f894803dcb2e436d98ecb2c404c610d3.camel@pbarker.dev>
References: <0aca7b91f894803dcb2e436d98ecb2c404c610d3.camel@pbarker.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Sep 2026 21:21:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20286

[YOCTO #9993]

A checksum given in a file:// url (e.g. UNINATIVE_CHECKSUM when
UNINATIVE_URL points at a local file://) was never verified, because
Local disables the donestamp and so verify_checksum() was never called.
Override verify_donestamp() in Local to check the file against those
checksums on every fetch, via a new
FetchData.verify_checksum_if_expected() helper. A mismatch raises
ChecksumError before the rename/mirror handling, so the user's file is
never renamed.

Hashing directly rather than enabling the donestamp avoids trusting a
cached checksum for a file edited with an old mtime, and avoids stamp
and lock paths in DL_DIR derived from the url path colliding with other
recipes or real downloads.
The file is re-hashed on every fetch; this is a known cost, but only
for file:// urls that carry a checksum, which are typically small.

Based on a patch by Jhonata Poma-Hansen.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Savvas Etairidis <setairidis@gmail.com>

---
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
 lib/bb/fetch/__init__.py | 13 ++++++++++++
 lib/bb/fetch/local.py    | 16 ++++++++++++++
 lib/bb/tests/fetch.py    | 46 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index fb6278439..418a031ec 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -1413,6 +1413,19 @@ class FetchData(object):
         self.donestamp = basepath + '.done'
         self.lockfile = basepath + '.lock'
 
+    def verify_checksum_if_expected(self, d):
+        """
+        Verify localpath against the checksums given in the url, if any.
+        """
+        expected = False
+        for checksum_id in CHECKSUM_LIST:
+            if getattr(self, "%s_expected" % checksum_id):
+                expected = True
+                break
+
+        if expected:
+            verify_checksum(self, d)
+
     def setup_revisions(self, d):
         self.revision = srcrev_internal_helper(self, d, self.name)
 
diff --git a/lib/bb/fetch/local.py b/lib/bb/fetch/local.py
index dfc5b564c..d7551221b 100644
--- a/lib/bb/fetch/local.py
+++ b/lib/bb/fetch/local.py
@@ -36,6 +36,22 @@ class Local(FetchMethod):
             raise bb.fetch.ParameterError("file:// urls using globbing are no longer supported. Please place the files in a directory and reference that instead.", ud.url)
         return
 
+    def verify_donestamp(self, ud, d):
+        # file:// urls have no donestamp; verify any checksum given in the url
+        # against the file itself on every fetch, since it may be edited in
+        # place without its mtime changing. A missing file is reported by
+        # download() with the searched paths, so there's nothing to check here.
+        if not os.path.exists(ud.localpath):
+            return True
+        # Re-hashing on every run is a known cost: verify_checksum() computes
+        # every algorithm in CHECKSUM_LIST, and Fetch.download() calls
+        # verify_donestamp() twice, so a 100MB file adds ~1s per fetch.
+        # This only affects file:// urls that carry a checksum, which are
+        # typically small (e.g. uninative tarballs), so correctness is
+        # preferred over caching.
+        ud.verify_checksum_if_expected(d)
+        return True
+
     def localpath(self, urldata, d):
         """
         Return the local filename of a given url assuming a successful fetch.
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 71b0a63fe..2bec8a66a 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -876,6 +876,52 @@ class FetcherLocalTest(FetcherTest):
             with self.subTest(striplevel=repr(value)):
                 self.assertInvalidStriplevel(value)
 
+    def test_local_checksum_match(self):
+        import hashlib
+        content = b"file:// checksum match test\n"
+        with open(os.path.join(self.localsrcdir, 'sumfile'), 'wb') as f:
+            f.write(content)
+        good = hashlib.sha256(content).hexdigest()
+        fetcher = bb.fetch.Fetch(['file://sumfile;sha256sum=' + good], self.d)
+        fetcher.download()
+        # No stamp or lock files should be created in DL_DIR for file:// urls
+        self.assertEqual(os.listdir(self.dldir), [])
+
+    def test_local_checksum_modified_with_old_mtime(self):
+        import hashlib
+        srcpath = os.path.join(self.localsrcdir, 'sumfile')
+        with open(srcpath, 'wb') as f:
+            f.write(b"file:// checksum original content\n")
+        good = hashlib.sha256(b"file:// checksum original content\n").hexdigest()
+        url = 'file://sumfile;sha256sum=' + good
+        bb.fetch.Fetch([url], self.d).download()
+
+        # Replace the content but keep an old mtime, as cp -p or rsync -a would
+        old = os.stat(srcpath).st_mtime - 3600
+        with open(srcpath, 'wb') as f:
+            f.write(b"file:// checksum modified content\n")
+        os.utime(srcpath, (old, old))
+        with self.assertRaises(bb.fetch.ChecksumError):
+            bb.fetch.Fetch([url], self.d).download()
+        self.assertTrue(os.path.exists(srcpath))
+
+    def test_local_checksum_mismatch(self):
+        import hashlib
+        content = b"file:// checksum mismatch test\n"
+        srcpath = os.path.join(self.localsrcdir, 'sumfile')
+        with open(srcpath, 'wb') as f:
+            f.write(content)
+        md5 = hashlib.md5(content).hexdigest()
+        # verify_checksum_if_expected() stops at the first checksum it finds
+        # (md5); a wrong checksum later in CHECKSUM_LIST must still be caught
+        url = 'file://sumfile;md5sum=%s;sha256sum=%s' % (md5, "0" * 64)
+        fetcher = bb.fetch.Fetch([url], self.d)
+        with self.assertRaises(bb.fetch.ChecksumError) as cm:
+            fetcher.download()
+        self.assertIn("has sha256 checksum", str(cm.exception))
+        # The user's file must not be renamed to *_bad-checksum_*
+        self.assertTrue(os.path.exists(srcpath))
+
     def dummyGitTest(self, suffix):
         # Create dummy local Git repo
         src_dir = tempfile.mkdtemp(dir=self.tempdir,
-- 
2.34.1


