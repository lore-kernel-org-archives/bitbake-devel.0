Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D115CAC5AE
	for <webhook@archiver.kernel.org>; Wed, 24 Sep 2025 14:34:39 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.15422.1758724475747069873
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Sep 2025 07:34:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=X1LC3yRg;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: quaresma.jose@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso48724175e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724473; x=1759329273; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sikCXJkbbygof3bsg/f9A05Vy0V72WZdkorp6g5i8+c=;
        b=X1LC3yRgSUmzd7RdgGg+8eZh4EuQfQfmwqQie7TBdNZ6K1Exn/CFIYMlNo5fPsj0rd
         H1gLn5Pw7m4XWAQfjQZGfOpTqtflAPN5GUqc6XgDz9mbw8yPCTIQHyDnvpzz4gsJPEBo
         b5a7uwtsATrk59U76Eibtjtk/QZ8YSY/PyfvjSawsIHcOdmrRI3JNuDq+MIEMusuJKoR
         xt0k/E+3ehNjy9lhvaRHFUHjHfAmKL0SvxjXeIEQLInBlYpCjmdketq1BlfPKdOGu2N2
         NKT17pG9mXgsj8mesW22xca0SsZ6B6eQHGfmszR2ZU+VOsMyi+RkgalvX6ug1gVmpN5E
         X6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724473; x=1759329273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sikCXJkbbygof3bsg/f9A05Vy0V72WZdkorp6g5i8+c=;
        b=VVWeyJXZOMNIWjdECy79WQ/+u5ziIQLQIRKW7U/yyizMWQXlG534/8T/AZHqXe83KY
         YXrCSiP0Cn8AvBDgVPOJ/u5RGS1BsROwQnCGlWrKmU0cb17rLtbekXsY6D5RJtTlYvYq
         1oas6SjfdL9tdvQ5n5UcYn8085jnBfPiRIoyKP3Z3D/X/iHCr8kHOk/SwRcw60c5xjzg
         3N7D+Ykb+0oFsy+rbFMBEi7tgiG4TpiYUVVlLVxYcCp/FgWAZunNF4MQ8ztpTiNjaPLI
         A81BHnBAIfzbqtK8fwl/3p0hCY2R9e51rdnNAwN2DEicagoBeB9CL/bCHiImgYDT8VEB
         H8DA==
X-Gm-Message-State: AOJu0YzECmwK+AxyEQpVy8RiR6c6W6GUDittxc3JLz8C+8TvAk/mmhUN
	/diaNUUeoGdbj3E6/bdG4McHapfU+fqa4a0pOw7FyUc9YllmIth/uBtyzcKdEh3F
X-Gm-Gg: ASbGncuix+SO+lrYEiAkGxfwsOT/djwHm1rBPeQgEgts/QgIqzd6O8gzIF55RaJ1nO6
	DkcDzsu+B1zVcRlKLXqWzhFEPzs9Xg9QcYZZXLjpg4b8i2HteUw/z2ZLTv/Lv+adMc9qbjkKmjg
	PxFgGCOPjSB1cVLh4eJt/umsu0FbKFny4RgS+0cjZSwjsYlX5jtxuEdmyFBiO/jF0SklzHLGye9
	24UWh/uRz6lqiHtuTwOovO4yoiNSgCa3fvhBkWbVgj3lj+0lu9GOplY2wIMP7o6kSp6MvvwdAmK
	DNe50M60eiYYRjfVcBj8GZEANYkoD0pnf1VlMZ3Jq279LgmUFFF/ZBTREiF7Lt16PNpinw2MGTv
	Pfk1zFS58PZJ2scEITrm9Og==
X-Google-Smtp-Source: AGHT+IELzqhTuT6v2qRkY+HLYBV0M9Ea/snNUs7QSkSZyeCn9xObyBVIxe6GTQyrAf17guEHmY84Sg==
X-Received: by 2002:a05:600c:8010:b0:45c:b5eb:b0c6 with SMTP id 5b1f17b1804b1-46e329a805amr1033555e9.5.1758724472964;
        Wed, 24 Sep 2025 07:34:32 -0700 (PDT)
Received: from fio ([185.228.162.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2aadc319sm35255855e9.18.2025.09.24.07.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:34:31 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [RFC PATCH v2] cooker: add support for more than one server in BB_HASHSERVE_UPSTREAM
Date: Wed, 24 Sep 2025 15:33:31 +0100
Message-ID: <20250924143330.949050-2-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 14:34:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18090

From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>

Making the use of python websockets mandatory when connecting to hashserve could
create several difficulties for users, especially when the python-python is not
available in the distribution used.
So it will be better to have a list of servers where for example we can
have a second fallback in case it is not possible to use the first one.

If it is not possible to use any server from the specified list, this will
cause a fatal error.

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---

V2:
- rebased on master-next
- change the fatal error message

 lib/bb/cooker.py | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 03f262ac1..eedd35382 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -312,24 +312,30 @@ class BBCooker:
             # Create a new hash server bound to a unix domain socket
             if not self.hashserv:
                 dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
-                upstream = self.data.getVar("BB_HASHSERVE_UPSTREAM") or None
-                if upstream:
-                    try:
-                        with hashserv.create_client(upstream) as client:
-                            client.ping()
-                    except ImportError as e:
-                        bb.fatal(""""Unable to use hash equivalence server at '%s' due to missing or incorrect python module:
+                upstream = None
+                hashserve_upstream = self.data.getVar("BB_HASHSERVE_UPSTREAM") or None
+                if hashserve_upstream:
+                    for server in hashserve_upstream.split():
+                        try:
+                            with hashserv.create_client(server) as client:
+                                client.ping()
+                                upstream = server
+                                break
+                        except ImportError as e:
+                            bb.warn("""Unable to use hash equivalence server at '%s' due to missing or incorrect python module:
 %s
 Please install the needed module on the build host, or use an environment containing it:
  - if you are using bitbake-setup, run 'bitbake-setup install-buildtools'
  - openembedded-core layer contains 'scripts/install-buildtools' that can also be used
- - or set up pip venv
-You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in significantly longer build times as bitbake will be unable to reuse prebuilt sstate artefacts."""
+ - or set up pip venv"""
                                  % (upstream, repr(e)))
-                    except ConnectionError as e:
-                        bb.warn("Unable to connect to hash equivalence server at '%s', please correct or remove BB_HASHSERVE_UPSTREAM:\n%s"
-                                 % (upstream, repr(e)))
-                        upstream = None
+                        except ConnectionError as e:
+                            bb.warn("Unable to connect to hash equivalence server at '%s' due to connection error:\n%s"
+                                    % (server, repr(e)))
+
+                    if not upstream:
+                        bb.fatal("""Unable to any of the hash equivalence servers provided in BB_HASHSERVE_UPSTREAM:
+You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in significantly longer build times as bitbake will be unable to reuse prebuilt sstate artefacts.""")
 
                 self.hashservaddr = "unix://%s/hashserve.sock" % self.data.getVar("TOPDIR")
                 self.hashserv = hashserv.create_server(
-- 
2.51.0


