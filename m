Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB26EC47DD9
	for <webhook@archiver.kernel.org>; Wed, 28 Feb 2024 22:40:08 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.11012.1709159999232980387
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Feb 2024 14:39:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FUtfURZY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51321e71673so209409e87.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Feb 2024 14:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709159997; x=1709764797; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+wJjkssPRpXxOvvP0eQ7lyXPbJoeZ5c32EyATDj1yr8=;
        b=FUtfURZYJhOBitLX15kkVxPSYU2lR7f+XSq8YXqhGcsaLmAWsvv0tdpFZ1LiQnl78T
         DQhgnRbZzf3PYL8D2R4XdWKoG+ki/imMrjQptdo/1X2d+D1oNhxNHcqKHVHfMmT/vTv4
         ExsIMshO4CXgU0daFnSLh3XgCPkAyo9S0x12I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709159997; x=1709764797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wJjkssPRpXxOvvP0eQ7lyXPbJoeZ5c32EyATDj1yr8=;
        b=rgrcKUtFOyd/e4H9IlDQ/2g/Q4NW8/ttXOSqn35Bcb8twkp8+pzH82pVxF3pwE//Bm
         apltZ+S+r4r7XpznA39QF8sS0g0/Yl4mE8gbMzjj89MQ+juLTGaQ0NbT7Z3Kj8wRGvzf
         MAmU6hRJ58vmVg53NDGFFmCb4AVZhzx4UOkST9kZyZ5Qy237DszyBHLykL8Dof3wfVvB
         D1kjglTl7X/u88vcHpqNeTpD/lPQiVZESskmOsocGsF5eGWYn2G3mX1oNl+c+uJCyufF
         RKeVOWfPP7aUUNrBZ+GaDdd93dbpbcWx5w4eLrna0DkX/iA4L7sOMI4HHEj/wdsawXpI
         azBA==
X-Gm-Message-State: AOJu0Yxb8joJSACHASEKzx1HjbT6eklic5IPdYHBy6ISd7qewXhWS13J
	7H8vS0M6t/wYDwRB0OLIBKpOPrUm7m6Cj2xRG8ySLp+d7kOvJLG6LkZm58JcTewbQS2mP3HoS78
	L
X-Google-Smtp-Source: AGHT+IHJSU7/PiZjJnUoIEcuOfjbwF7us4MUTIJwUy4PES+ylcumz/1au3PUWovxBIYin8rypQnzzQ==
X-Received: by 2002:ac2:4109:0:b0:512:d89e:946 with SMTP id b9-20020ac24109000000b00512d89e0946mr153704lfi.44.1709159996753;
        Wed, 28 Feb 2024 14:39:56 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:dfc0:7799:bd76:6cd8])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c290c00b00412b4576316sm3048086wmd.45.2024.02.28.14.39.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 14:39:56 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/git: Avoid clean upon failure
Date: Wed, 28 Feb 2024 22:39:55 +0000
Message-Id: <20240228223955.1651076-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Feb 2024 22:40:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15977

Currently when git fetches fail, it destroys all the existing local clone data.
For large repositories this can introduce long build delays when for example,
you just typo'd the git revision hash.

The git fetcher should be able to recover most directories so when the fetch is
for a git repo, avoid removing things unless clean is explicitly called
(e.g. a -c cleanall task).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 11 +++++++++--
 lib/bb/fetch2/git.py      |  3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ac0f4dfa1d..3529531ca1 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1115,7 +1115,8 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
             logger.debug("Mirror fetch failure for url %s (original url: %s)" % (ud.url, origud.url))
             logger.debug(str(e))
         try:
-            ud.method.clean(ud, ld)
+            if ud.method.cleanup_upon_failure():
+                ud.method.clean(ud, ld)
         except UnboundLocalError:
             pass
         return False
@@ -1440,6 +1441,12 @@ class FetchMethod(object):
         """
         return False
 
+    def cleanup_upon_failure(self):
+        """
+        When a fetch fails, should clean() be called?
+        """
+        return True
+
     def verify_donestamp(self, ud, d):
         """
         Verify the donestamp file
@@ -1885,7 +1892,7 @@ class Fetch(object):
                             logger.debug(str(e))
                         firsterr = e
                         # Remove any incomplete fetch
-                        if not verified_stamp:
+                        if not verified_stamp and m.cleanup_upon_failure():
                             m.clean(ud, self.d)
                         logger.debug("Trying MIRRORS")
                         mirrors = mirror_from_string(self.d.getVar('MIRRORS'))
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b43ee0da39..b9dc576d47 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -150,6 +150,9 @@ class Git(FetchMethod):
     def supports_checksum(self, urldata):
         return False
 
+    def cleanup_upon_failure(self):
+        return False
+
     def urldata_init(self, ud, d):
         """
         init git specific variable within url data
-- 
2.40.1


