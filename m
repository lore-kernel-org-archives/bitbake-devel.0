Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBFBCAC592
	for <webhook@archiver.kernel.org>; Fri, 19 Sep 2025 06:51:25 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.10081.1758264683072646469
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Sep 2025 23:51:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=maUO//1R;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E31C74E40D3B
	for <bitbake-devel@lists.openembedded.org>; Fri, 19 Sep 2025 06:51:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9CA2606A8
	for <bitbake-devel@lists.openembedded.org>; Fri, 19 Sep 2025 06:51:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D09D9102F1B8F;
	Fri, 19 Sep 2025 08:51:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758264680; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=xr49WPWZa1DEDWQ5fM3qcHowLmxtdjuJ81r9o6UCq0E=;
	b=maUO//1RgKCrH2R9azYUeH+a98wZ4DTN239Jh6f2bYR1oH+yj65ubFB50udP/rZklra8P6
	PBzkGTNbWebVlGHo30bZzgcPn2kD57aPrRZ5MJy8EmdhqJ1u5hdHwwxvoK3I7Yi7Am9ygj
	8YftQ06rqm8MFIi9sLh58EBa9Hq65/IfckqZVQlrWcgt8jt+GjXAWcITRzfuZ+B72MdzY8
	OtBTSQr+2G8igue66QguIca0QowsFJ4XWShedGnuYOUu05eokk3aTXFtg2Sofpncji0BSV
	Y8TWi+eHI76F5pOJP7cBsJYAKEbARXu5ijGBDih7X6SthgX6g765DXh+IVta0g==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 19 Sep 2025 08:50:59 +0200
Subject: [PATCH v2] tests/fetch: Update tests after bitbake tag removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-mathieu-selftest-fix-tag-removal-v2-1-91370eb228da@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAFL9zGgC/5WNQQ6CMBBFr0Jm7RgKBa0r72FYFJjCJEBNWxsN6
 d2t3MDl+/l5bwdPjsnDrdjBUWTPdstQnQoYZr1NhDxmhqqsmlKJK646zEwv9LSYQD6g4TcGPaG
 j1Ua9YN0bVY9t2ygtIWuejvLlSDy6zDP7YN3nKEbxW/+QR4ECjZYke3UhWY733tqw8HYe7ApdS
 ukLody1ydIAAAA=
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758264677; l=6114;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=1hGIvpeT3QEWLx3wBMGsRz1qw5IyjFsk462MBPOAXyM=;
 b=4TbaaLDHUHBPQgy11XFzIX/mVsE6zuDwqj43bIsiHoAyXb+AuLZHBzhCx+TDzNTTqXBCzaH68
 foBFPz8pdinBONIzRT6XfBqU1fGHj+0P/UrvOCp41Eek52Cm2u8vn7K
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Sep 2025 06:51:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18063

Tags for bitbake 2.8.6 and 2.8.7 have been removed from the git: use
some other ones.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v2:
- Use some other tags, as 2.10.* will also be removed.
- Link to v1: https://lore.kernel.org/r/20250918-mathieu-selftest-fix-tag-removal-v1-1-fa4e4b97e40d@bootlin.com
---
 lib/bb/tests/fetch.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index dcbe60783b69..6de0b5334edd 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3346,30 +3346,30 @@ class GitTagVerificationTests(FetcherTest):
     @skipIfNoNetwork()
     def test_tag_rev_match(self):
         # Test a url with rev= and tag= set works
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.7"], self.d)
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.12;protocol=https;rev=5b4e20377eea8d428edf1aeb2187c18f82ca6757;tag=2.12.0"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
 
     def test_annotated_tag_rev_match(self):
         # Test a url with rev= and tag= set works
         # rev is the annotated tag revision in this case
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=6d363159e4b7dc566fc40d069b2615e61774a7d8;tag=2.8.7"], self.d)
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.12;protocol=https;rev=fa30183549bd09f33fd4eebf56771ca5393526a6;tag=2.12.0"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
 
     @skipIfNoNetwork()
     def test_tag_rev_match2(self):
         # Test a url with SRCREV and tag= set works
-        self.d.setVar('SRCREV', 'aa0e540fc31a1c26839efd2c7785a751ce24ebfb')
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;tag=2.8.7"], self.d)
+        self.d.setVar('SRCREV', '5b4e20377eea8d428edf1aeb2187c18f82ca6757')
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.12;protocol=https;tag=2.12.0"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
 
     @skipIfNoNetwork()
     def test_tag_rev_match3(self):
         # Test a url with SRCREV, rev= and tag= set works
-        self.d.setVar('SRCREV', 'aa0e540fc31a1c26839efd2c7785a751ce24ebfb')
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.7"], self.d)
+        self.d.setVar('SRCREV', '5b4e20377eea8d428edf1aeb2187c18f82ca6757')
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.12;protocol=https;rev=5b4e20377eea8d428edf1aeb2187c18f82ca6757;tag=2.12.0"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
 
@@ -3378,14 +3378,14 @@ class GitTagVerificationTests(FetcherTest):
         # Test a url with SRCREV and rev= mismatching errors
         self.d.setVar('SRCREV', 'bade540fc31a1c26839efd2c7785a751ce24ebfb')
         with self.assertRaises(bb.fetch2.FetchError):
-            fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.7"], self.d)
+            fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.12;protocol=https;rev=5b4e20377eea8d428edf1aeb2187c18f82ca6757;tag=2.12.0"], self.d)
 
     @skipIfNoNetwork()
     def test_tag_rev_match5(self):
         # Test a url with SRCREV, rev= and tag= set works when using shallow clones
         self.d.setVar('BB_GIT_SHALLOW', '1')
-        self.d.setVar('SRCREV', 'aa0e540fc31a1c26839efd2c7785a751ce24ebfb')
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.7"], self.d)
+        self.d.setVar('SRCREV', '5b4e20377eea8d428edf1aeb2187c18f82ca6757')
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.12;protocol=https;rev=5b4e20377eea8d428edf1aeb2187c18f82ca6757;tag=2.12.0"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
 
@@ -3393,7 +3393,7 @@ class GitTagVerificationTests(FetcherTest):
     def test_tag_rev_match6(self):
         # Test a url with SRCREV, rev= and a mismatched tag= when using shallow clones
         self.d.setVar('BB_GIT_SHALLOW', '1')
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.6"], self.d)
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.12;protocol=https;rev=5b4e20377eea8d428edf1aeb2187c18f82ca6757;tag=2.8.0"], self.d)
         fetcher.download()
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.unpack(self.unpackdir)
@@ -3401,8 +3401,8 @@ class GitTagVerificationTests(FetcherTest):
     @skipIfNoNetwork()
     def test_tag_rev_match7(self):
         # Test a url with SRCREV, rev= and a mismatched tag=
-        self.d.setVar('SRCREV', 'aa0e540fc31a1c26839efd2c7785a751ce24ebfb')
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.8;protocol=https;rev=aa0e540fc31a1c26839efd2c7785a751ce24ebfb;tag=2.8.6"], self.d)
+        self.d.setVar('SRCREV', '5b4e20377eea8d428edf1aeb2187c18f82ca6757')
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake;branch=2.12;protocol=https;rev=5b4e20377eea8d428edf1aeb2187c18f82ca6757;tag=2.8.0"], self.d)
         fetcher.download()
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.unpack(self.unpackdir)

---
base-commit: c889d766575bd8dc664d07157961fd7b3869958b
change-id: 20250918-mathieu-selftest-fix-tag-removal-3bf93d6659a4

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


