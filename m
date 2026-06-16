Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ED2CD98DA
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 13:38:08 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.154421.1781617087562918143
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 06:38:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=h8r1yvCw;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C58D51A3957
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 13:38:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96D72601A9
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 13:38:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED42D106C9D9E;
	Tue, 16 Jun 2026 15:37:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781617070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vlHv49sbVlKYIjvWHt/zISoFRl0JdRU8D/Xh8rCASB4=;
	b=h8r1yvCw6P8dLGWH5RuMDTzxSMZ2XmD2+ETDZEs0YOEtXWFp3Wi9gUSYBdR/AQ5X/XsYyB
	qDydD/cYcSLN73STjrTUtTGEV7aRnioQt3D9God3qZ+8v5ysYrV3zhzBTnIGwD43ps2AH1
	SYCDH2spzXxxSqEV511tTqUgykRqf7F74U8SwsLQ+6um2CXisx7bkG5XGmwcXr0QXdGRMw
	Tb/0t7pfa5HKgJEH71iqJiYOZ+1mdC2osRUM33XY2g+LVXLyOxOR1NXLuNTg5R9iAQmNpu
	cHAMqY6LeazPvoaWDbKi7sxOpZFM6Fff+mKTPFjD2WasiYKDNLK2CYgNmrh3Lw==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Date: Tue, 16 Jun 2026 15:37:05 +0200
Subject: [PATCH 2/2] tests/fetch: restore and extend npm/npmsw test
 coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dev-tprrt-fix-npm-v1-2-6fde95bf0a8b@bootlin.com>
References: <20260616-dev-tprrt-fix-npm-v1-0-6fde95bf0a8b@bootlin.com>
In-Reply-To: <20260616-dev-tprrt-fix-npm-v1-0-6fde95bf0a8b@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Perrot <thomas.perrot@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 13:38:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19707

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

Add two new tests:
- test_npm_recipe_checksum: verifies that a sha512sum/sha256sum param
  in SRC_URI is forwarded to the proxy fetcher and the download
  succeeds when it matches.
- test_npm_bad_recipe_checksum_rejected: verifies that a wrong checksum
  in the recipe causes the fetch to fail.

[YOCTO #16105]

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 lib/bb/tests/fetch.py | 64 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d021ad786830..4c97ea253ba8 100644
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
@@ -2959,7 +2959,9 @@ class NPMTest(FetcherTest):
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
@@ -3063,8 +3065,8 @@ class NPMTest(FetcherTest):
         unpackdir = os.path.join(self.unpackdir, 'foo', 'bar')
         self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.json')))
 
+    @skipIfNoNpm()
     def test_npm_no_network_no_tarball(self):
-        return unittest.skip('npm disabled due to security issues')
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0']
         self.d.setVar('BB_NO_NETWORK', '1')
         fetcher = bb.fetch.Fetch(urls, self.d)
@@ -3089,7 +3091,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_alternate(self):
-        urls = ['npm://skimdb.npmjs.com;package=@savoirfairelinux/node-server-example;version=1.0.0']
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0']
         fetcher = bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
@@ -3097,14 +3099,10 @@ class NPMTest(FetcherTest):
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
@@ -3129,6 +3127,42 @@ class NPMTest(FetcherTest):
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
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_none(self):
@@ -3161,7 +3195,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3198,7 +3231,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_git(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/cookie': {
@@ -3212,7 +3244,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_dev(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3241,7 +3272,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_destsuffix(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3257,7 +3287,6 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'foo', 'bar', 'node_modules', 'array-flatten', 'package.json')))
 
     def test_npmsw_no_network_no_tarball(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {
@@ -3297,7 +3326,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_npm_reusability(self):
-        return unittest.skip('npm disabled due to security issues')
         # Fetch once with npmsw
         swfile = self.create_shrinkwrap_file({
             'packages': {
@@ -3320,7 +3348,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_bad_checksum(self):
-        return unittest.skip('npm disabled due to security issues')
         # Try to fetch with bad checksum
         swfile = self.create_shrinkwrap_file({
             'packages': {
@@ -3417,7 +3444,6 @@ class NPMTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_npmsw_bundled(self):
-        return unittest.skip('npm disabled due to security issues')
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/array-flatten': {

-- 
2.54.0


