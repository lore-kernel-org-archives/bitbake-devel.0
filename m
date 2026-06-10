Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178BECD8CB2
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 15:47:10 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23621.1781106426011574308
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 08:47:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Hg6RrjiX;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 324BCC4FEE2
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 15:47:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3CDC25FFC9
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 15:47:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 957D9106B9B10;
	Wed, 10 Jun 2026 17:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781106423; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KQ7QAOZ5rBEuaGkDgs8R1jtxCbesWFDzxDQNctSpyvU=;
	b=Hg6RrjiXjA8nRSjTVlzaPsXQiVt1WCu8TgBGNrb2HKLcpkb30KUjiIhfhYEdRtECb+mPkF
	0wbvUZAUPi1wvoibFgEG4hNJPTF22bafO5aOHI6Mi1shJ6bfgjRfQR2bvY5kEKwTpZVa36
	xozI34fHtYUmKSkvF9RrfXN5DhGQ/oPoa0OXUbPTf0FPTXKfRV7w5KqfjEwiYjCXsmGtVq
	/dP+hz//NZSsu4D7Kke0i6uoP17LaO8CyytB+4XCHe9ORLlzthAemzUDskNRrAU5WxXb7e
	PnWsHcJvFDc74O3xUGlATZT60ApxJOFPGO0XtxLQtuk5YLma1ZcZDDbnM47nHQ==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Date: Wed, 10 Jun 2026 17:47:00 +0200
Subject: [bitbake-devel][PATCH 1/2] fetch/npmsw: fix security issue and
 re-enable fetcher
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-dev-tprrt-fix-npm-v1-1-9bf501d4ee0e@bootlin.com>
References: <20260610-dev-tprrt-fix-npm-v1-0-9bf501d4ee0e@bootlin.com>
In-Reply-To: <20260610-dev-tprrt-fix-npm-v1-0-9bf501d4ee0e@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Perrot <thomas.perrot@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 15:47:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19643

The npmsw fetcher was disabled in 355cd226 (Jan 2026) along with the npm
fetcher, but its security model is already correct: checksums come from
the locally-committed npm-shrinkwrap.json file, not from the network.

Re-enable it with the following fixes:
- Add the missing FetchError import that would cause a NameError on
  malformed shrinkwrap files.
- Change 'if not packages' to 'if packages is None' in
  foreach_dependencies so a valid zero-dependency shrinkwrap
  (packages={}) no longer raises FetchError.
- Add 'elif resolved is None' guard before the startswith chain in
  _resolve_dependency so missing 'resolved' fields raise ParameterError
  instead of AttributeError.

[YOCTO #16105]

Fixes: 355cd226e072 ("fetch2/npm: Disable npm/npmsw fetchers due to security issues")
Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 lib/bb/fetch2/npmsw.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 5255e8b465e1..f09ea5794856 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -21,6 +21,7 @@ import json
 import os
 import re
 import bb
+from bb.fetch2 import FetchError
 from bb.fetch2 import Fetch
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import ParameterError
@@ -44,7 +45,7 @@ def foreach_dependencies(shrinkwrap, callback=None, dev=False):
             location = the location of the package (string)
     """
     packages = shrinkwrap.get("packages")
-    if not packages:
+    if packages is None:
         raise FetchError("Invalid shrinkwrap file format")
 
     for location, data in packages.items():
@@ -63,11 +64,7 @@ class NpmShrinkWrap(FetchMethod):
 
     def supports(self, ud, d):
         """Check if a given url can be fetched with npmsw"""
-        #return ud.type in ["npmsw"]
-        if ud.type in ["npmsw"]:
-            from bb.parse import SkipRecipe
-            raise SkipRecipe("The npmsw fetcher has been disabled due to security issues and there is no maintainer to address them")
-        return False
+        return ud.type in ["npmsw"]
 
     def urldata_init(self, ud, d):
         """Init npmsw specific variables within url data"""
@@ -126,6 +123,9 @@ class NpmShrinkWrap(FetchMethod):
                 extrapaths.append(resolvefile)
 
             # Handle http tarball sources
+            elif resolved is None:
+                raise ParameterError("Missing 'resolved' field for dependency '%s'" % name, ud.url)
+
             elif resolved.startswith("http") and integrity:
                 localfile = npm_localfile(os.path.basename(resolved))
 

-- 
2.54.0


