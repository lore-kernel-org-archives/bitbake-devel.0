Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A69AC5CFEB
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 12:48:42 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18285.1786625318989385700
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Aug 2026 05:48:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AyBi8dlJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47db714766aso547881f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786625317; x=1787230117; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gpWXLK9Jg20sWquk/z2KwTUPYeWOiL6yqMQ40E+L4oM=;
        b=AyBi8dlJvQ6RoIo3dv435JF53p/K1OzDJk0OZ2JiXRSq1ANId8GSRJGCiPDRAOY3ky
         hy9fiwuv4/gF6pZ1woI2z8nZhxVNro/GfRhKGor2bohgIeODGvQ+WBcMvu2X04pCOSNh
         7D822fYLU51KsTfkRFqJEhbpd8x6mBH1R+gT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625317; x=1787230117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gpWXLK9Jg20sWquk/z2KwTUPYeWOiL6yqMQ40E+L4oM=;
        b=jrPNmQ1IJnT8RmZ9fucnAAjRwQDiIO8N/veo3G+v4L6LwduLFI9reXJY4CwsgyNcPf
         Ti7cTC4cxPwRuVHhVxSoSDF/n4w4oP3G1lGC5Zi3/4GgK2yq8D0yZES2kvE0Tggr0odR
         7c9HTpnjzm59tiNLPqyl/0FID75QTohvWL4bLEP85w4oZ7DVikeNqUZk862HlP6+hl5l
         MBNmhKCIM0MSh7A/WM2OyS3bB3C27D6LDDEs/t5xYJThjylj7vm7IfmQOiJ109tDqm7I
         QsxRx/0IuYh4+y0ryZ7JKO1ct1zJq7wpORAafX4BiRtnon5FQAo3300whB8NzzVfg9Dr
         HwMQ==
X-Gm-Message-State: AOJu0YwA6MpOHx5q1MesrK4INRbDvpyxYjOxkere7MwCCQaHF/vnuhHZ
	3Ofit7pSgu6NzsaDEc/e2SMI3Cw8TSXPYD+NXKPRMGaG/0JxkWG3uJtEgr2iDXTkbP2eRR/tBHO
	zpwKUg1E=
X-Gm-Gg: AR+sD11Stjegd+dXDtcaqlMwLMWn2IfkmjvWwgUCUgXgkmMLSqUSxjYYUO0M0Px/H5y
	91OdEedhMkH4evnMImdoOWvvwDt0bu2+HJQ5fAo2THlrChp9QKh6nmTqh5iEG/bDuOkh6w5h5pe
	ravgI41lu6kwn2iQtxXVI5ax8BxPbrNfi6UqsjG5jxCsQm3XMAoBnmbM4RVnYbpVw4vsUoqFE5p
	7+oiPOT4lYm1DGpgUmMzrfyaRKjyZo9+7WRiEnV4a26Ng2A6uDfK9FfCWe3IqZctoIy4LcfGVcm
	Gw0quOJtLTnwTVIVqi/fSAdayDUjUFXEt+VMM2S0b6SdHkifpDXt2nOoBL0UO+e41yUdOSN34vx
	WEo8e1RiASkvaj1C/dSnLEFJy03cOivU5zePTUkLLPmQvdHtOHNI4x9hNFp2V0smujqXwU6RFIW
	0wG+BPtQ6h2isxZEZZ75DwT9kMVF1gG/SbmLXhedQBb6YmzXf6I0ITxRhGWXOXhJxcQULnaxgpr
	1QCP9yjuiQ7gmThgg==
X-Received: by 2002:a05:6000:2c0e:b0:481:314b:b041 with SMTP id ffacd0b85a97d-4815a5c9325mr7283285f8f.7.1786625316712;
        Thu, 13 Aug 2026 05:48:36 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e77b:339c:e0c2:6c8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6616sm6685768f8f.25.2026.08.13.05.48.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:48:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/6] fetch/__init__: Clean up minor mirror code duplication
Date: Thu, 13 Aug 2026 13:48:29 +0100
Message-ID: <20260813124834.1770307-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 12:48:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19923

The mirror_from_string calls can be in try_mirror along with the
debug logging.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ea007f36816..604208c2c82 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1183,15 +1183,18 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
         if ud.lockfile and ud.lockfile != origud.lockfile:
             bb.utils.unlockfile(lf)
 
-def try_mirrors(fetch, d, origud, mirrors, check = False):
+def try_mirrors(fetch, d, origud, mirrorvar, check = False):
     """
     Try to use a mirrored version of the sources.
     This method will be automatically called before the fetchers go.
 
     d Is a bb.data instance
     uri is the original uri we're trying to download
-    mirrors is the list of mirrors we're going to try
+    mirrorvar is variable name that contains the list of mirrors we're going to try
     """
+    logger.debug("Trying mirrors in %s" % mirrorvar)
+    mirrors = mirror_from_string(d.getVar(mirrorvar))
+
     ld = d.createCopy()
 
     uris, uds = build_mirroruris(origud, mirrors, ld)
@@ -1716,11 +1719,11 @@ class FetchMethod(object):
         """
         return True
 
-    def try_mirrors(self, fetch, urldata, d, mirrors, check=False):
+    def try_mirrors(self, fetch, urldata, d, mirrorvar, check=False):
         """
         Try to use a mirror
         """
-        return bool(try_mirrors(fetch, d, urldata, mirrors, check))
+        return bool(try_mirrors(fetch, d, urldata, mirrorvar, check))
 
     def checkstatus(self, fetch, urldata, d):
         """
@@ -1921,9 +1924,7 @@ class Fetch(object):
                 if m.verify_donestamp(ud, self.d) and not m.need_update(ud, self.d):
                     done = True
                 elif m.try_premirror(ud, self.d):
-                    logger.debug("Trying PREMIRRORS")
-                    mirrors = mirror_from_string(self.d.getVar('PREMIRRORS'))
-                    done = m.try_mirrors(self, ud, self.d, mirrors)
+                    done = m.try_mirrors(self, ud, self.d, 'PREMIRRORS')
                     if done:
                         try:
                             # early checksum verification so that if the checksum of the premirror
@@ -1975,9 +1976,7 @@ class Fetch(object):
                         # Remove any incomplete fetch
                         if not verified_stamp and m.cleanup_upon_failure():
                             m.clean(ud, d)
-                        logger.debug("Trying MIRRORS")
-                        mirrors = mirror_from_string(d.getVar('MIRRORS'))
-                        done = m.try_mirrors(self, ud, d, mirrors)
+                        done = m.try_mirrors(self, ud, d, 'MIRRORS')
 
                 if not done or not m.done(ud, d):
                     if firsterr:
@@ -2027,14 +2026,13 @@ class Fetch(object):
             logger.debug("Testing URL %s", u)
             # First try checking uri, u, from PREMIRRORS
             mirrors = mirror_from_string(self.d.getVar('PREMIRRORS'))
-            ret = m.try_mirrors(self, ud, self.d, mirrors, True)
+            ret = m.try_mirrors(self, ud, self.d, 'PREMIRRORS', True)
             if not ret:
                 # Next try checking from the original uri, u
                 ret = m.checkstatus(self, ud, self.d)
                 if not ret:
                     # Finally, try checking uri, u, from MIRRORS
-                    mirrors = mirror_from_string(self.d.getVar('MIRRORS'))
-                    ret = m.try_mirrors(self, ud, self.d, mirrors, True)
+                    ret = m.try_mirrors(self, ud, self.d, 'MIRRORS', True)
 
             if not ret:
                 raise FetchError("URL doesn't work", u)

