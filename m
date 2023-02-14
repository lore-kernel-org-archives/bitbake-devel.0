Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B900C64ED6
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 15:29:05 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.10125.1676388535337673768
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 07:28:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=xCCI0Qyb;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.47, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f47.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so15781446pjw.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 07:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDZQZ5e5bNYaIXGrexir6Bw3vRchVsJq2enTL0Yef3E=;
        b=xCCI0QybNjpv6UziHUXf2qtHWEdPYMG44LEqNlyZcguePbtm+Gk0cETyO5ZXxEM6f8
         Jr2u/K8jbOiVlM366e6dRe7BT6Xmf0DPKO1HyjmTTL1R45zpEyYNhxSSeR74k91E7abm
         t33Nzp6c4KeaP1IbD4fHYgvFYqwNHrM6uGVLjM7dg8+zEmqA7+WCenCJyRAR6+3GkKa0
         17XTZlEkohr9zZP9yv/LwaUrTiZSbrorn+9jD7rgFfDqsvJ2xn1dO+oMHbEVOGsgyT0I
         JteR5GdBZReo5KGw1QI2zYWV/gtWvkd2P4+hwJzgzGzOIl0J01tq2JVZE+pE5IqWvf5/
         6h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDZQZ5e5bNYaIXGrexir6Bw3vRchVsJq2enTL0Yef3E=;
        b=cbQ44ek1NudPYBFEY5ZH6cT3D+wz3FBRSuW5nGxEkX2lvGZYnwqHmQmUNMHkcWpMsJ
         ns1lmD8rH2hhheokekkeDehkMFCSSxaOfZSpsPWoz4fWdUqJWEPsnFgXnPHGgLrhgSra
         Ep66I0+GmNNkCPKh1YQ/pKtWt2JzOOnuuPxgY1UaoayUAjG1sJDs3rbwrdfYf7JCHjaa
         YhG3dTOIRwCSnIEL4UD9sqv5m3jfV8GkR0wa2p0FZ/OI1js1lrriPZw2ifMycrxFZCis
         tDcBGw1nlM+rcS74Xup6UVW6sQagfuAgyJVQrRGF3CaBslZ+jQ6Gbp4lT6tqE5zs5avk
         twnw==
X-Gm-Message-State: AO0yUKXYCfTib7lhH1HlC5TJ98mri1nXGGv15tO4A6vWm0Z3NB8YWNhw
	UBGSUy2BDQlpNwNgH/Zeh4+uU8cHisMdE7xir24=
X-Google-Smtp-Source: AK7set/vbqI/FO6n8AMrsmi1Ksaw5x0j0+4ZMaz/PCZ65yELZ9zkOsSa0Q/cfA541BMTY5eBcwKVqA==
X-Received: by 2002:a17:90b:1e0a:b0:231:70e:964e with SMTP id pg10-20020a17090b1e0a00b00231070e964emr2864847pjb.35.1676388534347;
        Tue, 14 Feb 2023 07:28:54 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090a5a4300b00233cde36909sm5624203pji.21.2023.02.14.07.28.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:28:53 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 2/4] utils/ply: Update md5 to better report errors with hashlib
Date: Tue, 14 Feb 2023 05:28:42 -1000
Message-Id: <d26ed38c233583b35ad1451e521f07d9c2329f4e.1676388410.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676388410.git.steve@sakoman.com>
References: <cover.1676388410.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 15:29:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14416

From: Mark Hatle <mark.hatle@kernel.crashing.org>

In the case where hashlib is not available, the try would fail and fall
through resulting in a backtrace on the usage of the 'sig'.  The backtrace
itself was confusing and made it difficult to determine what went wrong.

Update the import to be in it's own try block with an appropriate
message to indicate what went wrong.

Note, the current version of ply all of this code has been restructured
so this is not applicable upstream.

Additionally, some versions of hashlib don't appear to implement the
second FIPS related argument.  Detect this and support both versions.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
(cherry picked from commit 484ab42f440070c0369b81f5c69da860fa47a798)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/utils.py | 7 ++++++-
 lib/ply/yacc.py | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 66a8a08c..bca4830f 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -545,7 +545,12 @@ def md5_file(filename):
     Return the hex string representation of the MD5 checksum of filename.
     """
     import hashlib
-    return _hasher(hashlib.new('MD5', usedforsecurity=False), filename)
+    try:
+        sig = hashlib.new('MD5', usedforsecurity=False)
+    except TypeError:
+        # Some configurations don't appear to support two arguments
+        sig = hashlib.new('MD5')
+    return _hasher(sig, filename)
 
 def sha256_file(filename):
     """
diff --git a/lib/ply/yacc.py b/lib/ply/yacc.py
index 767c4e46..381b50cf 100644
--- a/lib/ply/yacc.py
+++ b/lib/ply/yacc.py
@@ -2798,7 +2798,14 @@ class ParserReflect(object):
     def signature(self):
         try:
             import hashlib
+        except ImportError:
+            raise RuntimeError("Unable to import hashlib")
+        try:
             sig = hashlib.new('MD5', usedforsecurity=False)
+        except TypeError:
+            # Some configurations don't appear to support two arguments
+            sig = hashlib.new('MD5')
+        try:
             if self.start:
                 sig.update(self.start.encode('latin-1'))
             if self.prec:
-- 
2.34.1


