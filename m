Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5940EC61DC2
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 13:03:15 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20923.1787662989079252143
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 06:03:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=N87RpkVs;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5A60D4E413AA
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 13:03:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3046B604C4;
	Tue, 25 Aug 2026 13:03:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B0AF11C794EE;
	Tue, 25 Aug 2026 15:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787662986; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1krKKuNdqoo6KuQLvHk7AVQB99rZ2bB0aJz9Di2QwHg=;
	b=N87RpkVs0+fEAQEwSCNaUN4GKWELMv9LnY7qX6eLzlnNOricM1U8jgXFPrcZ5HvqWZtAR8
	5g4Ubks+qwrRzgId4e7RIdrqyKNJGjEbVd8WqgsDgeDHQaBEN4kkwt3N7YcNFVNf/c7lcP
	DhVRNc3M7bMuVVsuvg9dR30x0DT2EuvoT/QOg4Pqb78fIGqFMMCZR2xi1QeHYjEl4v4Pfd
	GbXwdaP+f/On+wHjdG3ojWOPRUFzvOMQKpBGgx7VRocDeY6eP9++Wl6ZDaA7zfteTS5sx5
	sZrpQqitSVkutOIDm+k6t+1/vVhtjWLMDNiBcLNp8z8q3VR9KZtJ5vTI5nDpEA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 25 Aug 2026 15:02:58 +0200
Subject: [2.18][PATCH 2/2] tests/fetch: restore and extend npm/npmsw test
 coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-enable-npmsw-fetcher-wrynose-v1-2-425c8cc1e111@bootlin.com>
References: <20260825-enable-npmsw-fetcher-wrynose-v1-0-425c8cc1e111@bootlin.com>
In-Reply-To: <20260825-enable-npmsw-fetcher-wrynose-v1-0-425c8cc1e111@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Perrot <thomas.perrot@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18782;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=2fuVREZu+Pa/9N7ciW+O2evfBO7d1+1+wltAOfzLfvo=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqjZKHttKZMLZ7LUkOiJN/2gaq66ZerTQOv/iNX
 foprRef2uOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCao2ShwAKCRDRgEFAKaOo
 NmT4EACYgJwTGbUTs+fwG+Bon4xRyytjYhqLFFbkPQveqx322Rt+K4ZkMXSPEoI1eh2A9BWUDBl
 6NL7INLT/c1vrLS0VEFqzHqo5+NRndKmclzIxMCCo7CvtohsRqoPcFzXDAQNGdveo1lagIQwDt9
 iiTtG4091Z0+6j3JKPk1S/7BqqJurlal/DVAdnX0SH8FgPce2Njls/Vsy6QWofaP+CdcVn9sF7o
 wvC4L/UiDoE0ptlVhA99JJkUMQfjzt1BjT9TFSMnQa6h8XdZa4O+jx0qnBuDBpXKlM8wGCSBABO
 uWOvAkde7MBu+0DCMYlZ5gwNccLjE4gsSzEl+BBlcFfVvcpK363wxU1dKjvaCKxHamMjgzl4Tce
 Oyxim8NJ60tFoOyP3ufi0GRL8sVsbysL1UIeRuFBnU4h+17upU2ZylHLzSz1lj5fUrzEtbn16wy
 Rdqa9POZXSVWkGeNsuhcfj+Z2Cpi+7QgZNdHdwaxyfwYwOsLijDKzxGIbOmoyoZf7r1EFE/wdiz
 23j7CePTN+8s8T6+oIjxqBvRMCyfZjLzviOWFpXmfws+WLIBTlWOqMr0acnD6N7WwoYvZ5t33GE
 aT0cv4+4XAB9esKR2AIPRq/zqgqtGwrTmJ0l3ZQrEyFEGWgE2t4giLnlIbUDQ74ronBUjjb3ZLP
 xlFqSAPUtB16FHQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 13:03:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20035

From: Thomas Perrot <thomas.perrot@bootlin.com>

Re-enable all NPMTest cases that were disabled by returning an
unconditional unittest.skip():
- Fix skipIfNoNpm() dead code: the shutil.which check was unreachable
  after the early return.
- Remove the return-skip guard from all test_npmsw_* tests; the npmsw
  fetcher is now re-enabled.
- Restore test_npm_no_network_no_tarball with a proper @skipIfNoNpm()
  decorator.

Adapt tests for the new npm fetcher behaviour:
- Replace test_npm_version_latest (which asserted success) with
  test_npm_version_latest_rejected, which asserts ParameterError since
  version=latest is no longer accepted.
- Add a checksum to every direct npm:// fetch in this file (test_npm,
  test_npm_premirrors, test_npm_premirrors_with_specified_filename,
  test_npm_mirrors, test_npm_destsuffix_downloadfilename,
  test_npm_no_network_no_tarball, test_npm_no_network_with_tarball,
  test_npm_registry_alternate, test_npm_registry_invalid,
  test_npm_package_invalid, and the array-flatten fetches used by the
  npmsw download-cache-reuse tests), since urldata_init now rejects
  SRC_URI without one.

Add new tests:
- test_npm_recipe_checksum: verifies that a sha512sum/sha256sum param
  in SRC_URI is forwarded to the proxy fetcher and the download
  succeeds when it matches.
- test_npm_bad_recipe_checksum_rejected: verifies that a wrong checksum
  in the recipe causes the fetch to fail.
- test_npm_no_checksum_rejected: verifies that a missing checksum is
  rejected regardless of BB_STRICT_CHECKSUM (unset, '0', '1', or
  'ignore'), confirming the requirement is unconditional rather than
  the usual opt-in strict-checksum behaviour.

[YOCTO #16105]

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f7608f3195af9abb405af9be95286e2267221331)
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/tests/fetch.py | 129 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 97 insertions(+), 32 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c071401e6ca..c3f36fc6b96 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -18,6 +18,7 @@ import collections
 import os
 import signal
 import subprocess
+import json
 import tarfile
 import threading
 from bb.fetch2 import URI
@@ -2951,7 +2952,6 @@ class CrateTest(FetcherTest):
 
 class NPMTest(FetcherTest):
     def skipIfNoNpm():
-        return unittest.skip('npm disabled due to security issues')
         if not shutil.which('npm'):
             return unittest.skip('npm not installed')
         return lambda f: f
@@ -2959,7 +2959,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm(self):
-        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0']
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+                ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+                '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223']
         fetcher = bb.fetch.Fetch(urls, self.d)
         ud = fetcher.ud[fetcher.urls[0]]
         fetcher.download()
@@ -2973,7 +2975,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_bad_checksum(self):
-        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0']
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+                ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+                '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223']
         # Fetch once to get a tarball
         fetcher = bb.fetch.Fetch(urls, self.d)
         ud = fetcher.ud[fetcher.urls[0]]
@@ -2992,7 +2996,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_premirrors(self):
-        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0']
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+                ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+                '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223']
         # Fetch once to get a tarball
         fetcher = bb.fetch.Fetch(urls, self.d)
         ud = fetcher.ud[fetcher.urls[0]]
@@ -3022,7 +3028,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_premirrors_with_specified_filename(self):
-        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0']
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+                ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+                '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223']
         # Fetch once to get a tarball
         fetcher = bb.fetch.Fetch(urls, self.d)
         ud = fetcher.ud[fetcher.urls[0]]
@@ -3044,7 +3052,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npm_mirrors(self):
         # Fetch once to get a tarball
-        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0']
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+                ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+                '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223']
         fetcher = bb.fetch.Fetch(urls, self.d)
         ud = fetcher.ud[fetcher.urls[0]]
         fetcher.download()
@@ -3069,7 +3079,10 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_destsuffix_downloadfilename(self):
-        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0;destsuffix=foo/bar;downloadfilename=foo-bar.tgz']
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+                ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+                '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223'
+                ';destsuffix=foo/bar;downloadfilename=foo-bar.tgz']
         fetcher = bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'foo-bar.tgz')))
@@ -3077,9 +3090,11 @@ class NPMTest(FetcherTest):
         unpackdir = os.path.join(self.unpackdir, 'foo', 'bar')
         self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.json')))
 
+    @skipIfNoNpm()
     def test_npm_no_network_no_tarball(self):
-        return unittest.skip('npm disabled due to security issues')
-        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0']
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+                ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+                '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223']
         self.d.setVar('BB_NO_NETWORK', '1')
         fetcher = bb.fetch.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
@@ -3088,7 +3103,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_no_network_with_tarball(self):
-        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0']
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+                ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+                '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223']
         # Fetch once to get a tarball
         fetcher = bb.fetch.Fetch(urls, self.d)
         fetcher.download()
@@ -3103,7 +3120,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_alternate(self):
-        urls = ['npm://skimdb.npmjs.com;package=@savoirfairelinux/node-server-example;version=1.0.0']
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+                ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+                '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223']
         fetcher = bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
@@ -3111,19 +3130,17 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.json')))
 
     @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npm_version_latest(self):
+    def test_npm_version_latest_rejected(self):
         url = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=latest']
-        fetcher = bb.fetch.Fetch(url, self.d)
-        fetcher.download()
-        fetcher.unpack(self.unpackdir)
-        unpackdir = os.path.join(self.unpackdir, 'npm')
-        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.json')))
+        with self.assertRaises(bb.fetch2.ParameterError):
+            bb.fetch.Fetch(url, self.d)
 
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_invalid(self):
-        urls = ['npm://registry.invalid.org;package=@savoirfairelinux/node-server-example;version=1.0.0']
+        urls = ['npm://registry.invalid.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+                ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+                '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223']
         fetcher = bb.fetch.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.download()
@@ -3131,7 +3148,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_package_invalid(self):
-        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/invalid;version=1.0.0']
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/invalid;version=1.0.0'
+                ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+                '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223']
         fetcher = bb.fetch.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.download()
@@ -3143,6 +3162,60 @@ class NPMTest(FetcherTest):
         with self.assertRaises(bb.fetch2.ParameterError):
             fetcher = bb.fetch.Fetch(urls, self.d)
 
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_recipe_checksum(self):
+        """A sha512sum param in SRC_URI is forwarded to the proxy and verified."""
+        import subprocess
+        from bb.fetch2.npm import npm_integrity
+        result = subprocess.run(
+            ['npm', 'view', '--json', '@savoirfairelinux/node-server-example@1.0.0'],
+            capture_output=True, text=True)
+        if result.returncode != 0:
+            self.skipTest('npm view failed: %s' % result.stderr.strip())
+        try:
+            view = json.loads(result.stdout)
+        except json.JSONDecodeError:
+            self.skipTest('npm view returned invalid JSON')
+        integrity = view.get('dist', {}).get('integrity')
+        if not integrity:
+            self.skipTest('npm view response missing dist.integrity')
+        checksum_name, hexsum = npm_integrity(integrity)
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example'
+                ';version=1.0.0;%s=%s' % (checksum_name, hexsum)]
+        fetcher = bb.fetch.Fetch(urls, self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_bad_recipe_checksum_rejected(self):
+        """A wrong sha512sum param in SRC_URI causes the fetch to fail."""
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example'
+                ';version=1.0.0;sha512sum=deadbeef00']
+        fetcher = bb.fetch.Fetch(urls, self.d)
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
+
+    @skipIfNoNpm()
+    def test_npm_no_checksum_rejected(self):
+        """A missing checksum in SRC_URI is rejected regardless of BB_STRICT_CHECKSUM.
+
+        Unlike wget and other fetchers, npm must not fall back to an
+        unverified download: the registry cannot be trusted to supply its
+        own tamper detection, so the checksum requirement is not gated by
+        the usual opt-in strict-checksum setting.
+        """
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0']
+        for strict in (None, '0', '1', 'ignore'):
+            if strict is None:
+                self.d.delVar('BB_STRICT_CHECKSUM')
+            else:
+                self.d.setVar('BB_STRICT_CHECKSUM', strict)
+            with self.assertRaises(bb.fetch2.MissingParameterError):
+                bb.fetch.Fetch(urls, self.d)
+
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_none(self):
@@ -3175,7 +3248,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3212,7 +3284,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_git(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/cookie': {
@@ -3226,7 +3297,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_dev(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3255,7 +3325,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_destsuffix(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3271,7 +3340,6 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'foo', 'bar', 'node_modules', 'array-flatten', 'package.json')))
 
     def test_npmsw_no_network_no_tarball(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3290,7 +3358,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw_no_network_with_tarball(self):
         # Fetch once to get a tarball
-        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1'], self.d)
+        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1;sha1sum=9a5f699051b1e7073328f2a008968b64ea2955d2'], self.d)
         fetcher.download()
         # Disable network access
         self.d.setVar('BB_NO_NETWORK', '1')
@@ -3311,7 +3379,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_npm_reusability(self):
-        return unittest.skip('npm disabled due to security issues')
         # Fetch once with npmsw
         swfile = self.create_shrinkwrap_file({
             'packages': {
@@ -3327,14 +3394,13 @@ class NPMTest(FetcherTest):
         # Disable network access
         self.d.setVar('BB_NO_NETWORK', '1')
         # Fetch again with npm
-        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1'], self.d)
+        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1;sha1sum=9a5f699051b1e7073328f2a008968b64ea2955d2'], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'npm', 'package.json')))
 
     @skipIfNoNetwork()
     def test_npmsw_bad_checksum(self):
-        return unittest.skip('npm disabled due to security issues')
         # Try to fetch with bad checksum
         swfile = self.create_shrinkwrap_file({
             'packages': {
@@ -3376,7 +3442,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw_premirrors(self):
         # Fetch once to get a tarball
-        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1'], self.d)
+        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1;sha1sum=9a5f699051b1e7073328f2a008968b64ea2955d2'], self.d)
         ud = fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -3405,7 +3471,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw_mirrors(self):
         # Fetch once to get a tarball
-        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1'], self.d)
+        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1;sha1sum=9a5f699051b1e7073328f2a008968b64ea2955d2'], self.d)
         ud = fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -3431,7 +3497,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_bundled(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {

-- 
2.55.0


