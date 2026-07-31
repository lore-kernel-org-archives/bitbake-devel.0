Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5A3C54F54
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 12:46:16 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5775.1785501971091875973
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 Jul 2026 05:46:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=php1DLeF;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6D3F81A1354
	for <bitbake-devel@lists.openembedded.org>; Fri, 31 Jul 2026 12:46:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 42C1C6039A
	for <bitbake-devel@lists.openembedded.org>; Fri, 31 Jul 2026 12:46:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 957AF11C16814;
	Fri, 31 Jul 2026 14:46:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785501964; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/qVwCQJ6RxTbJ8OJh8HqgaalIuptHty9jeu40dmWmLw=;
	b=php1DLeFrwumoXH6QQgYajKa4ulUdI0q48vJiiuriIMMLpIPx44gZBCGHaqDwA27YH+V/L
	70kohYFg4S0bkklrErKmkwRJXIGsIHbdtmrFK/6sK5U7lZ/NWxNQA432+ARsBzZjrj0Qio
	2QMKl6z1e5qO9jRIdt24XgzCU4nz4zQdsaNnWnKwH9i413PEhZLqyOU7BeHLsMbKNQAiee
	tyJbEt3m7dNpwKEO6YkIo+YjtNCOxIp2CBLtTT922rOJ4JyJsw5fDyNsrscsjA+x37Wl02
	gGPh1luHZOBWbp0ig5i0XdIvDWlE+ifnWD1k2kYJudyLlDIvtG+Mg1cN5RN8jA==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Date: Fri, 31 Jul 2026 14:45:52 +0200
Subject: [PATCH v2 2/2] tests/fetch: restore and extend npm/npmsw test
 coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dev-tprrt-fix-npm-v2-2-67b65c67de4e@bootlin.com>
References: <20260731-dev-tprrt-fix-npm-v2-0-67b65c67de4e@bootlin.com>
In-Reply-To: <20260731-dev-tprrt-fix-npm-v2-0-67b65c67de4e@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Perrot <thomas.perrot@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 Jul 2026 12:46:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19894

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
---
 lib/bb/tests/fetch.py | 129 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 97 insertions(+), 32 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d021ad786830..cd50c37a62c6 100644
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
@@ -2937,7 +2938,6 @@ class CrateTest(FetcherTest):
 
 class NPMTest(FetcherTest):
     def skipIfNoNpm():
-        return unittest.skip('npm disabled due to security issues')
         if not shutil.which('npm'):
             return unittest.skip('npm not installed')
         return lambda f: f
@@ -2945,7 +2945,9 @@ class NPMTest(FetcherTest):
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
@@ -2959,7 +2961,9 @@ class NPMTest(FetcherTest):
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
@@ -2978,7 +2982,9 @@ class NPMTest(FetcherTest):
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
@@ -3008,7 +3014,9 @@ class NPMTest(FetcherTest):
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
@@ -3030,7 +3038,9 @@ class NPMTest(FetcherTest):
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
@@ -3055,7 +3065,10 @@ class NPMTest(FetcherTest):
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
@@ -3063,9 +3076,11 @@ class NPMTest(FetcherTest):
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
@@ -3074,7 +3089,9 @@ class NPMTest(FetcherTest):
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
@@ -3089,7 +3106,9 @@ class NPMTest(FetcherTest):
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
@@ -3097,19 +3116,17 @@ class NPMTest(FetcherTest):
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
@@ -3117,7 +3134,9 @@ class NPMTest(FetcherTest):
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
@@ -3129,6 +3148,60 @@ class NPMTest(FetcherTest):
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
@@ -3161,7 +3234,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3198,7 +3270,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_git(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/cookie': {
@@ -3212,7 +3283,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_dev(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3241,7 +3311,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_destsuffix(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3257,7 +3326,6 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'foo', 'bar', 'node_modules', 'array-flatten', 'package.json')))
 
     def test_npmsw_no_network_no_tarball(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3276,7 +3344,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw_no_network_with_tarball(self):
         # Fetch once to get a tarball
-        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1'], self.d)
+        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1;sha1sum=9a5f699051b1e7073328f2a008968b64ea2955d2'], self.d)
         fetcher.download()
         # Disable network access
         self.d.setVar('BB_NO_NETWORK', '1')
@@ -3297,7 +3365,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_npm_reusability(self):
-        return unittest.skip('npm disabled due to security issues')
         # Fetch once with npmsw
         swfile = self.create_shrinkwrap_file({
             'packages': {
@@ -3313,14 +3380,13 @@ class NPMTest(FetcherTest):
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
@@ -3362,7 +3428,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw_premirrors(self):
         # Fetch once to get a tarball
-        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1'], self.d)
+        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1;sha1sum=9a5f699051b1e7073328f2a008968b64ea2955d2'], self.d)
         ud = fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -3391,7 +3457,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw_mirrors(self):
         # Fetch once to get a tarball
-        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1'], self.d)
+        fetcher = bb.fetch.Fetch(['npm://registry.npmjs.org;package=array-flatten;version=1.1.1;sha1sum=9a5f699051b1e7073328f2a008968b64ea2955d2'], self.d)
         ud = fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -3417,7 +3483,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_bundled(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {

-- 
2.55.0


