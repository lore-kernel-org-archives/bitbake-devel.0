Return-Path: <setairidis@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C1ECA5FDD
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 20:51:01 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4064.1790974259892006950
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Oct 2026 13:51:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=HHnZ+jf9;
 spf=pass (domain: gmail.com, ip: 74.125.225.141, mailfrom: setairidis@gmail.com)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a024e16179so1515015e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Oct 2026 13:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790974258; x=1791579058; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tpB5aC85nmCtUqidcL0JoxMdc2fmSOdriVGCCOdoYEM=;
        b=HHnZ+jf9ULKf6eDd8BnLAo6cnNjIclweHwLCxamNORFPaH5A8JiBGpnLqHWxKhECff
         d+uAthhnjJ+OVPuC4TwAER8N+Q1aVAIbnzPkR8s5LeZT0whloxwYX9FSfklA+uAPVeCn
         LXswKpk23CpAUPLH5XWzWgoM6Tsjan/KWprwinxMLuoWJXl1QpbOnAqj4ZAsl2YYgO8V
         6YXZq16PRsGk3SCdbwOcQNN0C239D+dDhtFyNa3Cq8QMSYm830oMGUB19TY40msHpcS8
         eaeVgWBMn55zz7hGAMMnMaeSuDQKSmetoXY9kr73zewv0D9rs43AfbGTUCcaXp96X6/e
         Q/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790974258; x=1791579058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tpB5aC85nmCtUqidcL0JoxMdc2fmSOdriVGCCOdoYEM=;
        b=VRW4/uK/82ELqNt7KFQc+JEjRbd0lxSYWo6k65YVwScmqDlRojGw93GpA3+4AeLH4k
         QirCWDg1wDmoTjPXLPZpYoogvax/z2QgwuOaoMbl89kbZ5ADqnro8z3wyu49sIjI946o
         2ZWElhmxhKYMWQS4lqA8hy2SuMRwAt2kJt+qK1+BxfummBwAEKFCW7GIZ2Mi+coH3h6s
         ffRR7AMWDYzLMPHlHDcPOUgNIU7LNtcEmA7A481CKasgpKiFGcuGpqyDSymJbGKxyQNr
         9l6AfA+wAKpluIRzlBfio4EbuUWf61mwPhCRwxcWbdsuz6QUGWDYVo2jz205plBl4QP5
         /j1w==
X-Gm-Message-State: AFuF++mnzP39opLSDxmU15IfdJplSLIX+FGN1JwD1rmuwVWfYmcZeqeM
	1uEaN5sA7W43xm0LrDwpBiPohW5DwC4XHug3pSL5JL8pRSEP+fKiEO8ulJFA+bBy
X-Gm-Gg: AYBFou38emMRl6nqEIXK9RvLZlazBf4jdqhit7jc7IdNrPn4gGxT1vCwY5fmIcmkOUe
	HYFIGa2wC3d+7cob4mvRFnAONUpL6EVwkQ6La9OCwESZ98T2ZTIXLsHKhE83BPru8dvEn3vT6KO
	+rKTxKG3inSoRzRDA3qbrRmfDSHyZRHeba8lABhbGwAcxdsJJVE0MWXzZgjNx0K6BdWuWrmTehi
	Wp34jNfxtZlRtjTa9MXXa/Bg7jh4xdh/7gOFdswdTnqypsc5yrUdlIwugx8j8gwqDeXFSWDjOK5
	g9dEjzHw5Ny3YJQ8tLUBfD1ljm/eKkrIMAPKiN4ezCQaMtjiocneGCCQXUiVuBdDtwRQl9ieMFW
	olp1TGDAsN7MKSKYkYnRdX0070so5wjf8n6JTlNGzKH+/6xrOh0UVtA2Xs4nLP1z7X6DrfytJnC
	HKeLzayI7v/mIJMoMEjs0GNXcFdWmnut3yiHLFjpepsaM4c8yQU4TJjdC00mXgDND8/EpdmKPeB
	Eb2G3jyvLKJnKMHSOHSa1M2v9EN9EOcSBquuuOpzcZZIUlpgAitqaPsJwYN0d9BsQHpZWkXffHC
	eDnntYE=
X-Received: by 2002:a05:600c:3490:b0:4a0:1b14:e845 with SMTP id 5b1f17b1804b1-4a0274d1600mr66638925e9.2.1790974257827;
        Fri, 02 Oct 2026 13:50:57 -0700 (PDT)
Received: from DESKTOP-LR19VKC.localdomain (ipservice-092-208-106-062.092.208.pools.vodafone-ip.de. [92.208.106.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027740a2fsm131049875e9.13.2026.10.02.13.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:50:57 -0700 (PDT)
From: Savvas Etairidis <setairidis@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Jhonata Poma-Hansen <jhonata.poma@gmail.com>,
	Paul Barker <paul@pbarker.dev>,
	Savvas Etairidis <setairidis@gmail.com>
Subject: [PATCH v8] fetch/local: verify checksums for file:// urls
Date: Fri,  2 Oct 2026 22:50:54 +0200
Message-Id: <20261002205054.72441-1-setairidis@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKJXz6ecab40e-HXeYqSNNLcMK=Prrrgytq6qiqus6pCb3vPGQ@mail.gmail.com>
References: <CAKJXz6ecab40e-HXeYqSNNLcMK=Prrrgytq6qiqus6pCb3vPGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Oct 2026 20:51:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20293

[YOCTO #9993]

A checksum given in a file:// url (e.g. UNINATIVE_CHECKSUM when
UNINATIVE_URL points at a local file://) was never verified, because
Local disables the donestamp and so verify_checksum() was never called.
Enable the donestamp for file:// urls that carry a checksum.

Based on a patch by Jhonata Poma-Hansen.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Savvas Etairidis <setairidis@gmail.com>

---
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
 lib/bb/fetch/__init__.py | 16 ++++++++++++++++
 lib/bb/tests/fetch.py    | 30 ++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index eb3483a48..6401ce1b8 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -1087,6 +1087,10 @@ def rename_bad_checksum(ud, suffix, localpath=None):
     if ud.localpath is None:
         return
 
+    # A file:// url refers to the user's own file, leave it in place
+    if isinstance(ud.method, local.Local):
+        return
+
     if localpath is None:
         localpath = ud.localpath
 
@@ -1389,6 +1393,9 @@ class FetchData(object):
         for checksum_id in CHECKSUM_LIST:
             configure_checksum(checksum_id)
 
+        if isinstance(self.method, local.Local):
+            self.needdonestamp = self.checksum_expected()
+
         self.ignore_checksums = False
 
         if "localpath" in self.parm:
@@ -1416,6 +1423,15 @@ class FetchData(object):
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
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 9627b3b1b..a6a993dcd 100644
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
2.34.1


