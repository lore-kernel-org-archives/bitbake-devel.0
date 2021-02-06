Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web12.13799.1612652940379160459
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 15:09:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=O8shC5IE;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: akuster808@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id t2so827244pjq.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 15:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=O+Ymr/8+GYxEI2d0iKgTesN2TU0Hz6zw+1aRn7T8seg=;
        b=O8shC5IE+8zgI+WVAvSdwiIKRGIJ2Y8Eu3JTNw3gY2mAGu64G0yeHu6Aoq7na3LRSd
         M0JRe1oJAr3pSwUmQdA3E0HjsOgd1q74mu/4t5BArq+iQagfszG2s/Om+xgOnmLjU7QF
         DBATPZtPYAvz7edTxgHkZ6V+oH9e0m6IgURYGxmQ39kXQ7VGprWnXpbQ7nM7I789y7Sn
         Dso0WmRBzUBuFU1iY2SE3x8dxx9SWIwu1XmFwn4jhN1NDSrtgT6RT33Fyeyw8a+1kO7c
         O+pl/WrZlf8DEMUpaxbtU6f7Y+CUNpB9cBjoWY2BqGTijwhU5wsZQRL6xRVhVzA0Vefr
         uc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=O+Ymr/8+GYxEI2d0iKgTesN2TU0Hz6zw+1aRn7T8seg=;
        b=PWrtp4DXG0TsW/zoKmTOf5uCUab8MYrN9SWRpOXitkk/SmEt1y7rsvKgmV/pM/fMHB
         vowINwj9acDMf78jlhmpXMNyFj1xaDqJPxGZdKvDIEZvMTF92puvqrNagzLjfWyS2//p
         CtChVxtN2T9diugqee1w786N3IyTHUeaQY7FyPc6azOjqchoAsB9IuA5Id2FE0aQ1/3i
         Ck8qXIY4apQWdPN17TcQnF8Yeg0khYdnVmuRomwVELe4O3Ga7w25BrSJ+v03pB3c62IW
         PsUl652imD5dLCzXI6w15qQ6CCHwG96sfJiDLm2OzbfWr7bV279VjXz68MxXf+rSv4bT
         krow==
X-Gm-Message-State: AOAM531ejSMVIBkBjtCgwtYHCPvhOJLJ0HuAzQsBnEXnKYas3z6+Po3x
	+OQFeByc/SlQALSDy8MuZql0vPBGNjdLgw==
X-Google-Smtp-Source: ABdhPJzKy1uQu2s6XiIUT746+nQGlQ6MUPRWXa7TogWggi9jEkle83ch65umfD7WFtd6Cl51lorQUg==
X-Received: by 2002:a17:90b:3753:: with SMTP id ne19mr10165325pjb.72.1612652939735;
        Sat, 06 Feb 2021 15:08:59 -0800 (PST)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:c5c4:f80e:4f44:b02e])
        by smtp.gmail.com with ESMTPSA id k10sm14492489pfk.0.2021.02.06.15.08.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 15:08:58 -0800 (PST)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [gatesgargh 07/10] giflib: apply patch for CVE-2019-15133 and set CVE_PRODUCT
Date: Sat,  6 Feb 2021 15:08:44 -0800
Message-Id: <4e6de3045c96fce9516311ba42911e209a1b84ba.1612652802.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1612652802.git.akuster808@gmail.com>
References: <cover.1612652802.git.akuster808@gmail.com>

From: Mikko Rapeli <mikko.rapeli@bmw.de>

Backport upstream patch for CVE-2019-15133.
Set CVE_PRODUCT to "giflib_project:giflib" which is used
in NVD. https://nvd.nist.gov/vuln/detail/CVE-2019-15133

Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../giflib/files/CVE-2019-15133.patch         | 23 +++++++++++++++++++
 .../recipes-devtools/giflib/giflib_5.1.4.bb   |  7 +++++-
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 meta-oe/recipes-devtools/giflib/files/CVE-2019-15133.patch

diff --git a/meta-oe/recipes-devtools/giflib/files/CVE-2019-15133.patch b/meta-oe/recipes-devtools/giflib/files/CVE-2019-15133.patch
new file mode 100644
index 0000000000..9957be82f3
--- /dev/null
+++ b/meta-oe/recipes-devtools/giflib/files/CVE-2019-15133.patch
@@ -0,0 +1,23 @@
+From 799eb6a3af8a3dd81e2429bf11a72a57e541f908 Mon Sep 17 00:00:00 2001
+From: "Eric S. Raymond" <esr@thyrsus.com>
+Date: Sun, 17 Mar 2019 12:37:21 -0400
+Subject: [PATCH] Address SF bug #119: MemorySanitizer: FPE on unknown address
+
+---
+ dgif_lib.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+Upstream-status: Backport [https://sourceforge.net/p/giflib/code/ci/799eb6a3af8a3dd81e2429bf11a72a57e541f908/]
+CVE: CVE-2019-15133
+
+--- a/lib/dgif_lib.c	2021-01-13 19:28:18.923493586 +0100
++++ b/lib/dgif_lib.c	2021-01-13 19:28:55.245863085 +0100
+@@ -1099,7 +1099,7 @@ DGifSlurp(GifFileType *GifFile)
+ 
+               sp = &GifFile->SavedImages[GifFile->ImageCount - 1];
+               /* Allocate memory for the image */
+-              if (sp->ImageDesc.Width < 0 && sp->ImageDesc.Height < 0 &&
++              if (sp->ImageDesc.Width <= 0 && sp->ImageDesc.Height <= 0 &&
+                       sp->ImageDesc.Width > (INT_MAX / sp->ImageDesc.Height)) {
+                   return GIF_ERROR;
+               }
diff --git a/meta-oe/recipes-devtools/giflib/giflib_5.1.4.bb b/meta-oe/recipes-devtools/giflib/giflib_5.1.4.bb
index 21fa352cdc..1871bab46e 100644
--- a/meta-oe/recipes-devtools/giflib/giflib_5.1.4.bb
+++ b/meta-oe/recipes-devtools/giflib/giflib_5.1.4.bb
@@ -3,7 +3,12 @@ SECTION = "libs"
 LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://COPYING;md5=ae11c61b04b2917be39b11f78d71519a"
 
-SRC_URI = "${SOURCEFORGE_MIRROR}/giflib/${BP}.tar.bz2"
+SRC_URI = " \
+    ${SOURCEFORGE_MIRROR}/giflib/${BP}.tar.bz2 \
+    file://CVE-2019-15133.patch \
+"
+
+CVE_PRODUCT = "giflib_project:giflib"
 
 inherit autotools
 
-- 
2.17.1

