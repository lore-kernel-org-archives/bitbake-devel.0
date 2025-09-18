Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A88ACAC59A
	for <webhook@archiver.kernel.org>; Thu, 18 Sep 2025 14:24:24 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web11.15753.1758205456018004046
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Sep 2025 07:24:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=0YwPybRp;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 688E6C003CB
	for <bitbake-devel@lists.openembedded.org>; Thu, 18 Sep 2025 14:23:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 088876062C
	for <bitbake-devel@lists.openembedded.org>; Thu, 18 Sep 2025 14:24:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC9DE102F16E2;
	Thu, 18 Sep 2025 16:24:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758205453; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=eDcJ3s6lqcIX8sgT12+fT8PlyPS7Ry7yTRs5AOsf9xY=;
	b=0YwPybRp02Acpr3zRg8ZInSoLQhecOb3m2WSYYXvVYl/K3pfn0sq5CLpMVk0RepXrb2sFu
	6HMjWVFUc68SEgJKiiDwLlcxRZcSjYW0SDwsIKw7nZ1YFYiRO3JbUSViC7mcMgy0U2I1u2
	5dzU5UFbElZxQOOd25diUF2lYg8VAikFYnHvKnRo05rfLJbhu0GeUvTtrMbgUiQ5E7cHgL
	BhIjbz5j2rBee//mufZAdBLn6JZht4VECd9gRWYpVZIIworZ8t+vUBX/xhWTlgfOiwgTxw
	4Fi5yerzbO1OCWaqZPWw9jSQ73Wtp8WVmmOa47DZG4O15AVmXRGXjZW10DwF9A==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 18 Sep 2025 16:23:48 +0200
Subject: [PATCH] tests/fetch: Update tests after bitbake tag removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-mathieu-selftest-fix-tag-removal-v1-1-fa4e4b97e40d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPMVzGgC/x2NSwqDQBAFryK9ToOfKJlcJbho4xtt8BOmRxHEu
 ztkWVBUnWQICqN3dlLArqbrkqB4ZPQdZRnA2iemMi/r3BUvniWOio0Nk4+wyF4PjjJwwLzuMnH
 VeVf1TVM7eVLK/AKS8l982uu6AWemrmByAAAA
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758205452; l=5926;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=fcKsqnqdeEpTSLF/JW9PjxYWoWEJz4CSZMeqtsAffOM=;
 b=lmuwUbUjPiXeAMtCFr4SSodTWMnNhozBvORzZoRF2FNXbucqiecNqejKriubUIhzurcfwGnkd
 i6T2/2mpoLVA+mOORMQbJxh680bOX0IpVmGU/V30+bJQKEDvR9EqvDa
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Sep 2025 14:24:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18062

Tags for bitbake 2.8.6 and 2.8.7 have been removed from the git: use
some other ones.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 lib/bb/tests/fetch.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index dcbe60783b69..f5e1f249c4ab 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3346,30 +3346,30 @@ class GitTagVerificationTests(FetcherTest):
     @skipIfNoNetwork()
     def test_tag_rev_match(self):
         # Test a url with rev= and tag= set works
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.7"], self.d)
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.10;protocol=https;rev=1452e74cc4ddfaadc6537a049877a66cec253c8d;tag=2.10.2"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
 
     def test_annotated_tag_rev_match(self):
         # Test a url with rev= and tag= set works
         # rev is the annotated tag revision in this case
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=6d363159e4b7dc566fc40d069b2615e61774a7d8;tag=2.8.7"], self.d)
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.10;protocol=https;rev=4e4d57c6dd768fe6033a2bdf9ef32bcef6634de9;tag=2.10.2"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
 
     @skipIfNoNetwork()
     def test_tag_rev_match2(self):
         # Test a url with SRCREV and tag= set works
-        self.d.setVar('SRCREV', 'aa0e540fc31a1c26839efd2c7785a751ce24ebfb')
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;tag=2.8.7"], self.d)
+        self.d.setVar('SRCREV', '1452e74cc4ddfaadc6537a049877a66cec253c8d')
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.10;protocol=https;tag=2.10.2"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
 
     @skipIfNoNetwork()
     def test_tag_rev_match3(self):
         # Test a url with SRCREV, rev= and tag= set works
-        self.d.setVar('SRCREV', 'aa0e540fc31a1c26839efd2c7785a751ce24ebfb')
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.7"], self.d)
+        self.d.setVar('SRCREV', '1452e74cc4ddfaadc6537a049877a66cec253c8d')
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.10;protocol=https;rev=1452e74cc4ddfaadc6537a049877a66cec253c8d;tag=2.10.2"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
 
@@ -3378,14 +3378,14 @@ class GitTagVerificationTests(FetcherTest):
         # Test a url with SRCREV and rev= mismatching errors
         self.d.setVar('SRCREV', 'bade540fc31a1c26839efd2c7785a751ce24ebfb')
         with self.assertRaises(bb.fetch2.FetchError):
-            fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.7"], self.d)
+            fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.10;protocol=https;rev=1452e74cc4ddfaadc6537a049877a66cec253c8d;tag=2.10.2"], self.d)
 
     @skipIfNoNetwork()
     def test_tag_rev_match5(self):
         # Test a url with SRCREV, rev= and tag= set works when using shallow clones
         self.d.setVar('BB_GIT_SHALLOW', '1')
-        self.d.setVar('SRCREV', 'aa0e540fc31a1c26839efd2c7785a751ce24ebfb')
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.7"], self.d)
+        self.d.setVar('SRCREV', '1452e74cc4ddfaadc6537a049877a66cec253c8d')
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.10;protocol=https;rev=1452e74cc4ddfaadc6537a049877a66cec253c8d;tag=2.10.2"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
 
@@ -3393,7 +3393,7 @@ class GitTagVerificationTests(FetcherTest):
     def test_tag_rev_match6(self):
         # Test a url with SRCREV, rev= and a mismatched tag= when using shallow clones
         self.d.setVar('BB_GIT_SHALLOW', '1')
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.6"], self.d)
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.10;protocol=https;rev=1452e74cc4ddfaadc6537a049877a66cec253c8d;tag=2.10.1"], self.d)
         fetcher.download()
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.unpack(self.unpackdir)
@@ -3401,8 +3401,8 @@ class GitTagVerificationTests(FetcherTest):
     @skipIfNoNetwork()
     def test_tag_rev_match7(self):
         # Test a url with SRCREV, rev= and a mismatched tag=
-        self.d.setVar('SRCREV', 'aa0e540fc31a1c26839efd2c7785a751ce24ebfb')
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.6"], self.d)
+        self.d.setVar('SRCREV', '1452e74cc4ddfaadc6537a049877a66cec253c8d')
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.10;protocol=https;rev=1452e74cc4ddfaadc6537a049877a66cec253c8d;tag=2.10.1"], self.d)
         fetcher.download()
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.unpack(self.unpackdir)

---
base-commit: c889d766575bd8dc664d07157961fd7b3869958b
change-id: 20250918-mathieu-selftest-fix-tag-removal-3bf93d6659a4

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


