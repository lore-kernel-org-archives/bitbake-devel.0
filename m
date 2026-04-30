Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DF9FF8875
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 15:03:28 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21983.1777559129400196686
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Apr 2026 07:25:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TzDIlHul;
 spf=pass (domain: gmail.com, ip: 209.85.218.50, mailfrom: jhonata.poma@gmail.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ba67b332bbaso146273066b.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Apr 2026 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777559127; x=1778163927; darn=lists.openembedded.org;
        h=to:message-id:content-transfer-encoding:mime-version:subject:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iHqgsuk6gXsw3e6cUGebPqeNvemqQKX7v6XTUtlHNA=;
        b=TzDIlHulooYSo60VC39+KdoqXr/1yRJFPxMYGeuGbQGbxiLunmZfOnoS58P3HSHOaD
         qT60JF24xN1XdLm15elFAdfm9ed7Zyxcs8nv2k7QKsJuNraz6hSXSKt8KTZXnOinJii0
         epVMgZF1FYnC40TZHr5M3V1C/7DveU6Gtqa94WV9KDDrPw4vRkAoIATxeRwnLEMAGgzZ
         Wxg6a2TphaCb0cT4JyTF4qEnHBTCeh5KPKs9oSRPL19TmoANoB7Cju7qRcXnHAhwV/OR
         jHScHZ6yEd3tHNgtaFzDMigAJ+FRP4FCTeMTLCpe94renCgfDwPrRMA7yo+9MX0Sw84Z
         VI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777559127; x=1778163927;
        h=to:message-id:content-transfer-encoding:mime-version:subject:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iHqgsuk6gXsw3e6cUGebPqeNvemqQKX7v6XTUtlHNA=;
        b=BqitfcnsfZDdIrvJjhl5GSYcct75LHrGipL49/GRKHCoIFEBOh2Lh9fTWFe3VLbDa6
         oiI5hVUIkELLFnBfhNjiTeDCPNEtlR9mHR1ufdcB1dkBDrALYHR2jIHTVk4/fm/umRFe
         nYIYWAGqNx3lNSHyNUSLLhvKFRvEyQDqtlnY5H+3hs74SRTfo+SVorOxteOsVYc7KJda
         5OuyhlsSK8zqSevVZkMAceYsERsSkIhrraNoziHA7/J/B5fkWVtwOfECNp9mwqAg+smH
         7qFLwErLl/Vc6SGInOYhdF0jJuk9EsGNI3RJj2kiS29ylyAs0Ogy8vLT9rnOmkIFlOvB
         V2LQ==
X-Gm-Message-State: AOJu0Yz1qGRHuyWQSKOMsAv6JXMQb+Pw2wrumkbx+ruNq9d7OS/zZKTv
	LQOoX4JAFx+eU8EP3S7SLjwnkDTrad/Z8RBFWydMBy9IO8UzjHgUyk9Tj1gRcXlhzY4=
X-Gm-Gg: AeBDiesC14pqvxcWghiDKGHZmuCbApZsFC6TrdOXany3r8iI0P7OtW3xIkRo7/bVPag
	fdPY26+oIAwqev3DUbLnz1hso2A90rZziHhp6YC4kXShpCMbkAwQY+FIZgRxzBJWx9vlW9dTWdn
	2/IXc7cACW5Pw4GWag6kAi8lq1kTk7Nvk6cRNZDD5/f2TvwCZGcVsuREX/RV8wDSeLpKNtAV1DW
	iKSyjtq8Jfz6BWEyy1vDl8DwmK317MFuOoxqKP1uoE6BYR7tDbp2bkKOkZLvrWzKcSR1V2lQZjF
	sGBFvwL0XycleAn79XVCLwgS6TQ6KtdpKEmpzTmSvRtLIzk/QCMq8IW0M0knYmCiFmbgThHZmVf
	dl9PwvgiUfSCs2o5hCjdh/bZEc5FJzTlQj3YaDzUKXQmFh07vfHIT9ENKjMcIxFJycsCooIeJ7i
	Sq9PL9Nc1OjPeeGck0XA3awHeibJK0ez48Ur9aFREpHXGatjAMIYQ7SiZGnEqqaNHNqNJNuEfl2
	UKEzHYa4mxG6hRynvrm7ynfww==
X-Received: by 2002:a17:907:5cb:b0:ba7:fbfb:4caf with SMTP id a640c23a62f3a-bbad6315f0bmr228265766b.43.1777559126658;
        Thu, 30 Apr 2026 07:25:26 -0700 (PDT)
Received: from [127.0.0.2] ([89.150.155.129])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88a4d99esm258a12.31.2026.04.30.07.25.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 07:25:26 -0700 (PDT)
From: "Jhonata Poma-Hansen" <Jhonata.poma@gmail.com>
Date: Thu, 30 Apr 2026 16:25:24 +0200
Subject: [PATCH] fetch2/local: verify checksums for file:// urls
MIME-Version: 1.0
Message-Id: <20260430-b4-yocto-9993-v1-1-a54d842cd0fd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFNm82kC/x3MQQ5AMBBA0avIrE1CCRlXEYuaDmbTSitCxN01l
 m/x/wNJokqCoXggyqlJg8+oywJ4s34VVJcNpjJd1RrCucU78BGQiBpk6xzxLK5ngdzsURa9/t8
 4ve8HNXoH818AAAA=
X-Change-ID: 20260429-b4-yocto-9993-cadd9cbed7ce
To: bitbake-devel@lists.openembedded.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13090;
 i=jhonata.poma@gmail.com; h=from:subject:message-id;
 bh=PpToDg+0lxzWeX8qivEnF/CO2wYIPfxl44GJk+rRSK0=;
 b=owGbwMvMwCX21S6Y7aK9oS7jabUkhszPaaGbrsdOurFsr1jxrspJF9rn8Bzjr5Tuk9055/gfj
 aS06LJJHaUsDGJcDLJiiiw+Zx/3cCt+3PH/4Y7LMHNYmUCGMHBxCsBE7nQyMlzm1Qs9cbbzhAKT
 tmj29+k/zxSsbSkL82MrEazfd7xaMJWRYeL5dQEix8P2B3HdyVwzSeiPzLccrxnPpgVnKjXHxB+
 u5gAA
X-Developer-Key: i=jhonata.poma@gmail.com; a=openpgp;
 fpr=4CCDE38C0B21F1B8FFE1B8D3F53E5306D13F312D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Apr 2026 15:03:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19423

Local.urldata_init unconditionally cleared ud.needdonestamp, which
short-circuited the donestamp + verify_checksum cycle for every
file:// url. As a result, a checksum supplied as a url parameter
(for instance UNINATIVE_CHECKSUM expanded into the uninative
tarball's file:// url) was never compared against the file's
actual contents - the fetcher silently used whatever bytes were
at the path.

Keep needdonestamp at the FetchData default (True) when the url
carries any of the known checksum parameters, so the standard
verify_checksum flow runs and a mismatch raises ChecksumError just
like it does for http:// and friends. The check uses CHECKSUM_LIST
and handles both the bare ;<algo>sum= form and the named
;name=foo;foo.<algo>sum= form that recipes (and UNINATIVE_CHECKSUM)
actually use. When no checksum is supplied (the common case for
file:// recipe patches) needdonestamp stays False and behavior is
unchanged - no .done / .lock files appear in DL_DIR for those urls.

For checksummed file:// urls, the donestamp + lockfile do land in
DL_DIR (keyed by basename, alongside the existing http(s) state
for the same basename); this is intentional and matches how every
other fetcher tracks verified content.

An earlier fix (b8b14d975a25 "fetch2: Ensure we don't have file
downloads overwriting each other", 2017) added a short-circuit at
the top of verify_donestamp() so that when origud is a file:// url
with needdonestamp=False, the function returns True early. That
short-circuit was protecting the SSTATE_MIRRORS case where a
file:// url is mapped to an http:// mirror and the http path would
otherwise race against the file:// origud. It still does the
right thing under this change: the only file:// origud whose
needdonestamp now flips to True is one that carries an explicit
checksum parameter, and in that case we actively want the mirror
to run verify_donestamp(), not bypass it. The unchecksummed
file:// origud case (the original SSTATE_MIRRORS scenario) keeps
needdonestamp=False and the 2017 short-circuit fires unchanged.

Two related changes in fetch2 are worth pointing at:

* commit 6424f4b7e9c1 ("fetch2: Ensure mirror tarballs don't enforce
  checksum", 2022) marks SSTATE_MIRRORS targets with
  newud.ignore_checksums = True. Its commit message states "local
  file fetches now validate checksums" - this fix is what finally
  makes that statement true. The ignore_checksums flag also acts as
  the safety hatch that prevents flipping needdonestamp on for
  checksummed file:// urls from propagating verification onto
  mirror-of-git-repo tarballs (whose checksums by design do not
  match).
* commit 4b8de2e7d126 ("wget: Avoid bad checksum race issues",
  2022) established the don't-mutate-on-mismatch doctrine for
  downloaded artifacts via the localpath= and fatal_nochecksum=
  parameters. The rename_bad_checksum() early-return below applies
  the same doctrine to a fetcher whose 'localpath' is the user's
  source tree.

A checksum mismatch on a file:// url must not mutate the user's
source tree the way it does for downloaded artifacts in DL_DIR.
The standard error path renames <localpath> to
<localpath>_bad-checksum_<sha> via rename_bad_checksum(), which
for file:// would rename a recipe-shipped patch or an absolute
path the user had supplied. Skip that rename inside
rename_bad_checksum() when ud.type == 'file' so all four call
sites stay consistent and a ChecksumError surfaces cleanly without
on-disk side effects.

Add unit tests in FetcherLocalTest covering: the no-checksum hot
path keeps needdonestamp=False (no regression for recipe patches);
matching and mismatching sha256 and md5 checksums; the named
;name=foo;foo.sha256sum= form; and that a directory url with a
checksum is silently ignored (supports_checksum() is False for
directories). The mismatch tests assert that the source file is
not renamed.

Link: https://bugzilla.yoctoproject.org/show_bug.cgi?id=9993
[YOCTO #9993]

Signed-off-by: Jhonata Poma-Hansen <jhonata.poma@gmail.com>
---
 lib/bb/fetch2/__init__.py |   8 ++++
 lib/bb/fetch2/local.py    |  19 ++++++++-
 lib/bb/tests/fetch.py     | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 52d5556d..35874e25 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1075,6 +1075,14 @@ def rename_bad_checksum(ud, suffix):
     if ud.localpath is None:
         return
 
+    # For file:// URLs the localpath points at the user's source tree
+    # (e.g. recipe-shipped files under FILESPATH or an absolute path the
+    # user passed in). Renaming those out from under the user is
+    # destructive and surprising; surface the ChecksumError without
+    # mutating their files.
+    if ud.type == 'file':
+        return
+
     new_localpath = "%s_bad-checksum_%s" % (ud.localpath, suffix)
     bb.warn("Renaming %s to %s" % (ud.localpath, new_localpath))
     if not bb.utils.movefile(ud.localpath, new_localpath):
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index fda56a56..2abcc5eb 100644
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
@@ -31,7 +31,22 @@ class Local(FetchMethod):
         # We don't set localfile as for this fetcher the file is already local!
         ud.basename = os.path.basename(ud.path)
         ud.basepath = ud.path
-        ud.needdonestamp = False
+        # Without a donestamp the verify_checksum path is bypassed entirely
+        # for file:// urls, so an explicit checksum on the url (for instance
+        # UNINATIVE_CHECKSUM expanded into the uninative tarball file:// url)
+        # is never compared against the file's actual contents. Keep
+        # needdonestamp at the FetchData default (True) when any of the
+        # known checksum parameters is present, so the standard
+        # donestamp + verify_checksum cycle runs and a mismatch raises
+        # ChecksumError. When no checksum is supplied (the common case for
+        # recipe patches under file://) needdonestamp stays False and
+        # behavior is unchanged.
+        name = ud.parm.get("name")
+        ud.needdonestamp = any(
+            (name and "%s.%ssum" % (name, a) in ud.parm)
+            or "%ssum" % a in ud.parm
+            for a in CHECKSUM_LIST
+        )
         if "*" in ud.path:
             raise bb.fetch2.ParameterError("file:// urls using globbing are no longer supported. Please place the files in a directory and reference that instead.", ud.url)
         return
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 077f741e..3347c60d 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -813,6 +813,110 @@ class FetcherLocalTest(FetcherTest):
         tree = self.fetchUnpack(['file://archive.tar.bz2;subdir=bar;striplevel=1'])
         self.assertEqual(tree, ['bar/c', 'bar/d', 'bar/subdir/e'])
 
+    def test_local_no_checksum_no_donestamp(self):
+        # The common case: file:// recipe patches without a checksum
+        # parameter must keep the historical "no donestamp tracking"
+        # behavior so this fix does not regress the hot path. After
+        # download(), no .done / .lock entries must appear in DL_DIR
+        # for the bare file:// url.
+        with open(os.path.join(self.localsrcdir, 'plain'), 'wb') as f:
+            f.write(b"plain\n")
+        fetcher = bb.fetch.Fetch(['file://plain'], self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
+        self.assertFalse(ud.needdonestamp)
+        # When needdonestamp is False, FetchData leaves ud.donestamp
+        # unset (None); we assert that no .done / .lock entries are
+        # written to DL_DIR for the bare file:// url after download.
+        fetcher.download()
+        for entry in os.listdir(self.dldir):
+            self.assertFalse(entry.startswith('plain.done'))
+            self.assertFalse(entry.startswith('plain.lock'))
+
+    def test_local_checksum_match(self):
+        # A correct sha256 must drive the verify_checksum cycle to
+        # completion: download() returns without raising AND the
+        # donestamp lands in DL_DIR. The donestamp is the on-disk
+        # evidence that update_stamp() ran after verify_checksum()
+        # passed - without the fix, needdonestamp=False short-circuits
+        # update_stamp() and no donestamp is written even on "match".
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
+        content = b"file:// checksum mismatch test\n"
+        srcpath = os.path.join(self.localsrcdir, 'sumfile')
+        with open(srcpath, 'wb') as f:
+            f.write(content)
+        bad = "0" * 64
+        fetcher = bb.fetch.Fetch(['file://sumfile;sha256sum=' + bad], self.d)
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
+        # The user's source tree must not be mutated. rename_bad_checksum
+        # would otherwise leave a <path>_bad-checksum_<sha> sibling and
+        # remove the original.
+        self.assertTrue(os.path.exists(srcpath))
+        with open(srcpath, 'rb') as f:
+            self.assertEqual(f.read(), content)
+        for entry in os.listdir(self.localsrcdir):
+            self.assertNotIn('_bad-checksum_', entry)
+
+    def test_local_checksum_mismatch_md5(self):
+        # Coverage for an algorithm other than sha256 so a regression
+        # that special-cased sha256 detection does not slip through.
+        # Mirror the sha256 mismatch assertions: source file present,
+        # contents unchanged, no _bad-checksum_ sibling left behind.
+        content = b"file:// md5 mismatch test\n"
+        srcpath = os.path.join(self.localsrcdir, 'sumfile_md5')
+        with open(srcpath, 'wb') as f:
+            f.write(content)
+        bad = "0" * 32
+        fetcher = bb.fetch.Fetch(['file://sumfile_md5;md5sum=' + bad], self.d)
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
+        self.assertTrue(os.path.exists(srcpath))
+        with open(srcpath, 'rb') as f:
+            self.assertEqual(f.read(), content)
+        for entry in os.listdir(self.localsrcdir):
+            self.assertNotIn('_bad-checksum_', entry)
+
+    def test_local_checksum_named(self):
+        # UNINATIVE_CHECKSUM (the original reproducer for this bug) and
+        # several other recipe-driven file:// urls use the name= prefix
+        # form: foo.sha256sum= rather than bare sha256sum=. Confirm the
+        # named form flips needdonestamp AND that the verify cycle runs
+        # (donestamp on disk after download).
+        import hashlib
+        content = b"file:// named checksum test\n"
+        with open(os.path.join(self.localsrcdir, 'sumfile_named'), 'wb') as f:
+            f.write(content)
+        good = hashlib.sha256(content).hexdigest()
+        fetcher = bb.fetch.Fetch(
+            ['file://sumfile_named;name=blob;blob.sha256sum=' + good], self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
+        self.assertTrue(ud.needdonestamp)
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.donestamp))
+
+    def test_local_checksum_directory_ignored(self):
+        # Local supports directory urls; supports_checksum returns False
+        # for directories. A checksum parm on a directory url should
+        # therefore be a no-op rather than a hard error: verify_checksum
+        # short-circuits on supports_checksum() and no ChecksumError is
+        # raised even when the checksum value is bogus.
+        bad = "0" * 64
+        fetcher = bb.fetch.Fetch(['file://dir;sha256sum=' + bad], self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
+        self.assertFalse(ud.method.supports_checksum(ud))
+        fetcher.download()
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


